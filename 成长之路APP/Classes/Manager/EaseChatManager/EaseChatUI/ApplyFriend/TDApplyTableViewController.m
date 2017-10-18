//
//  TDApplyTableViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDApplyTableViewController.h"
#import "TDApplyFriendTableViewCell.h"

static TDApplyTableViewController *controller = nil;

@interface TDApplyTableViewController ()<ApplyFriendCellDelegate>
{
    
    NSUserDefaults *userDefaultes;
}
@end

@implementation TDApplyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] initWithStyle:UITableViewStylePlain];
    });
    
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"好友申请";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self loadDataSourceFromLocalDB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self.tableView reloadData];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSString *)loginUsername
{
    return [[EMClient sharedClient] currentUsername];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplyFriendCell";
    TDApplyFriendTableViewCell *cell = (TDApplyFriendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[TDApplyFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
        NSDictionary *entity = [self.dataSource objectAtIndex:indexPath.row];
            cell.indexPath = indexPath;
            cell.titleLabel.text = entity[@"username"];
            cell.headerImageView.image = [UIImage imageNamed:@"chatListCellHead"];
            cell.contentLabel.text = entity[@"message"];

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        
        NSDictionary *entity = [self.dataSource objectAtIndex:indexPath.row];
       
        [[TDEaseChatManager shareManager] judgeAcceptInvitationStatus:YES forContact:entity[@"username"] withSucceed:^{
            [self.dataSource removeObject:entity];
            [userDefaultes removeObjectForKey:@"dic"];
            [self.tableView reloadData];
        } Error:^(EMError *aError) {
           [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
        }];
        [self hideHud];
    }
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        NSDictionary *entity = [self.dataSource objectAtIndex:indexPath.row];
        
        [[TDEaseChatManager shareManager] judgeAcceptInvitationStatus:NO forContact:entity[@"username"] withSucceed:^{
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [userDefaultes removeObjectForKey:@"dic"];
            [self.tableView reloadData];
        } Error:^(EMError *aError) {
            [self showHint:NSLocalizedString(@"rejectFail", @"reject failure")];
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            
            [self.tableView reloadData];
        }];
        
        [self hideHud];

    }
}

#pragma mark - public
- (void)removeApply:(NSString *)aTarget
{
    if ([aTarget length] == 0) {
        return ;
    }
    
    for (NSDictionary *entity in self.dataSource) {
        if ([entity[@"username"] isEqualToString:aTarget]) {
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [self.dataSource removeObject:entity];
            [self.tableView reloadData];
            break;
        }
    }
}

- (void)loadDataSourceFromLocalDB
{
    [_dataSource removeAllObjects];
    NSString *loginName = [self loginUsername];
    userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaultes objectForKey:@"dic"];
    if (dic.count >0) {
        [self.dataSource addObject:dic];
    }
     [self.tableView reloadData];
}

- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)clear
{
    [_dataSource removeAllObjects];
    [self.tableView reloadData];
}

@end

