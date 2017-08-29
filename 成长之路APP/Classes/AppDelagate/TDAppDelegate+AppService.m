//
//  TDAppDelegate+AppService.m
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDAppDelegate+AppService.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "TDLaunchAdManager.h"
#import "TDAppIntroductionViewController.h"

#define IntroductionKey @"introductionKey"

@implementation TDAppDelegate (AppService)

#pragma mark ---设置主窗口
- (void)setMainWindow
{
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootViewController =[[TDMainViewController alloc] init];
    TDRootNavigationController *navigationNC =[[TDRootNavigationController alloc] initWithRootViewController:self.rootViewController];
    self.window.rootViewController =navigationNC;
    [self.window makeKeyAndVisible];
}

#pragma mark ----设置键盘遮挡管理
- (void)setKeyboardManager
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];    //隐藏Toolbar
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES]; //控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].enable = YES; //默认YES
}

#pragma mark ---全局网络状况监测
-(void)networkStatusChange
{

   [[TDBaseRequestApI shareManager] netWorkStateChange];

}

#pragma mark --ShareSDK登录和分享的基本配置
-(void)shardSDKBasedAPPlication
{
    [[TDShareSDKTool shareManager] registerShare];
}

#pragma mark --配置百度地图基本信息
-(void)setBaiDuMapBaseInformation
{
    
    [BMKMapManager logEnable:YES module:BMKMapModuleTile];
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret  =[self.mapManager start:TDBaidu_SecretKey generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图配置失败----manager start failed!");
    } else{
    
        NSLog(@"百度地图配置成功-------");
    }

}

#pragma mark ---添加视频或图片开屏广告
-(void)addXHLaunchAd
{
    [[TDLaunchAdManager shareManager] setupXHLaunchAd];
    [TDLaunchAdManager shareManager].launchShowFinishBlock = ^{
        
        NSLog(@"广告显示完成回调--------");

    };
 
}

#pragma mark ---添加App引导页
-(void)addAppIntroduction
{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IntroductionKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IntroductionKey];
        
        [UIApplication sharedApplication].statusBarHidden = YES;
        //首次安装显示引导
        TDAppIntroductionViewController *guideViewController = [[TDAppIntroductionViewController alloc] init];
        self.window.rootViewController = guideViewController;
        guideViewController.introductionFadedBlock = ^{
            
            [[TDLaunchAdManager shareManager] downLoadVideoAndImageWithURL]; //预先加载缓存广告图片视频
            [self setMainWindow];  //进入主界面
        };
        
    } else{
        
        [self addXHLaunchAd];  //显示视频或图片广告
    }
    

    
}



@end












