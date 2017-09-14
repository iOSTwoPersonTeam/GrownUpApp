//
//  TDOfoBikeViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 hui. All rights reserved.
//
/*
   1.使用周边云检索实现ofo检索功能  这里注意检索内容为自定义的 按照官方文档提示操作即可 检索数据北京二环内手动添加部分数据
   2.
 
 */


#import "TDOfoBikeViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "BaiduMapManager.h"

@interface TDOfoBikeViewController ()<BMKMapViewDelegate>
@property(nonatomic, strong)BMKMapView *mapView; //地图
@property(nonatomic, strong)UIButton *locationButton; //定位按钮
@property(nonatomic, strong)UIImageView *annotationImageView;  //地图中心图片
@property(nonatomic, strong)NSMutableArray *annotationsArray; //大头针标注数组;

@end

@implementation TDOfoBikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"ofo共享单车";
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.locationButton];
    [self.view addSubview:self.annotationImageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    
}

#pragma mark ---Private---
//定位按钮点击事件---
-(void)clickUpdateLocation
{
    [[BaiduMapManager shareLocationManager] getCurrentMap:_mapView regainCurrentLocation:^(BMKReverseGeoCodeResult *result) {
        self.mapView.centerCoordinate = result.location; //更新定位位置处于地图中心
    }];
}

#pragma mark ---Delegate---
#pragma mark ---BMKMapViewDelegate 地图delagate--
//地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    DLog(@"地图即将改变-----");
    self.annotationImageView.highlighted =YES;
    
    self.annotationImageView.transform = CGAffineTransformMakeTranslation(0, -10);//xy移动距离
    
}
//地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    DLog(@"地图区域改变完成------");
    _annotationImageView.highlighted =NO;
        self.annotationImageView.transform = CGAffineTransformMakeTranslation(0, 0);//xy移动距离
    [self screenCenterLocationAndAddress:_mapView.centerCoordinate];  //屏幕中心点坐标并进行地理反编码;
}

//将屏幕中心点幻化为地理坐标,并进行地理反编码
-(void)screenCenterLocationAndAddress:(CLLocationCoordinate2D )touchMapCoordinate
{
    NSString *location =[NSString stringWithFormat:@"%f,%f",touchMapCoordinate.longitude,touchMapCoordinate.latitude];
#pragma mark ---使用周边云检索实现---
    [[BaiduMapManager shareLocationManager] getCloudResultWithLocation:location  withSearchKeyword:@"ofo" resultSucceed:^(NSArray *poiResultLis) {
        
        // 清除屏幕中所有的annotation
        [_mapView removeAnnotations:_mapView.annotations];
        [self.annotationsArray removeAllObjects];
        
        NSLog(@"%@------",poiResultLis);
        BMKCloudPOIList* result = [poiResultLis objectAtIndex:0];        for (BMKCloudPOIInfo *info in result.POIs) {
            //添加大头针方法
            BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ info.longitude,info.latitude};
            item.coordinate = pt;
            item.title = info.title;
            [self.annotationsArray addObject:item];
            NSLog(@"%f--%f--%@",item.coordinate.latitude,item.coordinate.longitude,info.title);
        }
        [self.mapView addAnnotations:self.annotationsArray];
        
    } errorCode:^(int error) {
        
    }];

}

#pragma mark 设置自定义大头针方法
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation

{
    BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
    newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
    newAnnotationView.annotation=annotation;
    newAnnotationView.image = [UIImage imageNamed:@"锚点"];   //把大头针换成别的图片
    return newAnnotationView;
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
//定位按钮
-(UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -45, SCREEN_HEIGHT-60 -64, 25, 25)];
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
        _annotationImageView.image =[UIImage imageNamed:@"中心定位点"];
        _annotationImageView.highlightedImage =[UIImage imageNamed:@"中心定位点"];
    }
    return _annotationImageView;
}
-(NSMutableArray *)annotationsArray
{
    if (!_annotationsArray) {
        _annotationsArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _annotationsArray;
}



@end






