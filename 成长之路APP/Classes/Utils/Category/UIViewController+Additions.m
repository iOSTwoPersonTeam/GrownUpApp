//
//  UIViewController+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UIViewController+Additions.h"
#import "TDLoginViewController.h"

@implementation UIViewController (Additions)

#pragma mark ---push一个页面
- (void)navigationDetail:(UIViewController*)detailVC
{
    detailVC.hidesBottomBarWhenPushed = YES;
    if (self.navigationController) {
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (self.parentViewController.navigationController) {
        [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
    }
    else {
        [((TDAppDelegate*)[UIApplication sharedApplication].delegate).rootViewController.navigationController pushViewController:detailVC animated:YES];
    }
}


#pragma mark ---增加或者替换一个页面
- (void)navigationNext:(UIViewController*)nextVC removeCurrent:(BOOL)remove
{
    nextVC.hidesBottomBarWhenPushed = YES;
    if (!remove) {
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else {
        NSMutableArray *oldVC = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        if (oldVC.count >= 2) {
            [oldVC removeLastObject];
        }
        
        [oldVC addObject:nextVC];
        [self.navigationController setViewControllers:oldVC animated:YES];
    }
}

#pragma mark --返回上一个页面
- (void)navigationBack
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.parentViewController.navigationController) {
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
    }
    else {
        [((TDAppDelegate*)[UIApplication sharedApplication].delegate).rootViewController.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ---返回根目录
- (void)navigationBackRoot
{
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (self.parentViewController.navigationController) {
        [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        [((TDAppDelegate*)[UIApplication sharedApplication].delegate).rootViewController.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark ----跳转登录界面
- (void)navigateToLoginWithCompletion:(void (^)())completeHandler
{
    TDLoginViewController *loginVC = [[TDLoginViewController alloc] init];
    loginVC.loginSuccessHandler = completeHandler;
    [self navigationDetail:loginVC];
}



#pragma mark -
#pragma mark 定位

//保存定位城市的经纬度
+ (void)setUserLocation:(NSDictionary*)lcoationDic
{
    NSUserDefaults *userDefacult = [NSUserDefaults standardUserDefaults];
    [userDefacult setObject:lcoationDic forKey:KCURRENTCITYLOCATION];
    [userDefacult synchronize];
}
//读取保存的经纬度
+ (NSDictionary *)getUserLocation
{
    return (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:KCURRENTCITYLOCATION];
}
//保存定位城市信息
+ (void)setLocationCity:(CityItem *)cityItem
{
    NSUserDefaults *userDefacult = [NSUserDefaults standardUserDefaults];
    [userDefacult setObject:@{@"CODE"  : cityItem.CODE,
                              @"NAME"  : cityItem.name,
                              @"PCODE" : cityItem.PCODE,
                              @"PINYIN": cityItem.PINYIN,
                              @"TYPE"  : cityItem.TYPE} forKey:KCURRENTCITYINFO];
    [userDefacult synchronize];
}
//读取定位城市信息
+ (CityItem *)getLocationCity
{
    return [CityItem mj_objectWithKeyValues:(NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:KCURRENTCITYINFO]];
}

//保存用户选择的城市  name:城市 code:城市编号
+ (void)setUserSelectCity:(CityItem *)cityItem
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:@{@"CODE"  : cityItem.CODE,
                      @"NAME"  : cityItem.name,
                      @"PCODE" : cityItem.PCODE,
                      @"PINYIN": cityItem.PINYIN,
                      @"TYPE"  : cityItem.TYPE} forKey:KSELECTCITYINFO];
    [user synchronize];
}
//读取用户选择的城市
+ (CityItem*)getUserSelectCity
{
    return [CityItem mj_objectWithKeyValues:(NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:KSELECTCITYINFO]];
}

//默认北京的经纬度
+ (void)setDefaultLaction
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:KDEFAULTLAT,@"lat",KDEFAULTLNG,@"lng",nil];
    [self setUserLocation:dic];
}



@end
