//
//  TDEaseChatContactListViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/14.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDEaseChatContactListViewController.h"
#import "TDEaseChatViewController.h"
//#import "RobotListViewController.h"
//#import "ChatroomListViewController.h"
//#import "AddFriendViewController.h"
//#import "ApplyViewController.h"
//#import "UserProfileManager.h"
//#import "RealtimeSearchUtil.h"
//#import "UserProfileManager.h"
//#import "RedPacketChatViewController.h"
//
//#import "BaseTableViewCell.h"
//#import "UIViewController+SearchController.h"

@interface TDEaseChatContactListViewController ()<UISearchBarDelegate, UIActionSheetDelegate, EaseUserCellDelegate>
{
    NSIndexPath *_currentLongPressIndex;
}

@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (strong, nonatomic) NSMutableArray *contactsSource;

@property (nonatomic) NSInteger unapplyCount;

@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic, strong) NSArray *otherPlatformIds;

@end

@implementation TDEaseChatContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.showRefreshHeader = YES;
    
    _contactsSource = [NSMutableArray array];
    _sectionTitles = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tableViewDidTriggerHeaderRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataArray count] + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return [self.otherPlatformIds count];
    }
    
    return [[self.dataArray objectAtIndex:(section - 2)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"newFriends"];
            cell.titleLabel.text = NSLocalizedString(@"title.apply", @"Application and notification");
            cell.avatarView.badge = self.unapplyCount;
            return cell;
        }
        
        NSString *CellIdentifier = @"commonCell";
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row == 1) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.group", @"Group");
        }
        else if (indexPath.row == 2) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.chatroom",@"chatroom");
        }
        else if (indexPath.row == 3) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.robotlist",@"robot list");
        }
        return cell;
    } else if (indexPath.section == 1) {
        NSString *CellIdentifier = @"OtherPlatformIdCell";
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.titleLabel.text = [self.otherPlatformIds objectAtIndex:indexPath.row];
        
        return cell;
        
    } else {
        NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSArray *userSection = [self.dataArray objectAtIndex:(indexPath.section - 2)];
        EaseUserModel *model = [userSection objectAtIndex:indexPath.row];
//        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.buddy];
//        if (profileEntity) {
//            model.avatarURLPath = profileEntity.imageUrl;
//            model.nickname = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
//        }
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.model = model;
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 0;
    }
    else{
        return 22;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.sectionTitles objectAtIndex:(section - 2)]];
    [contentView addSubview:label];
    return contentView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
//            [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
        }
        else if (row == 1)
        {
            //            if (_groupController == nil) {
            //                _groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
            //            }
            //            else{
            //                [_groupController reloadDataSource];
            //            }
//            GroupListViewController *groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
//            [self.navigationController pushViewController:groupController animated:YES];
        }
        else if (row == 2)
        {
//            ChatroomListViewController *controller = [[ChatroomListViewController alloc] initWithStyle:UITableViewStylePlain];
//            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (row == 3) {
//            RobotListViewController *robot = [[RobotListViewController alloc] init];
//            [self.navigationController pushViewController:robot animated:YES];
        }
    } else if (section == 1) {
        TDEaseChatViewController * chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:[self.otherPlatformIds objectAtIndex:indexPath.row] conversationType:EMConversationTypeChat];
        [self.navigationController pushViewController:chatController animated:YES];
    }
    else{
        EaseUserModel *model = [[self.dataArray objectAtIndex:(section - 2)] objectAtIndex:row];
        UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
//        chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
#else
        chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
#endif
        chatController.title = model.nickname.length > 0 ? model.nickname : model.buddy;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0 || indexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        EaseUserModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 2)] objectAtIndex:indexPath.row];
        if ([model.buddy isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notDeleteSelf", @"can't delete self") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        self.indexPath = indexPath;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"delete conversation", @"Delete conversation") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.indexPath == nil)
    {
        return;
    }
    
    NSIndexPath *indexPath = self.indexPath;
    EaseUserModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 2)] objectAtIndex:indexPath.row];
    self.indexPath = nil;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        if (buttonIndex == alertView.cancelButtonIndex) {
            error = [[EMClient sharedClient].contactManager deleteContact:model.buddy isDeleteConversation:NO];
        } else {
            error = [[EMClient sharedClient].contactManager deleteContact:model.buddy isDeleteConversation:YES];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                if ([weakSelf.dataArray count] >= indexPath.section) {
                    NSMutableArray *tmp = [weakSelf.dataArray objectAtIndex:(indexPath.section - 2)];
                    [tmp removeObject:model.buddy];
                    [weakSelf.contactsSource removeObject:model.buddy];
                    
                    [weakSelf.tableView reloadData];
                }
            }
            else{
                [weakSelf showHint:[NSString stringWithFormat:NSLocalizedString(@"deleteFailed", @"Delete failed:%@"), error.errorDescription]];
                [weakSelf.tableView reloadData];
            }
        });
    });
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex || _currentLongPressIndex == nil) {
        return;
    }
    
    NSIndexPath *indexPath = _currentLongPressIndex;
    EaseUserModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 2)] objectAtIndex:indexPath.row];
    _currentLongPressIndex = nil;
    
    [self hideHud];
    [self showHudInView:self.view hint:NSLocalizedString(@"wait", @"Pleae wait...")];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:model.buddy relationshipBoth:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (!error) {
                //由于加入黑名单成功后会刷新黑名单，所以此处不需要再更改好友列表
                [weakSelf reloadDataSource];
            }
            else {
                [weakSelf showHint:error.errorDescription];
            }
        });
    });
    
}

#pragma mark - EaseUserCellDelegate

- (void)cellLongPressAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return;
    }
    
    _currentLongPressIndex = indexPath;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"friend.block", @"join the blacklist") otherButtonTitles:nil, nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        weakself.otherPlatformIds = [[EMClient sharedClient].contactManager getContactsFromServerWithError:nil];

        dispatch_async(dispatch_get_main_queue(), ^{

                [weakself reloadDataSource];
        });
        [weakself tableViewDidFinishTriggerHeader:YES reload:NO];
    });
}

#pragma mark - public

- (void)reloadDataSource
{
    [self.dataArray removeAllObjects];
    [self.contactsSource removeAllObjects];
    
    NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
    
    for (NSString *buddy in buddyList) {
        [self.contactsSource addObject:buddy];
    }
    
    [self.tableView reloadData];
}

@end

