//
//  UIViewController+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityItem.h"

@interface UIViewController (Additions)

//push一个页面
- (void)navigationDetail:(UIViewController*)detailVC;
//增加或者替换一个页面
- (void)navigationNext:(UIViewController*)nextVC removeCurrent:(BOOL)remove;
//返回上一个页面
- (void)navigationBack;
//返回根页面
- (void)navigationBackRoot;
//跳转登录界面
- (void)navigateToLoginWithCompletion:(void(^)())completeHandler;


//保存当前经纬度   key: lat  lng
+ (void)setUserLocation:(NSDictionary*)lcoationDic;
//读取保存的经纬度
+ (NSDictionary *)getUserLocation;

//保存定位城市信息
+ (void)setLocationCity:(CityItem*)cityItem;
//读取定位城市信息
+ (CityItem*)getLocationCity;

//保存用户选择的城市  name:城市 code:城市编号
+ (void)setUserSelectCity:(CityItem*)cityItem;
//读取本地用户选择的城市
+ (CityItem*)getUserSelectCity;




@end



