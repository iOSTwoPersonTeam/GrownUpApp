//
//  CityItem.h
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MJExtension/MJExtension.h>

@interface CityItem : NSObject <MJKeyValue>

@property (nonatomic, copy) NSString *TYPE;                 //1、市，2、县/区  3省
@property (nonatomic, copy) NSString *CODE;                 //服务编号
@property (nonatomic, copy) NSString *PCODE;                //父级编号
@property (nonatomic, copy) NSString *PINYIN;               //拼音


@property (nonatomic, strong) NSString *city;               //地图定位城市
@property (nonatomic, strong) NSString *name;               //显示名称
@property (nonatomic, strong) NSString *address;            //具体地址
@property (nonatomic, assign) CLLocationCoordinate2D point; //坐标

- (instancetype)initWithTitleName:(NSString *)titleName;
+ (instancetype)initWithTitleName:(NSString *)titleName;

@end
