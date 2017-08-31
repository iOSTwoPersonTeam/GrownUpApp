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
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem leftBarButtonItemWithTitle:@"取消" titleColor:[UIColor redColor] target:self selector:@selector(cancelDidClick)];
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
    //详情
    BMKPoiSearch *bMKPoiSearch =[[BMKPoiSearch alloc]init];
    bMKPoiSearch.delegate = self;
    BMKPoiDetailSearchOption *Detailoption=[BMKPoiDetailSearchOption new];
    //详情搜索
    Detailoption.poiUid =info.uid;
    [bMKPoiSearch poiDetailSearch:Detailoption];
    
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
    
        BMKPoiSearch *bMKPoiSearch =[[BMKPoiSearch alloc]init];
        bMKPoiSearch.delegate = self;
        BMKCitySearchOption *option=[BMKCitySearchOption new];
        //    城市内搜索
        option.city =@"北京";
        option.keyword  =searchText;
        [bMKPoiSearch poiSearchInCity:option];
        
    [self.view bringSubviewToFront:self.searchResultView];
    }
    
}

#pragma mark ---BMKPoiSearchDelegate (返回搜索结果)
//检索结果列表
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult* )poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    NSMutableArray<BMKPoiInfo *> *arr =[NSMutableArray array];
    [arr removeAllObjects];
    
    [arr addObjectsFromArray:poiResult.poiInfoList];
    BMKPoiInfo *info =poiResult.poiInfoList[0];
    NSLog(@"%f----%@---%@----",info.pt.latitude,info.address,info.name);
    
    [self.searchResultView getDataWithInfo:arr];
    
}

//检索某个结果的详情
- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    DLog(@"%@-----%f------",poiDetailResult.address ,poiDetailResult.pt.latitude);
    if (self.searchGetResultBlock) {
        self.searchGetResultBlock(poiDetailResult);
    }
    [self cancelDidClick];
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








