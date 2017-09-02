//
//  TDSearchAddressViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSearchAddressViewController.h"
#import "ZJScrollPageView.h"
#import "TDNearbyAddressViewController.h"
#import "TDHistoryAddressView.h"
#import "TDSearchResultView.h"
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "BaiduMapManager.h"

@interface TDSearchAddressViewController ()<ZJScrollPageViewDelegate,UISearchBarDelegate,BMKPoiSearchDelegate>

@property(nonatomic ,weak)UISearchBar *customSearchBar; //系统自带搜索框
@property(nonatomic ,strong)ZJScrollPageView *scrollPageView;

@property(nonatomic ,strong)TDHistoryAddressView *historyAddressView; //历史记录
@property(nonatomic ,strong)TDSearchResultView *searchResultView; //历史记录

@end

@implementation TDSearchAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem leftBarButtonItemWithTitle:@"北京市" titleColor:[UIColor redColor] target:self selector:@selector(clickSelectCity)];
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem rightBarButtonItemWithTitle:@"取消" titleColor:[UIColor redColor] target:self selector:@selector(cancelDidClick)];
    [self customSearchBar];
    
    [self.view addSubview:self.scrollPageView]; //添加标题segment

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden =NO;

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [_customSearchBar removeFromSuperview];
}


#pragma mark ---private---
//选择城市
-(void)clickSelectCity
{

}

//点击取消
- (void)cancelDidClick
{
    [self navigationBack];
    [_customSearchBar removeFromSuperview];
    [self.historyAddressView removeFromSuperview];
    [self.searchResultView removeFromSuperview];
}

//点击历史记录 页面 消失
-(void)clickDisappear
{
    [self.historyAddressView removeFromSuperview];
    [self.searchResultView removeFromSuperview];
    [self.customSearchBar resignFirstResponder];
}

//点击搜索结果 在地图上获取相应的位置
-(void)selectIndexPathWithLocation:(BMKPoiInfo *)info
{
    [[BaiduMapManager shareLocationManager] getPoiDetailResultWithPoiUid:info.uid detailResult:^(BMKPoiDetailResult *detaiResult) {
        
        if (self.searchGetResultBlock) {
            self.searchGetResultBlock(detaiResult);
        }
        [self cancelDidClick];
        
    } errorCode:^(BMKSearchErrorCode error) {
        
    }];
}

#pragma mark ---Delagate---
#pragma mark ---ZJScrollPageViewDelegate
-(NSInteger)numberOfChildViewControllers
{
    return 4;
}

-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    TDNearbyAddressViewController<ZJScrollPageViewChildVcDelegate> *childVc = (TDNearbyAddressViewController<ZJScrollPageViewChildVcDelegate>*)reuseViewController;
    
    if (!childVc) {
        childVc = [[TDNearbyAddressViewController<ZJScrollPageViewChildVcDelegate> alloc] init];
        childVc.location =_location;
    }
    
    return childVc;
    
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

#pragma mark --UISearchBarDelegate---
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.view addSubview:self.searchResultView]; //添加搜索结果
    [self.view addSubview:self.historyAddressView]; //添加历史记录View
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {

        [self.view bringSubviewToFront:self.historyAddressView];
    } else{
       [self.view bringSubviewToFront:self.searchResultView];
        
        [[BaiduMapManager shareLocationManager] getPoiResultWithCity:@"北京" withSearchKeyword:searchText result:^(BMKPoiResult *result) {

            [self.searchResultView getDataWithInfo:[NSMutableArray arrayWithArray:result.poiInfoList]];
            
        } errorCode:^(BMKSearchErrorCode error) {
            
        }];
    }
    
}

#pragma mark ---getter--
-(UISearchBar *)customSearchBar
{
    if (!_customSearchBar) {
        
        CGRect mainViewBounds = self.navigationController.view.bounds;
        UISearchBar *customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-140)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-140, 40)];
        customSearchBar.delegate = self;
        customSearchBar.showsCancelButton = NO;
        customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        customSearchBar.layer.masksToBounds =YES;
        customSearchBar.layer.cornerRadius =40;
        customSearchBar.placeholder =@"请输入搜索地址……";
        [self.navigationController.view addSubview:customSearchBar];  //添加搜索框
        _customSearchBar =customSearchBar;
    }
    return _customSearchBar;
}

-(ZJScrollPageView *)scrollPageView
{
    if (!_scrollPageView) {
        
        ZJSegmentStyle *style =[[ZJSegmentStyle alloc] init];
        //显示滚动条
        style.showLine =YES;
        //标题不滚动
        style.scrollTitle =NO;
        //segmentView是否有弹性
        style.segmentViewBounces =NO;
        //取消点击时候的动画效果
        style.animatedContentViewWhenTitleClicked =NO;
        //取消内容视图弹框
        style.scrollContentView =NO;
        //标题颜色
        style.selectedTitleColor = [UIColor redColor];
        //标题滚动条颜色
        style.scrollLineColor = [UIColor redColor];
        //标题字体
        style.titleFont =[UIFont systemFontOfSize:16];
        //颜色渐变
        style.gradualChangeTitleColor =YES;
        
        NSArray *titles =@[@"全部",@"写字楼",@"小区",@"学校"];
        
        //初始化
        _scrollPageView =[[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) segmentStyle:style titles:titles parentViewController:self delegate:self];
        
    }
    return _scrollPageView;
}

-(TDHistoryAddressView *)historyAddressView
{
    if (!_historyAddressView) {
        
        _historyAddressView =[[TDHistoryAddressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _historyAddressView.backgroundColor =[UIColor whiteColor];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDisappear)];
        [_historyAddressView addGestureRecognizer:tap];
        
        
    }

    return _historyAddressView;
}

-(TDSearchResultView *)searchResultView
{
    if (!_searchResultView) {
        
        _searchResultView =[[TDSearchResultView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _searchResultView.backgroundColor =[UIColor orangeColor];
        __weak typeof(self) unself =self;
        _searchResultView.resultIndexPathBlock = ^(BMKPoiInfo *info) {
            [unself selectIndexPathWithLocation:info];
        };
        
    }
    
    return _searchResultView;
}






@end








