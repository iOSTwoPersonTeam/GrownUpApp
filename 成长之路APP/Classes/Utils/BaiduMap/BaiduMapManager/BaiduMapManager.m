//
//  BaiduMapManager.m
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "BaiduMapManager.h"

@interface BaiduMapManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong)BMKLocationService *locService; // 定位对象
@property (nonatomic, strong)BMKGeoCodeSearch *geoSearcher; // 地理编码对象


@end

@implementation BaiduMapManager

+(BaiduMapManager *)shareLocationManager
{
    static BaiduMapManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[[BaiduMapManager alloc] init];
    });
    return manager;
}


- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

#pragma mark ---开始定位
- (void)startLocation {
        //启动LocationService
        [self.locService startUserLocationService];
}

#pragma mark -----停止定位
- (void)stopLocation {
    [self.locService stopUserLocationService];
}


#pragma mark ---获取当前位置经纬度信息
-(void)getCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location
{
    [self.locService startUserLocationService];
    
    self.geoCodeSucceed = ^(BMKReverseGeoCodeResult *result) {
      
        location(result);
    };

}


#pragma mark ---根据地理位置 进行地理反编码--
-(void)getLocationWithLongitudeAndLatitude:(CLLocationCoordinate2D )mapLocation succeed:(void (^)(BMKReverseGeoCodeResult *result))succeed failure:(void (^)(BMKSearchErrorCode error))failure
{
    
    //地理反编码方法
    [self geoCodewithLocation:mapLocation];
    
    self.geoCodeSucceed = ^(BMKReverseGeoCodeResult *result) {
        NSLog(@"%@",result.address);
        succeed(result);
    };
    self.geoCodeError = ^(BMKSearchErrorCode error) {
        failure(error);
    };
}

/*
   地理反编码方法
 */
-(void)geoCodewithLocation:(CLLocationCoordinate2D )mapLocation
{

    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){(float)mapLocation.latitude, (float)mapLocation.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoSearcher reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        //        NSLog(@"反geo检索发送成功");
    }
    else
    {
        //        NSLog(@"反geo检索发送失败");
    }

}



#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    //地理反编码方法
    [self geoCodewithLocation:userLocation.location.coordinate];

}


#pragma mark - BMKGeoCodeSearchDelegate
//  接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //      在此处理正常结果
        if (self.geoCodeSucceed) {
            self.geoCodeSucceed(result);
        }
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
        if (self.geoCodeError) {
            self.geoCodeError(error);
        }
    }
}


#pragma mark ---getter--
-(BMKGeoCodeSearch *)geoSearcher
{
    if (!_geoSearcher) {
        
        _geoSearcher = [[BMKGeoCodeSearch alloc] init];
        _geoSearcher.delegate = self;
    }
    return _geoSearcher;
}

-(BMKLocationService *)locService
{
    if (!_locService) {
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        // 设定定位的最小更新距离(米)，更新频率。默认为kCLDistanceFilterNone
        _locService.distanceFilter = 100.0f;
        // 设定定位精度。默认为kCLLocationAccuracyBest。
        _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 定位精度10m
    }
    return _locService;
}



@end








