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
    
    //登录暂时放在这个地方----------
    [[EMClient sharedClient] loginWithUsername: testAccount
                                      password:textPassword
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登录成功");

                                            
                                        } else {
                                            NSLog(@"登录失败");
                                        }
                                    }];

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

#pragma mark ---环信登录
-(void)logInEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error
{

 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
     [[EMClient sharedClient] loginWithUsername:username ? username : testAccount
                                       password:password ? password :textPassword
                                     completion:^(NSString *aUsername, EMError *aError) {
                                         if (!aError) {
                                             NSLog(@"登录成功");
                                             
                                             if (succeess) {
                                                 succeess();
                                             }
                                             
                                         } else {
                                             NSLog(@"登录失败");
                                             if (error) {
                                                 error(aError);
                                             }
                                         }
                                     }];
    
    });
    
}

#pragma mark --环信退出
-(void)logOutEaseChatWithSucceed:(void(^)())suceess failure:(void(^)(EMError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                DLog(@"退出登录失败%@,%u",error.errorDescription,error.code);
                if (failure) {
                    failure(error);
                }
            }
            else{
                DLog(@"环信退出成功");
                if (suceess) {
                    suceess();
                }
            }
        });
    });
    
}











@end
