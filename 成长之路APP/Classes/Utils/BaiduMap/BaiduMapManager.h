//
//  BaiduMapManager.h
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//


@interface BaiduMapManager : NSObject

//地理编码结果返回回调结果
@property(nonatomic, copy) void(^geoCodeSucceed)(BMKReverseGeoCodeResult *result);
@property(nonatomic, copy) void(^geoCodeError)(BMKSearchErrorCode error);
//当前定位位置反编码回调结果
@property(nonatomic, copy) void(^geoCodeCurrentLocation)(BMKReverseGeoCodeResult *result);
//POI检索 回调结果  周边云检索回调结果
@property(nonatomic, copy) void(^poiResultSucceed)(BMKPoiResult *result);
@property(nonatomic, copy) void(^poiResultError)(BMKSearchErrorCode error);
//POI详情检索结果
@property(nonatomic, copy) void(^poiDetailResultSucceed)(BMKPoiDetailResult *result);
@property(nonatomic, copy) void(^poiDetailResultError)(BMKSearchErrorCode error);
//LBS云检索结果
@property(nonatomic, copy) void(^cloudResultSucceed)(NSArray*poiResultList);
@property(nonatomic, copy) void(^cloudResultError)(int error);


+(BaiduMapManager *)shareLocationManager;

/*
 * 开始定位
 */
-(void)startLocation;

/*
 * 停止定位
 */
-(void)stopLocation;

/*
 *  获取当前位置经纬度 只是定位 不需要显示地图当前定位
 */
-(void)getCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location;

/*
 *  获取当前位置经纬度 通过传入一个BMKMapView 进行当前位置定位
 */
-(void)getCurrentMap:(BMKMapView *)mapView  regainCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location;

/*
 *  根据传入经纬度,进行地理反编码得到具体信息
 */
-(void)getLocationWithLongitudeAndLatitude:(CLLocationCoordinate2D )mapLocation succeed:(void (^)(BMKReverseGeoCodeResult *result))succeed failure:(void (^)(BMKSearchErrorCode error))failure;

/*
 *  根据经纬度获取POI检索结果 获取检索列表 本地云检索参数信息类
 */
-(void)getPoiResultWithCity:(NSString *)cityName withSearchKeyword:(NSString *)keyword result:(void (^)(BMKPoiResult *result))poiResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode;

/*
 *  根据经纬度获取POI检索详情结果
 *  poi的uid，从poi检索返回的BMKPoiResult结构中获取
 */
-(void)getPoiDetailResultWithPoiUid:(NSString *)poiUid detailResult:(void (^)(BMKPoiDetailResult *detaiResult))poiDetailResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode;

/*
 *  根据经纬度获取周边云检索结果 BMKNearbySearchOption
 */
-(void)getNearbyResultWithLocation:(CLLocationCoordinate2D )location withSearchKeyword:(NSString *)keyword resultSucceed:(void (^)(BMKPoiResult *nearbyResult))nearbyResult errorCode:(void (^)(BMKSearchErrorCode error))errorCode;

/*
 *  根据经纬度获取LBS云检索结果 BMKCloudLocalSearchInfo
 */
-(void)getCloudResultWithLocation:(NSString *)location withSearchKeyword:(NSString *)keyword resultSucceed:(void (^)(NSArray *poiResultLis))cloudResult errorCode:(void (^)(int error))errorCode;


/*
 *  不用的时候需要置nil，否则影响内存的释放
 */
-(void)cancelMapDelagate;



@end





