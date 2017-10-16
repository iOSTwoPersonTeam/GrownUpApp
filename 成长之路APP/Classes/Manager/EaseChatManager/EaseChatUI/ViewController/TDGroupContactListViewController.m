//
//  TDGroupContactListViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDGroupContactListViewController.h"
#import "TDGroupTableViewCell.h"
#import "TDEaseChatViewController.h"

@interface TDGroupContactListViewController ()< EMGroupManagerDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation TDGroupContactListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [NSMutableArray array];
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"群聊", @"Group");
    self.showRefreshHeader = YES;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    // Registered as SDK delegate
    [[EMClient sharedClient].groupManager removeDelegate:self];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataSource) name:@"reloadGroupList" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadDataSource];
}

- (void)dealloc
{
    [[EMClient sharedClient].groupManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";
    TDGroupTableViewCell *cell = (TDGroupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[TDGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {

        EMGroup *group = [self.dataSource objectAtIndex:indexPath.row];
        NSString *imageName = @"EaseUIResource.bundle/group";
        cell.imageView.image = [UIImage imageNamed:imageName];
        if (group.subject && group.subject.length > 0) {
            cell.textLabel.text = group.subject;
        }
        else {
            cell.textLabel.text = group.groupId;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {

        EMGroup *group = [self.dataSource objectAtIndex:indexPath.row];
        
        UIViewController *chatController = nil;
        chatController = [[TDEaseChatViewController alloc] initWithConversationChatter:group.groupId conversationType:EMConversationTypeGroupChat];
        chatController.title = group.subject;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

#pragma mark - EMGroupManagerDelegate

- (void)didUpdateGroupList:(NSArray *)groupList
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:groupList];
    [self.tableView reloadData];
}

#pragma mark - private


#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    self.page = 1;
    [self fetchGroupsWithPage:self.page isHeader:YES];
}

- (void)tableViewDidTriggerFooterRefresh
{
    self.page += 1;
    [self fetchGroupsWithPage:self.page isHeader:NO];
}

- (void)fetchGroupsWithPage:(NSInteger)aPage
                   isHeader:(BOOL)aIsHeader
{
    [self hideHud];
    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *groupList = [[EMClient sharedClient].groupManager getJoinedGroupsFromServerWithPage:aPage pageSize:50 error:&error];
        [weakSelf tableViewDidFinishTriggerHeader:aIsHeader reload:NO];
        
        if (weakSelf)
        {
            TDGroupContactListViewController *strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf hideHud];
                
                if (!error)
                {
                    if (aIsHeader) {
                        NSMutableArray *oldChatrooms = [weakSelf.dataSource mutableCopy];
                        [weakSelf.dataSource removeAllObjects];
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [oldChatrooms removeAllObjects];
                        });
                    }
                    
                    [strongSelf.dataSource addObjectsFromArray:groupList];
                    [strongSelf.tableView reloadData];
                    if (groupList.count == 50) {
                        strongSelf.showRefreshFooter = YES;
                    } else {
                        strongSelf.showRefreshFooter = NO;
                    }
                }
            });
        }
    });
}

- (void)reloadDataSource
{
    [self.dataSource removeAllObjects];
    
    NSArray *rooms = [[EMClient sharedClient].groupManager getJoinedGroups];
    [self.dataSource addObjectsFromArray:rooms];
    
    [self.tableView reloadData];
}

#pragma mark - action



@end

