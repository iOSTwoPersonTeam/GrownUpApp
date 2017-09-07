//
//  UtilsMacros.h
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//获取屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define TDTabBarHeight  49       //定义Tabbar高度

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//判断字段是否为空
#define stringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//判断数组是否为空
#define arrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//判断字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//判断是否是空对象
#define objectIsEmpty(_object) (_object == nil \ || [_object isKindOfClass:[NSNull class]] \ || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \ || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//色值 可以直接使用rgb色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//手机型号
#define iPhone4S ([UIScreen mainScreen].bounds.size.height == 480) 
#define iPhone5S ([UIScreen mainScreen].bounds.size.height == 568) 
#define iPhone6S ([UIScreen mainScreen].bounds.size.height == 667) 
#define iPhone6pS ([UIScreen mainScreen].bounds.size.height == 736)


//默认经纬度--北京天安门
#define KDEFAULTLAT                @"39.915"
#define KDEFAULTLNG                @"116.404"
//当前定位城市经纬度
#define KCURRENTCITYLOCATION       @"positionLocationInfo"
//当前定位的城市信息
#define KCURRENTCITYINFO           @"positionCityInfo"
//用户选取的城市信息
#define KSELECTCITYINFO            @"userSelectCityInfo"


#endif /* UtilsMacros_h */





