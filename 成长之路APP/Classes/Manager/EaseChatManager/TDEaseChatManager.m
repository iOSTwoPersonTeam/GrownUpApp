//
//  TDEaseChatManager.m
//  成长之路APP
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDEaseChatManager.h"

@interface TDEaseChatManager ()


@end

static  TDEaseChatManager *_manager =nil;

@implementation TDEaseChatManager

#pragma mark ---创建单例
/*
 *  创建请求管理者 单例形式
 */
+(id)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager ==nil) {
            _manager =[[self alloc] init];
        }
    });
    return _manager;
}

/*
 初始化内存管理
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager ==nil) {
            _manager =[super allocWithZone:zone];
        }
    });
    return _manager;
}


#pragma mark ---环信注册
-(void)registerEaseChat
{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:TDEaseChatAppKey];
    options.apnsCertName = TDEaseChatApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

#pragma mark ---环信进入后台
- (void)easeClientDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

#pragma mark ---环信将要从后台返回
- (void)easeClientWillEnterForeground:(UIApplication *)application
{
   [[EMClient sharedClient] applicationWillEnterForeground:application];
}

















@end
