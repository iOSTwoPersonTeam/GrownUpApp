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
@property(nonatomic,strong)NSMutableArray *detailArray; //详情数组
@property(nonatomic,strong)UIButton *logoutButton; //退出登录按钮
@property(nonatomic,strong)NSString *cacheSizeText; //缓存大小

@end

@implementation TDSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hudEnabled =NO;
    
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"设置"];
    
    //获取缓存大小
    SDImageCache *cache = [SDImageCache sharedImageCache];
    _cacheSizeText = [NSString stringWithFormat:@"%.2f MB", [cache getSize]/1024.f/1024.f];
    
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
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [[TDEaseChatManager shareManager] setLogOutEaseChatWitLhSucceed:^{
        NSLog(@"退出环信成功---");
    } failure:^(EMError *error) {
        NSLog(@"退出环信失败----");
    }];
    
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
    [cell getDataWithTitle:self.titleArray[indexPath.section][indexPath.row] WithDetailText:self.detailArray[indexPath.section][indexPath.row] WithIndexPath:indexPath.row];
    
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
    
    if (indexPath.section ==0 && indexPath.row ==0) {

        [[SDImageCache sharedImageCache] clearMemory];
        _cacheSizeText = @"0 MB";
        
#warning 没有解决问题------数组套数组 更新指定元素的方法
        _detailArray =[NSMutableArray arrayWithArray:
                       @[@[_cacheSizeText],
                         @[@""]
                         ]];
        
        [self.tableView reloadData];
    }
    
}

#pragma mark ---getter
//名称数组
-(NSArray *)titleArray
{
    if (_titleArray ==nil) {
        
        _titleArray =@[@[@"清除缓存"],
                       @[@"修改密码"],
                       ];
    }
    return _titleArray;
}

//详情数组
-(NSMutableArray *)detailArray
{
    if (!_detailArray) {
        _detailArray =[NSMutableArray arrayWithArray:
                                    @[@[_cacheSizeText],
                                    @[@""]
                                    ]];
    }
    return _detailArray;
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






