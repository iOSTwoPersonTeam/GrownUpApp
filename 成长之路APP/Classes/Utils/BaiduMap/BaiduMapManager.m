//
//  BaiduMapManager.m
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "BaiduMapManager.h"

@interface BaiduMapManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>
@property(nonatomic,strong)BMKMapView *mapView; //地图
@property (nonatomic, strong)BMKLocationService *locService; // 定位对象
@property (nonatomic, strong)BMKGeoCodeSearch *geoSearcher; // 地理编码对象
@property(nonatomic,strong)BMKPoiSearch *bMKPoiSearch; //搜索检索服务

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

#pragma mark ---获取当前位置经纬度信息 不需要显示当前定位 只是获取当前经纬度
-(void)getCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location
{
    [self startLocation];
    self.geoCodeCurrentLocation = ^(BMKReverseGeoCodeResult *result) {
        location(result);
    };
}

#pragma mark ---获取当前位置经纬度信息  通过mapView显示当前定位
-(void)getCurrentMap:(BMKMapView *)mapView  regainCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location
{
    _mapView =mapView;
    [self startLocation];
    self.geoCodeCurrentLocation = ^(BMKReverseGeoCodeResult *result) {
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

#pragma mark ---根据经纬度获取POI检索结果 获取检索列表--
-(void)getPoiResultWithCity:(NSString *)cityName withSearchKeyword:(NSString *)keyword result:(void (^)(BMKPoiResult *result))poiResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode
{
    //本地云检索参数信息类
    BMKCitySearchOption *option=[BMKCitySearchOption new];
    // 城市内搜索
    option.city =cityName;
    option.keyword  =keyword;
    [self.bMKPoiSearch poiSearchInCity:option];
    
    self.poiResultSucceed = ^(BMKPoiResult *result) {
        
        poiResult(result);
    };
    self.poiResultError = ^(BMKSearchErrorCode error) {
      
        errorCode(error);
    };
}


#pragma mark --- 根据经纬度获取POI检索详情结果----
// poi的uid，从poi检索返回的BMKPoiResult结构中获取
-(void)getPoiDetailResultWithPoiUid:(NSString *)poiUid detailResult:(void (^)(BMKPoiDetailResult *detaiResult))poiDetailResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode
{
  
    BMKPoiDetailSearchOption *Detailoption=[BMKPoiDetailSearchOption new];
    //详情搜索
    Detailoption.poiUid =poiUid;
    [self.bMKPoiSearch poiDetailSearch:Detailoption];
    
    self.poiDetailResultSucceed = ^(BMKPoiDetailResult *result) {
        
        poiDetailResult(result);
    };
    self.poiDetailResultError = ^(BMKSearchErrorCode error) {
        
        errorCode(error);
    };
}

#pragma mark ---根据经纬度获取周边云检索结果 BMKNearbySearchOption
-(void)getNearbyResultWithLocation:(CLLocationCoordinate2D )location withSearchKeyword:(NSString *)keyword resultSucceed:(void (^)(BMKPoiResult *nearbyResult))nearbyResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode
{
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageCapacity = 10;
    option.location = location;
    option.keyword = keyword;
    [self.bMKPoiSearch poiSearchNearBy:option];

    self.poiResultSucceed = ^(BMKPoiResult *result) {
        
        nearbyResult(result);
    };
    self.poiResultError = ^(BMKSearchErrorCode error) {
        
        errorCode(error);
    };

}

#pragma mark ---不用的时候需要置nil，否则影响内存的释放
-(void)cancelMapDelagate
{
    self.bMKPoiSearch.delegate =nil;
    self.geoSearcher.delegate =nil;
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
    if (_mapView) {
        
        [_mapView updateLocationData:userLocation];
    }
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
        if (self.geoCodeCurrentLocation) {
            self.geoCodeCurrentLocation(result);
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
        if (self.geoCodeError) {
            self.geoCodeError(error);
        }
    }
}

#pragma mark ---BMKPoiSearchDelegate (返回搜索结果)
//POI检索结果列表  POI检索解锁 / 周边云检索结果
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult* )poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (self.poiResultSucceed) {
        self.poiResultSucceed(poiResult);
    }
    if (self.poiResultError) {
        self.poiResultError(errorCode);
    }
}
//详情检索结果
- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    DLog(@"%@-----%f------",poiDetailResult.address ,poiDetailResult.pt.latitude);
    if (self.poiDetailResultSucceed) {
        self.poiDetailResultSucceed(poiDetailResult);
    }
    if (self.poiDetailResultError) {
        self.poiDetailResultError(errorCode);
    }
}


#pragma mark ---getter--
//地理反编码
-(BMKGeoCodeSearch *)geoSearcher
{
    if (!_geoSearcher) {
        
        _geoSearcher = [[BMKGeoCodeSearch alloc] init];
        _geoSearcher.delegate = self;
    }
    return _geoSearcher;
}

//定位服务
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

//搜索检索服务
-(BMKPoiSearch *)bMKPoiSearch
{
    if (!_bMKPoiSearch) {
        
        _bMKPoiSearch =[[BMKPoiSearch alloc]init];
        _bMKPoiSearch.delegate = self;
    }
    return _bMKPoiSearch;
}



@end








