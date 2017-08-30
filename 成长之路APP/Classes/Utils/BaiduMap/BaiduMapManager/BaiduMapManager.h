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
 *  获取当前位置经纬度
 */
-(void)getCurrentLocation:(void (^)(BMKReverseGeoCodeResult *result))location;

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





