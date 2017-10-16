//
//  TDEaseConversationListViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDEaseConversationListViewController.h"
#import "TDEaseChatViewController.h"

@interface TDEaseConversationListViewController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>

@property (nonatomic, strong) UIView *networkStateView;

@end

@implementation TDEaseConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self networkStateView];
    
    [self tableViewDidTriggerHeaderRefresh];
    [self removeEmptyConversationsFromDB];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations isDeleteMessages:YES completion:nil];
    }
}

#pragma mark - getter

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - EaseConversationListViewControllerDelegate
//跳转聊天界面
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
                UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
                chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#else
                chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
#endif
                chatController.title = conversationModel.title;
                [self.navigationController pushViewController:chatController animated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//            model.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//        } else {
//            UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:conversation.conversationId];
//            if (profileEntity) {
//                model.title = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
//                model.avatarURLPath = profileEntity.imageUrl;
//            }
//        }
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        NSString *imageName = @"EaseUIResource.bundle/group";
        if (![conversation.ext objectForKey:@"subject"])
        {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        NSDictionary *ext = conversation.ext;
        model.title = [ext objectForKey:@"subject"];
        imageName = [[ext objectForKey:@"isPublic"] boolValue] ? @"EaseUIResource.bundle/group" : @"EaseUIResource.bundle/group";
        model.avatarImage = [UIImage imageNamed:imageName];
    }
    return model;
}

- (NSAttributedString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        NSString *latestMessageTitle = @"";
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return attributedStr;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    return latestMessageTime;
}

#pragma mark - private


#pragma mark - public

-(void)refresh
{
    [self refreshAndSortView];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

@end

