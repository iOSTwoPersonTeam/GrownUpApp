//
//  BaiduMapManager.h
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduMapManager : NSObject

//地理编码结果返回
@property(nonatomic, copy) void(^geoCodeSucceed)(BMKReverseGeoCodeResult *result);
@property(nonatomic, copy) void(^geoCodeError)(BMKSearchErrorCode error);

//当前定位位置反编码
@property(nonatomic, copy) void(^geoCodeCurrentLocation)(BMKReverseGeoCodeResult *result);


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
 *  根据经纬度获取周边检索信息
 */


/*
 *  根据
 */








@end





