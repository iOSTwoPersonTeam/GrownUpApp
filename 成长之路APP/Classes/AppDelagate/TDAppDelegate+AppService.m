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


#pragma mark ---微信调用注册
-(void)WXRegisterAPP
{
    /** 
     * 向微信终端注册ID，这里的APPID一般建议写成宏,容易维护。这里的id是AppleID，需要改这里还有target里面的URL Type
     */
    [[TDWXPayManager sharedManager] get_RegisterApp:TD_WeiChat_AppID enableMTA:YES];
    
    //统一处理支付类注册微信---
//    [TDUnifyPayManager wechatRegisterAppWithAppId:TD_WeiChat_AppID enableMTA:YES];
    
}

#pragma mark ---环信SDK基本信息
-(void)setEaseChatBaseInforamtion
{
    //封装单例 配置环信基本信息
    [[TDEaseChatManager shareManager] setEaseChatBaseInformation];
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //环信进入后台
    [[TDEaseChatManager shareManager] easeClientDidEnterBackground:application];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //环信将要返回前台
     [[TDEaseChatManager shareManager] easeClientWillEnterForeground:application];
}
#pragma mark 注册deviceToken
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error
{
    MJExtensionLog(@"error:%@",error);
}

#pragma mark - 微信支付回调-----
//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。本来我是不想写着两个旧方法的，但是一看官方的demo上写的这两个，我就也写了。。。。
//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
#warning mark ---在这里代理的位置[TDWXPayManager sharedManager]--
    if ([url.scheme isEqualToString:TD_WeiChat_AppID])
    {
      return [WXApi handleOpenURL:url delegate:[TDWXPayManager sharedManager]];
    }
   
    //统一处理支付类的支付回调结果
    if([url.scheme hasPrefix:@"wx"]){//微信
//        return [TDUnifyPayManager wechatHandleOpenURL:url];
    }
    else if([url.scheme hasPrefix:@"safepay"]){//支付宝
        return [TDUnifyPayManager alipayHandleOpenURL:url];
    }
    else if([url.scheme hasPrefix:@"UnionPay"]){//银联
        
    }
    
    return YES;

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:TD_WeiChat_AppID])
    {
        return [WXApi handleOpenURL:url delegate:[TDWXPayManager sharedManager]];
    }
    
    //统一处理支付类的支付回调结果
    if([url.scheme hasPrefix:@"wx"]){//微信
//        return [TDUnifyPayManager wechatHandleOpenURL:url];
    }
    else if([url.scheme hasPrefix:@"safepay"]){//支付宝
        return [TDUnifyPayManager alipayHandleOpenURL:url];
    }
    else if([url.scheme hasPrefix:@"UnionPay"]){//银联
        
    }
    
    return YES;
}
//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if ([url.scheme isEqualToString:TD_WeiChat_AppID])
    {
        return [WXApi handleOpenURL:url delegate:[TDWXPayManager sharedManager]];
    }
    
    //统一处理支付类的支付回调结果
    if([url.scheme hasPrefix:@"wx"]){//微信
//        return [TDUnifyPayManager wechatHandleOpenURL:url];
    }
    else if([url.host hasPrefix:@"safepay"]){//支付宝
        return [TDUnifyPayManager alipayHandleOpenURL:url];
    }
    else if([url.scheme hasPrefix:@"UnionPay"]){//银联
        
    }
    
    return YES;
}



@end












