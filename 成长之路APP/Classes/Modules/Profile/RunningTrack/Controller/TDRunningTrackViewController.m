//
//  TDRunningTrackViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRunningTrackViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "TDRunningTrackDataView.h"

#define FirstLocation @"firstLocation"

@interface TDRunningTrackViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    // 用于记录经过的点
    NSMutableArray *locationPoint;
    // 在地图上绘制的折线
    BMKPolyline *routeLine;
    // 中间变量->location类型(地理位置) 当前位置
    CLLocation *currentLocation;
    //开始位置
    CLLocation *startLocation;
    
}
@property(nonatomic, strong)BMKMapView *mapView; //地图
@property(nonatomic, strong)UIButton *locationButton; //定位按钮
@property(nonatomic, strong)UIButton *backButton; //返回按钮
@property(nonatomic, strong)BMKLocationService *locationService; //定位服务
@property(nonatomic, strong)BMKLocationViewDisplayParam *displayParam; //自定义图层样式
@property(nonatomic, strong)TDRunningTrackDataView *runTrackdataView; //数据展示view

@end

@implementation TDRunningTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.mapView]; //添加地图视图
    [self.view addSubview:self.locationButton]; //添加定位按钮
    [self.view addSubview:self.backButton]; //添加返回按钮
    [self.view bringSubviewToFront:self.runTrackdataView];
    [self.locationService startUserLocationService];
    //起点大头针的添加
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:FirstLocation];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.isHidenNaviBar =YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.isHidenNaviBar =NO;
}


#pragma mark ---Pivate---
//定位按钮事件
-(void)clickLocation
{
    DLog(@"定位----");
    //当前位置移动到中心点
    self.mapView.centerCoordinate =currentLocation.coordinate;
}
//返回按钮事件
-(void)clickBack
{
    DLog(@"返回----");
    [UIView animateWithDuration:0.6 animations:^{
        self.runTrackdataView.hidden =NO;
    }];
}
//点击空白进入地图事件
-(void)clickIntoRunMap
{
    [UIView animateWithDuration:0.6 animations:^{
        self.runTrackdataView.hidden =YES;
    }];
}

//获取位置坐标数组
- (void)operationForLocation:(BMKUserLocation *)userLocation
{
    // 1、检查移动的距离，移除不合理的点
    if (locationPoint.count > 0) {
        CLLocationDistance distance = [userLocation.location distanceFromLocation:currentLocation];
        if (distance < 5.0)
            return;
    }
    // 2、初始化坐标点数组
    if (nil == locationPoint) {
        locationPoint = [[NSMutableArray alloc] init];
    }
    
    // 3、将合理的点添加到数组
    [locationPoint addObject:userLocation.location];
    
    // 4、作为前一个坐标位置辅助操作
    currentLocation = userLocation.location;
    
    // 5、开始画线
    [self configureRoutes];
    
    //5.判断起始位置点是否在地图可显示范围内

    //6.调整地图显示范围
    [self setAdjustMapRegion];
    
    //7、实时更新用户位置
    [self.mapView updateLocationData:userLocation];
}

#pragma mark - 绘制轨迹
-(void)configureRoutes
{
    // 1、分配内存空间给存储经过点的数组
    BMKMapPoint* pointArray = (BMKMapPoint *)malloc(sizeof(CLLocationCoordinate2D) * locationPoint.count);
    
    // 2、创建坐标点并添加到数组中
    for(int idx = 0; idx < locationPoint.count; idx++)
    {
        CLLocation *location = [locationPoint objectAtIndex:idx];
        CLLocationDegrees latitude  = location.coordinate.latitude;
        CLLocationDegrees longitude = location.coordinate.longitude;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        BMKMapPoint point = BMKMapPointForCoordinate(coordinate);
        pointArray[idx] = point;
    }
    // 3、防止重复绘制
    if (routeLine) {
        //在地图上移除已有的坐标点
        [_mapView removeOverlay:routeLine];
    }
    
    // 4、画线
    routeLine = [BMKPolyline polylineWithPoints:pointArray count:locationPoint.count];
    
    // 5、将折线(覆盖)添加到地图
    if (nil != routeLine) {
        [_mapView addOverlay:routeLine];
    }
    // 6、清楚分配的内存
    free(pointArray);
}
//计算可视范围地图的显示范围
-(void)setAdjustMapRegion
{
    //声明解析时对坐标数据的位置区域的筛选，包括经度和纬度的最小值和最大值
    CLLocationDegrees minLat = startLocation.coordinate.latitude;
    CLLocationDegrees maxLat = startLocation.coordinate.latitude;
    CLLocationDegrees minLon = startLocation.coordinate.longitude;
    CLLocationDegrees maxLon = startLocation.coordinate.longitude;
    //解析数据
    for (CLLocation *location in locationPoint) {
        //对比筛选出最小纬度，最大纬度；最小经度，最大经度
        minLat = MIN(minLat, location.coordinate.latitude);
        maxLat = MAX(maxLat, location.coordinate.latitude);
        minLon = MIN(minLon, location.coordinate.longitude);
        maxLon = MAX(maxLon, location.coordinate.longitude);
    }
    //动态的根据坐标数据的区域，来确定地图的显示中心点和缩放级别
        //计算中心点
        CLLocationCoordinate2D centCoor;
        centCoor.latitude = (CLLocationDegrees)((maxLat+minLat) * 0.5f);
        centCoor.longitude = (CLLocationDegrees)((maxLon+minLon) * 0.5f);
        BMKCoordinateSpan span;
        //计算地理位置的跨度
        span.latitudeDelta = (maxLat - minLat) *1.4;
        span.longitudeDelta = (maxLon - minLon) *1.4;
        //得出数据的坐标区域
        BMKCoordinateRegion region = BMKCoordinateRegionMake(centCoor, span);
       [self.mapView setRegion:region animated:YES];
    
}

#pragma mark --Delegate---
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    DLog(@"地图加载完成调用");
    
}
//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //起点位置的设置
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FirstLocation]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstLocation];
        [self.mapView removeAnnotations:self.mapView.annotations];
        BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
        item.coordinate =userLocation.location.coordinate;
        [self.mapView addAnnotation:item];  //开始位置大头针
        
        self.mapView.centerCoordinate =userLocation.location.coordinate; //定位到中心位置
        
        startLocation =userLocation.location; //开始位置
    }
    
    [self.mapView updateLocationData:userLocation];
    [self operationForLocation:userLocation];

}
// 更新方向
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}

// 定位失败了会调用
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"did failed locate,error is %@",[error localizedDescription]);
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
    newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
    newAnnotationView.annotation=annotation;
    newAnnotationView.image = [UIImage imageNamed:@"起点位置"];   //把大头针换成别的图片
    newAnnotationView.frame = CGRectMake(0, 0, 25, 25);
    return newAnnotationView;
}


- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc]initWithOverlay:overlay];
        // 设置划出的轨迹的基本属性-->也是使得定位看起来更加准确的主要原因
        polylineView.strokeColor = RGBA(25, 232, 100, 1.0);
        polylineView.fillColor = RGBA(25, 232, 100, 1.0);
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark ---getter--
//地图
-(BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView =[[BMKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.mapType = BMKMapTypeStandard;   //标准地图
        _mapView.showsUserLocation = YES;    //定位
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.delegate = self;
        [_mapView setZoomLevel:19]; //地图比例尺显示级别 可以放大到当前定位位置
        [_mapView updateLocationViewWithParam:self.displayParam];
        
    }
    return _mapView;
}
//自定义定位图层图标
-(BMKLocationViewDisplayParam *)displayParam
{
    if (!_displayParam) {
        //定位图层自定义样式参数
        _displayParam = [[BMKLocationViewDisplayParam alloc] init];
        _displayParam.isRotateAngleValid =YES;
        _displayParam.isAccuracyCircleShow =NO;
        _displayParam.locationViewImgName = @"定位中";
        _displayParam.locationViewOffsetX =0;
        _displayParam.locationViewOffsetY =0;
    }
    return _displayParam;
}
//定位服务
-(BMKLocationService *)locationService
{
    if (!_locationService) {
        //初始化BMKLocationService
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        // 设定定位的最小更新距离(米)，更新频率。默认为kCLDistanceFilterNone
        _locationService.distanceFilter = 8.0f;
        // 设定定位精度。默认为kCLLocationAccuracyBest。
        _locationService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 定位精度10m
    }
    return _locationService;
}
//定位按钮
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
//返回按钮
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

-(TDRunningTrackDataView *)runTrackdataView
{
    if (!_runTrackdataView) {
        _runTrackdataView =[[TDRunningTrackDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
        _runTrackdataView.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_runTrackdataView];
        __weak typeof(self) unself =self;
        _runTrackdataView.clickIntoMapBlock = ^{
            [unself clickIntoRunMap];
        };
        NSDictionary *dic =[NSDictionary dictionary];
        _runTrackdataView.modelDic =dic;
    }
    return _runTrackdataView;
}



@end
