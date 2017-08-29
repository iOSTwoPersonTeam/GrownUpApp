//
//  TDSettingsViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSettingsViewController.h"
#import "TDSettingsTableViewCell.h"

@interface TDSettingsViewController ()

@property(nonatomic,strong)NSArray *titleArray; //名称数组
@property(nonatomic,strong)UIButton *logoutButton; //退出登录按钮

@end

@implementation TDSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hudEnabled =NO;
    
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"设置"];
    
    self.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGRect frame =self.tableView.frame;
    frame.size.height -=49;
    self.tableView.frame =frame;
    self.tableView.tableFooterView =self.logoutButton;
}

-(Class)tableCellClass
{
    
    return [TDSettingsTableViewCell class];
}

#pragma mark - Private

//退出登录事件
-(void)clickLogout
{
    DLog(@"退出登录-------");
    [TDUserInfo removeUserInfo];
    
    if (self.logoutBlock) {
        self.logoutBlock();
    }
    
    [self navigationBack];
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
    if (section ==0) {
        
        return 10;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    TDSettingsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDSettingsTableViewCell class])];
    if (indexPath.section ==0) {
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    else{
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setTitle:self.titleArray[indexPath.section][indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section ==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

#pragma mark ---getter

-(NSArray *)titleArray
{
    if (_titleArray ==nil) {
        
        _titleArray =@[@[@"清除缓存"],
                       @[@"修改密码"],
                       ];
    }
    return _titleArray;
}

-(UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton =[[UIButton alloc] init];
        [_logoutButton setTitle:@"安全退出" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.backgroundColor =GlobalThemeColor;
        _logoutButton.layer.masksToBounds =YES;
        _logoutButton.layer.cornerRadius =3.0;
        self.tableView.tableFooterView =_logoutButton;
        [_logoutButton addTarget:self action:@selector(clickLogout) forControlEvents:UIControlEventTouchUpInside];
        [_logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.top.equalTo(self.view.mas_centerY);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.equalTo(@40);
        }];
        
    }

    return _logoutButton;
}











@end






