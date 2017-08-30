//
//  TDProfileViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/7.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDProfileViewController.h"
#import "TDRootModel.h"
#import "TDProfileTableViewCell.h"
#import "TDProfileHeaderView.h"
#import "TDLoginViewController.h"
#import "TDUserInfoViewController.h"
#import "TDSettingsViewController.h"
#import "TDAddressProfileViewController.h"

#define ELMAddress @"地址选择"

@interface TDProfileViewController ()

@property(nonatomic,strong)NSArray *titleArray; //名称数组
@property(nonatomic,strong)NSArray *imageArray; //图标数组
@property(nonatomic,strong)TDProfileHeaderView *headerView; //头部视图


@end

@implementation TDProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hudEnabled =NO;
    self.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGRect frame =self.tableView.frame;
    frame.size.height -=49;
    self.tableView.frame =frame;

    [self.tableView bringSubviewToFront:self.headerView];
}


-(Class)tableCellClass
{

    return [TDProfileTableViewCell class];
}

#pragma mark - Private

-(void)selectRowAtIndexPathWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"设置"]) {
        
        if (![TDUserInfo getUser].UCODE) {
            [self navigateToLoginWithCompletion:^{
                self.headerView.dataModel =[TDUserInfo getUser]; //更新个人中心信息
                [self navigationBack];
            }];
            return;
        }
        
        TDSettingsViewController *settingsVC =[[TDSettingsViewController alloc] init];
        settingsVC.logoutBlock = ^{
            self.headerView.dataModel =[TDUserInfo getUser]; //更新个人中心信息
        };
        [self navigationDetail:settingsVC];
    }
    else if ([title isEqualToString:@"关于"]){
        //关于
        TDRootWebViewController *webVC = [TDRootWebViewController loadURL:[NSString stringWithFormat:@"%@c=spread&m=preview&id=19",WebSchemeURL]];
        webVC.title = @"橙椒平台服务规则";
        [self navigationDetail:webVC];
    }
    else if ([title isEqualToString:@"关于"]){
        //关于
        TDRootWebViewController *webVC = [TDRootWebViewController loadURL:[NSString stringWithFormat:@"%@c=spread&m=preview&id=19",WebSchemeURL]];
        webVC.title = @"橙椒平台服务规则";
        [self navigationDetail:webVC];
    }
    else if ([title isEqualToString:ELMAddress]){
        
        TDAddressProfileViewController *VC =[[ TDAddressProfileViewController alloc] init];
        [self navigationDetail:VC];
    }
    
}


#pragma mark - UITableViewDelegate/UITableViewdatSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [self.titleArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //详情
    TDProfileTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDProfileTableViewCell class])];
    [cell setTitle:self.titleArray[indexPath.section][indexPath.row] withImageShow:self.imageArray[indexPath.section][indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.titleArray[indexPath.section][indexPath.row];
    [self selectRowAtIndexPathWithTitle:text];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        self.headerView.frame = CGRectMake(offsetY / 2.0, offsetY, SCREEN_WIDTH -offsetY, 288 - offsetY);
    }
    
}


#pragma mark ---getter

- (TDProfileHeaderView *)headerView {
    if(!_headerView) {
        _headerView = [[TDProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 288)];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 288)];
        [self.tableView addSubview:_headerView];
        _headerView.dataModel =[TDUserInfo getUser];
        
        __weak typeof(self) unself =self;
        _headerView.clickImageBlock = ^(){
          
            NSLog(@"登录账号----");
            if ([TDUserInfo getUser].UCODE) {

            [unself navigationDetail:[[TDUserInfoViewController alloc] init]];
            }
            else {
                
                 NSLog(@"未登录账号----");
                [unself navigateToLoginWithCompletion:^{
                    
                    unself.headerView.dataModel =[TDUserInfo getUser];

                    [unself navigationBackRoot];
                }];
            }
        };
    }
    return _headerView;
}


-(NSArray *)titleArray
{
    if (_titleArray ==nil) {
        
        _titleArray =@[@[@"服务收藏",@"店铺关注"],
                       @[@"意见反馈",@"联系客服"],
                       @[ELMAddress],
                       @[@"关于"],
                       @[@"设置"]
                    ];
    }
    return _titleArray;
}

-(NSArray *)imageArray
{
    if (_imageArray ==nil) {
        _imageArray =@[@[@"服务收藏",@"店铺关注"],
                        @[@"意见反馈",@"联系客服"],
                        @[@"意见反馈"],
                        @[@"关于"],
                        @[@"设置"]
                    ];
    }
    return _imageArray;
}




@end







