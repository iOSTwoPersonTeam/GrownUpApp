//
//  TDMTMapViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDMTMapViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "BaiduMapManager.h"
#import "TDNearbyAddressView.h"
#import "TDMTNearbySearchViewController.h"

@interface TDMTMapViewController ()<BMKMapViewDelegate,UISearchBarDelegate>

@property(nonatomic ,strong)UIView *cityAndSearchView; //城市和搜索view
@property(nonatomic ,strong)UISearchBar *customSearchBar; //搜索控件
@property(nonatomic ,strong)BMKMapView *mapView;
@property(nonatomic ,strong)UIButton *locationButton; //定位按钮
@property(nonatomic ,strong)UIImageView *annotationImageView; //定位大头针图片
@property(nonatomic ,strong)TDNearbyAddressView *nearbyAddressview; //附近地址View

@end

@implementation TDMTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.backEnabled = YES;
     self.title =@"美团外卖";
    [self.view addSubview:self.cityAndSearchView]; //城市和搜索View
    [self.cityAndSearchView addSubview:self.customSearchBar];  //添加搜索框
     [self.view addSubview:self.mapView]; //添加地图
    [self.view addSubview:self.locationButton]; //定位按钮
    [self.view addSubview:self.annotationImageView]; //定位大头针图片
    [self.view addSubview:self.nearbyAddressview]; //附近地址view
    [self getLocation]; //根据位置定位
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.fd_interactivePopDisabled = YES;
}




#pragma mark ---Private----
//根据传入接口坐标定位
-(void)getLocation
{
    self.annotationImageView.highlighted =NO;
    [self.mapView setRegion:BMKCoordinateRegionMake(_location, BMKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    
    //根据传入坐标进行饭地理编码
    [self screenCenterLocationAndAddress:_location];
}

//重新定位按钮
-(void)clickUpdateLocation
{
    [[BaiduMapManager shareLocationManager] getCurrentMap:_mapView regainCurrentLocation:^(BMKReverseGeoCodeResult *result) {
        _mapView.centerCoordinate = result.location; //更新定位位置处于地图中心
    }];

}

-(void)selectIndexPathGetAddress:(NSString *)address
{
    if (self.getAddressBlock) {
        self.getAddressBlock(address ,self.mapView.centerCoordinate);
    }

}


#pragma mark ---public---



#pragma mark ---Delagate----
#pragma mark ---BMKMapViewDelegate 地图delagate--
//地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    DLog(@"地图即将改变-----");
    self.annotationImageView.highlighted =YES;

}
//地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    DLog(@"地图区域改变完成------");
    _annotationImageView.highlighted =NO;
    [self screenCenterLocationAndAddress:_mapView.centerCoordinate];  //屏幕中心点坐标并进行地理反编码
}

//将屏幕中心点幻化为地理坐标,并进行地理反编码
-(void)screenCenterLocationAndAddress:(CLLocationCoordinate2D )touchMapCoordinate
{
    [[BaiduMapManager shareLocationManager] getLocationWithLongitudeAndLatitude:touchMapCoordinate succeed:^(BMKReverseGeoCodeResult *result) {
        
        [self.nearbyAddressview getDataWithArray:result.poiList];
    } failure:^(BMKSearchErrorCode error) {
        
    }];
}

#pragma mark ----UISearchBarDelagate---
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    TDMTNearbySearchViewController *mtNearbySearchVC =[[TDMTNearbySearchViewController alloc] init];
    [self presentViewController:[[TDRootNavigationController alloc] initWithRootViewController:mtNearbySearchVC] animated:YES completion:nil];

    return NO;
}

#pragma mark ---getter---
//城市和搜索view
-(UIView *)cityAndSearchView
{
    if (!_cityAndSearchView) {
        _cityAndSearchView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _cityAndSearchView.backgroundColor =[UIColor whiteColor];
        UILabel *cityLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        cityLabel.text =@"北京";
        cityLabel.textAlignment =NSTextAlignmentCenter;
        cityLabel.font =[UIFont systemFontOfSize:16];
        [_cityAndSearchView addSubview:cityLabel];
    }
    return _cityAndSearchView;
}
//地图展示
-(BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView =[[BMKMapView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.cityAndSearchView.frame), SCREEN_WIDTH, (SCREEN_HEIGHT-CGRectGetHeight(self.cityAndSearchView.frame))/2)];
        _mapView.mapType = BMKMapTypeStandard;   //标准地图
        _mapView.showsUserLocation = YES;    //定位
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.delegate = self;
        [_mapView setZoomLevel:16]; //地图比例尺显示级别 可以放大到当前定位位置

    }
    return _mapView;
}

//定位按钮
-(UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton =[[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(self.nearbyAddressview.frame)-35, 25, 25)];
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
        _annotationImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        _annotationImageView.center =self.mapView.center;
        _annotationImageView.image =[UIImage imageNamed:@"locationArrow"];
        _annotationImageView.highlightedImage =[UIImage imageNamed:@"locationArrowHeight"];
    }
    return _annotationImageView;
}
//附近地址view
-(TDNearbyAddressView *)nearbyAddressview
{
    if (!_nearbyAddressview) {
        
        _nearbyAddressview =[[TDNearbyAddressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mapView.frame), SCREEN_WIDTH, CGRectGetHeight(self.mapView.frame))];
        _nearbyAddressview.backgroundColor =[UIColor whiteColor];
        __weak typeof(self) unself =self;
        _nearbyAddressview.selectIndexPathBlock = ^(NSString *address) {
            [unself selectIndexPathGetAddress:address];
        };
    }
    return _nearbyAddressview;
}
//搜索控件
-(UISearchBar *)customSearchBar
{
    if (!_customSearchBar) {

        _customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(80 , 0, SCREEN_WIDTH-100, 40)];
        _customSearchBar.delegate = self;
        _customSearchBar.showsCancelButton = NO;
        _customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        _customSearchBar.layer.masksToBounds =YES;
        _customSearchBar.layer.cornerRadius =40;
        _customSearchBar.placeholder =@"查找小区/大厦/学校等";
    }
    return _customSearchBar;
}



@end






