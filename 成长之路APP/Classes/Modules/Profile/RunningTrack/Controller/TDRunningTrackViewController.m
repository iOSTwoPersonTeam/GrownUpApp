//
//  TDRunningTrackViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRunningTrackViewController.h"

@interface TDRunningTrackViewController ()<BMKMapViewDelegate>

@property(nonatomic, strong)BMKMapView *mapView; //地图
@property(nonatomic, strong)UIButton *locationButton; //定位按钮
@property(nonatomic, strong)UIButton *backButton; //返回按钮

@end

@implementation TDRunningTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView]; //添加地图视图
    [self.view addSubview:self.locationButton]; //添加定位按钮
    [self.view addSubview:self.backButton]; //添加返回按钮
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isHidenNaviBar =YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isHidenNaviBar =NO;
}


#pragma mark ---Pivate---
//定位按钮事件
-(void)clickLocation
{
    DLog(@"定位----");
    
}
//返回按钮事件
-(void)clickBack
{
    DLog(@"返回----");
    
}


#pragma mark --Delegate---
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    DLog(@"地图加载完成调用");
    
    
}



#pragma mark ---getter--
-(BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView =[[BMKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.mapType = BMKMapTypeStandard;   //标准地图
        _mapView.showsUserLocation = YES;    //定位
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.delegate = self;
        [_mapView setZoomLevel:16]; //地图比例尺显示级别 可以放大到当前定位位置
    }
    return _mapView;
}

-(UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 -30, SCREEN_HEIGHT -100, 50, 50)];
        [_locationButton setImage:[UIImage imageNamed:@"定位浅色"] forState:UIControlStateNormal];
        _locationButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _locationButton.backgroundColor =RGBA(80, 78, 67, 1.0);
        _locationButton.layer.masksToBounds =YES;
        _locationButton.layer.cornerRadius =CGRectGetHeight(_locationButton.frame)/2;
        [_locationButton addTarget:self action:@selector(clickLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationButton;
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.locationButton.frame) +SCREEN_WIDTH/2, CGRectGetMinY(self.locationButton.frame), CGRectGetWidth(self.locationButton.frame), CGRectGetHeight(self.locationButton.frame))];
        [_backButton setImage:[UIImage imageNamed:@"返回缩小"] forState:UIControlStateNormal];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _backButton.backgroundColor =RGBA(80, 78, 67, 1.0);
        _backButton.layer.masksToBounds =YES;
        _backButton.layer.cornerRadius =CGRectGetHeight(_backButton.frame)/2;
        [_backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backButton;
}


@end
