//
//  TDMainViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDMainViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "TDTabBarViewController.h"
#import "TDHomeViewController.h"
#import "TDContentViewController.h"
#import "TDPublishViewController.h"
#import "TDMessageViewController.h"
#import "TDProfileViewController.h"
#import "CityListViewController.h"
#import "TDBAddGoodsAddressViewController.h"
#import "TDHomeSearchViewController.h"


@interface TDMainViewController ()<TDTabBarViewControllerDelegate,TabBarViewDelegate,CityListViewDelegate>

@property(nonatomic,weak)TDTabBarViewController *tabBarViewController;

@property (nonatomic, strong) UIButton *locationButton;     //用户首页定位
@property (nonatomic, strong) UIBarButtonItem *locationItem;  //用户首页定位
@property (nonatomic, strong) UIBarButtonItem *searchItem;  //用户首页搜索

@end

@implementation TDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSelectCity];    //初始化用户信息时候进行城市选择
    [self setUpNavigationBar]; //初始化首页导航栏
    [self setupChildVC];       //初始化控制器
    
}

#pragma mark --setUPUI
-(void)setUpSelectCity
{
    //初始显示用户首页定位，搜索
    if ([[self class] getUserSelectCity]) {
        [self.locationButton setAttributedTitle:[[NSAttributedString alloc] initWithString:[[[self class] getUserSelectCity] name] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : GlobalThemeColor}] forState:UIControlStateNormal];
        CGSize size = [[[[self class] getUserSelectCity] name] getSizeWithMaxWidth:60 maxHeight:14 withFontSize:14];
        [self.locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, 0)];
    }
    else {
        [self location]; //选择城市
    }
}

-(void)setUpNavigationBar
{
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"首页"];
    self.navigationItem.leftBarButtonItem = self.locationItem;
    self.navigationItem.rightBarButtonItem = self.searchItem;
    
}

-(void)setupChildVC
{
    self.tabBarViewController =[self MaintabBarViewController];
    [self.tabBarViewController willMoveToParentViewController:self];
    [self addChildViewController:self.tabBarViewController];
    [self.tabBarViewController didMoveToParentViewController:self];
    [self.view addSubview:self.tabBarViewController.view];
}


#pragma mark --private---
//TDHomeDetailViewController
- (void)search
{
    NSLog(@"搜索-------");
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"乒乓球",@"橄榄球",@"冰球",@"篮球",@"足球",@"棒球"];
    // 2. 创建控制器
    TDHomeSearchViewController *homeSearchVC = (TDHomeSearchViewController*)[TDHomeSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索关键词"];
    // 3. 设置风格
    homeSearchVC.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为default
    homeSearchVC.searchHistoryStyle = PYSearchHistoryStyleDefault; // 搜索历史风格为default
    homeSearchVC.searchResultShowMode = PYSearchResultShowModeEmbed; // 设置搜索结果显示模式
    homeSearchVC.searchSuggestionHidden = YES;  //隐藏建议文字
    // 4. 跳转到搜索控制器
    TDRootNavigationController *nav = [[TDRootNavigationController alloc] initWithRootViewController:homeSearchVC];
    [self presentViewController:nav  animated:NO completion:nil];
    
}

-(void)location
{
    NSLog(@"定位--------");
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"深圳",@"上海",@"杭州", nil];
    //当前选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:[[TDMainViewController getUserSelectCity] name], nil];
    //定位城市列表
    [self presentViewController:[[TDRootNavigationController alloc] initWithRootViewController:cityListView] animated:YES completion:nil];
}

//TDContentViewController
-(void)leftAdd
{
    NSLog(@"添加--------");
    
}

-(void)rightEdit
{
    NSLog(@"编辑--------");
}

-(void)rightMap
{
    NSLog(@"地图--------");
    TDBAddGoodsAddressViewController *mapVC =[[TDBAddGoodsAddressViewController alloc] init];
    [self.navigationController pushViewController:mapVC animated:YES];
}


//TDMessageViewController
-(void)leftRefresh
{
    NSLog(@"刷新--------");
}

-(void)rightCamera
{
    NSLog(@"相机--------");
}




#pragma mark --TDTabBarViewControllerDelegate

- (void)tabBarController:(TDTabBarViewController *)tabController didSelectIndex:(NSInteger)index
{
    
    self.fd_prefersNavigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarViewController.tabBarView.frame =CGRectMake(0, SCREEN_HEIGHT-64 -49, SCREEN_WIDTH, 49);
    self.navigationItem.leftBarButtonItem =nil;
    self.navigationItem.rightBarButtonItem =nil;
    
    if (index == 0) {
        
        [self setUpNavigationBar];
        
    }
    else if (index ==1){
        
        self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"内容"];
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftAdd)];
        self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem leftBarButtonItemWithTitle:@"地图" titleColor:[UIColor redColor] target:self selector:@selector(rightMap)] ,[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(rightEdit)]];
        
    }
    else if (index ==2){
        
        self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"消息"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(leftRefresh)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightCamera)];
    }
    else if (index ==3){
        
        self.fd_prefersNavigationBarHidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        self.tabBarViewController.tabBarView.frame =CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"我的"];
        
    }
    
}

#pragma mark ---CityListViewDelegate  城市选择Delegate
- (void)didClickedWithCity:(CityItem *)cityItem
{
    [self.locationButton setAttributedTitle:[[NSAttributedString alloc] initWithString:cityItem.name attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : GlobalThemeColor}] forState:UIControlStateNormal];
    CGSize size = [cityItem.name getSizeWithMaxWidth:60 maxHeight:14 withFontSize:14];
    [self.locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, 0)];
}


#pragma mark -----getter-----

-(TDTabBarViewController *)MaintabBarViewController
{
    TDTabBarViewController *tabBarViewController=[[TDTabBarViewController alloc] initWithTabBarSelectedImages:[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"首页-点击"],[UIImage imageNamed:@"我的订单-点击"],[UIImage imageNamed:@"消息-点击"],[UIImage imageNamed:@"我的-点击"], nil] normalImages:[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"首页"],[UIImage imageNamed:@"我的订单"],[UIImage imageNamed:@"消息"],[UIImage imageNamed:@"我的"], nil] titles:[NSMutableArray arrayWithObjects:@"首页",@"内容",@"消息",@"我的", nil]];
    
    tabBarViewController.tabBarView.frame =CGRectMake(0, SCREEN_HEIGHT-64 -49, SCREEN_WIDTH, 49);
    tabBarViewController.showCenterItem =YES;
    tabBarViewController.centerItemTitle =@"发布需求";
    tabBarViewController.centerItemImage =[UIImage imageNamed:@"发布需求"];
    tabBarViewController.XMDelegate =self;
    self.tabBarViewController =tabBarViewController;

    TDHomeViewController *homeVC =[[TDHomeViewController alloc] init];
    
    TDContentViewController *contentVC =[[TDContentViewController alloc] init];
    TDPublishViewController *publishVC =[[TDPublishViewController alloc] init];
    TDMessageViewController *messageVc =[[TDMessageViewController alloc] init];
    TDProfileViewController *profileVC =[[TDProfileViewController alloc] init];
    tabBarViewController.viewControllers =@[homeVC,contentVC,messageVc,profileVC];
    
    tabBarViewController.xm_centerViewController = [[TDRootNavigationController alloc] initWithRootViewController:publishVC];

    return tabBarViewController;
    
}

//定位按钮
- (UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.frame = CGRectMake(0, 0, 80, 16);
        [_locationButton setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 16)];
        [_locationButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_locationButton addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationButton;
}

//首页定位左边导航栏
- (UIBarButtonItem *)locationItem
{
    if (!_locationItem) {
        _locationItem = [[UIBarButtonItem alloc] initWithCustomView:self.locationButton];
    }
    return _locationItem;
}
//首页右面搜索导航栏
- (UIBarButtonItem *)searchItem
{
    if (!_searchItem) {
        _searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    }
    return _searchItem;
}









@end










