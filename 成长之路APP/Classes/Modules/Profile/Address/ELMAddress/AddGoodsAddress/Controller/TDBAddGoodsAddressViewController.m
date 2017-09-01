//
//  TDBAddGoodsAddressViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDBAddGoodsAddressViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "TDBAddGoodsAddressView.h"
#import "TDSearchAddressViewController.h"
#import "BaiduMapManager.h"

@interface TDBAddGoodsAddressViewController ()<BMKMapViewDelegate>

//这里采取弱引用 保证内存的释放
@property(nonatomic,strong)BMKMapView *mapView; //地图
@property(nonatomic,strong)TDBAddGoodsAddressView *addGoodsAddressView; //添加定位和地址
@property(nonatomic ,strong)UIButton *locationButton; //定位按钮
@property(nonatomic ,strong)UIImageView *annotationImageView; //大头针图标
@property(nonatomic ,assign)BOOL isRelocation; //是否重新定位
@property(nonatomic ,strong)BMKPoiDetailResult *searchResultInfo; //poi详情检索结果

@end

@implementation TDBAddGoodsAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.title ?: @"饿了么";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch)];
    
    [self.view addSubview:self.mapView]; //添加地图
    [self.view addSubview:self.addGoodsAddressView]; //添加定位和地址
    [self.view addSubview:self.locationButton]; //添加定位按钮
    [self.view addSubview:self.annotationImageView]; //添加屏幕中心大头针
    self.isRelocation =NO;
    [self getLocation]; //根据位置定位

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil

}


#pragma mark --private--
//根据传入接口坐标定位
-(void)getLocation
{
    self.annotationImageView.highlighted =NO;
    [self.mapView setRegion:BMKCoordinateRegionMake(_location, BMKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    
    //根据传入坐标进行饭地理编码
    [self screenCenterLocationAndAddress:_location];
}

//进行反编码
-(void)centerCoordinateLocation:(CLLocationCoordinate2D )userLocation
{
    if (_isRelocation) {
        _isRelocation =NO;
        //执行事件
        _mapView.centerCoordinate = userLocation; //更新定位位置处于地图中心
        [self screenCenterLocationAndAddress:_mapView.centerCoordinate];  //屏幕中心点坐标 并进行地理反编码
    }
}

//将屏幕中心点幻化为地理坐标,并进行地理反编码
-(void)screenCenterLocationAndAddress:(CLLocationCoordinate2D )touchMapCoordinate
{
    [[BaiduMapManager shareLocationManager] getLocationWithLongitudeAndLatitude:touchMapCoordinate succeed:^(BMKReverseGeoCodeResult *result) {
        
        [self.addGoodsAddressView getNewTitleAddress:result.address withDetailAddress:[NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber]];
    } failure:^(BMKSearchErrorCode error) {
        
    }];
}

//点击搜索按钮
-(void)clickSearch
{
    DLog(@"搜索------");
    
}

//点击定位按钮 进行重回定位
-(void)clickUpdateLocation
{
    NSLog(@"重新定位------");
    _isRelocation =YES;
    [[BaiduMapManager shareLocationManager] getCurrentMap:self.mapView  regainCurrentLocation:^(BMKReverseGeoCodeResult *result) {
        
        NSLog(@"%@---",result.address);
        [self centerCoordinateLocation:result.location];
    }];
}

//选择地址
-(void)clickSelectAddress
{
    NSLog(@"选择地址----");
    TDSearchAddressViewController *searchAddressVC =[[TDSearchAddressViewController alloc] init];
    searchAddressVC.location =_location;
    searchAddressVC.searchGetResultBlock = ^(BMKPoiDetailResult *info) {
        _searchResultInfo =info;
        //展示结果
        [self.addGoodsAddressView getNewTitleAddress:info.name withDetailAddress:[NSString stringWithFormat:@"%@",info.address]];
        self.mapView.centerCoordinate =info.pt;
        DLog(@"%f--%f----%@",info.pt.latitude,info.pt.latitude,info.name);
        [self.mapView setRegion:BMKCoordinateRegionMake(info.pt, BMKCoordinateSpanMake(0.02, 0.02)) animated:YES];
        
    };
    [self.navigationController pushViewController:searchAddressVC animated:YES];
}
//确认
-(void)clickMakeSure:(NSString *)detailAddress
{
    NSLog(@"确认----");
    if (self.getAddressBlock) {
        self.getAddressBlock(detailAddress ,self.mapView.centerCoordinate);
    }
}

#pragma mark---public---
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

#pragma mark ---delagate--
#pragma mark ---BMKMapViewDelegate 地图delagate--
//地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    DLog(@"地图即将改变-----");
    self.annotationImageView.highlighted =YES;
    [self.addGoodsAddressView getNewTitleAddress:@"正在获取地理位置……" withDetailAddress:@""];
}
//地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    DLog(@"地图区域改变完成------");
    _annotationImageView.highlighted =NO;
    [self screenCenterLocationAndAddress:_mapView.centerCoordinate];  //屏幕中心点坐标并进行地理反编码
}

#pragma mark ---getter--
//地图
-(BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.mapType = BMKMapTypeStandard;   //标准地图
        _mapView.showsUserLocation = YES;    //定位
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.delegate = self;
        [_mapView setZoomLevel:16]; //地图比例尺显示级别 可以放大到当前定位位置
    }
    return _mapView;
}
//地址View
-(TDBAddGoodsAddressView *)addGoodsAddressView
{
    if (!_addGoodsAddressView) {
        _addGoodsAddressView =[[TDBAddGoodsAddressView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3 *2 +20, SCREEN_WIDTH, SCREEN_HEIGHT/3 -20)];
        _addGoodsAddressView.backgroundColor =[UIColor clearColor];
        __weak typeof(self) unself =self;
        _addGoodsAddressView.addAddressBlock = ^{
            
            [unself clickSelectAddress];  //选择地址
        };
        _addGoodsAddressView.makeSureBlock = ^(NSString *detailAddress){
            
            [unself clickMakeSure:detailAddress];  //确认
        };
    }
    return _addGoodsAddressView;
}
//定位按钮
-(UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, CGRectGetMinY(self.addGoodsAddressView.frame) -35, 25, 25)];
        [_locationButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        _locationButton.layer.masksToBounds =YES;
        _locationButton.layer.cornerRadius =12.5;
        _locationButton.backgroundColor =[UIColor whiteColor];
        [_locationButton addTarget:self action:@selector(clickUpdateLocation) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.backgroundColor =[UIColor whiteColor];
    }
    return _locationButton;
}
//大头针图标
-(UIImageView *)annotationImageView
{
    if (!_annotationImageView) {
        _annotationImageView =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, SCREEN_HEIGHT/2-40, 30, 40)];
        _annotationImageView.image =[UIImage imageNamed:@"locationArrow"];
        _annotationImageView.highlightedImage =[UIImage imageNamed:@"locationArrowHeight"];
    }
    return _annotationImageView;
}

@end
