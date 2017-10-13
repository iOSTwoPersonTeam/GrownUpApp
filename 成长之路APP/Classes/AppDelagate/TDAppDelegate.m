//
//  TDAppDelegate.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//
/*
 1.AppDelagate 应用入口
 2.Modules 功能模块
 3.Manager 管理模块
 4.Utils   工具类
 5.Base    基类
 6.Thridparty 第三方库
 7.Define 全局宏定义
 8.Resource 资源文件夹
 
 */

#import "TDAppDelegate.h"

@interface TDAppDelegate ()


@end

@implementation TDAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setMainWindow]; //设置主窗口
    [self setKeyboardManager]; //键盘管理
//    [self networkStatusChange]; //监测全局网络状况
    [self shardSDKBasedAPPlication]; //第三方登录和分享
    [self setBaiDuMapBaseInformation]; //百度地图基本配置
//    [self addAppIntroduction]; //添加引导页 首次安装之后显示广告页面
    [self WXRegisterAPP];       //向微信终端程序注册第三方应用
    [self setEaseChatBaseInforamtion]; //环信基本配置
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end


