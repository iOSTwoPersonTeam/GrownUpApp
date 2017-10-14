//
//  TDEaseChatManager.h
//  成长之路APP
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDEaseChatManager : NSObject

/*
 * TDEaseChatmanager 单例
 */
+(id)shareManager;

/*
 * 配置环信数据
 */
-(void)setEaseChatBaseInformation;

/*
 * 环信进入后台
 */
- (void)easeClientDidEnterBackground:(UIApplication *)application;

/*
 *  环信将要从后台返回
 */
- (void)easeClientWillEnterForeground:(UIApplication *)application;

/*
 *  注册环信
 */
-(void)setRegisterEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error;

/*
 *  环信登录
 */
-(void)setLogInEaseChatWithUsername:username password:password Succeed:(void(^)())succeess Error:(void(^)(EMError *aError))error;

/*
 *  退出环信
 */
-(void)setLogOutEaseChatWitLhSucceed:(void(^)())suceess failure:(void(^)(EMError *error))failure;











@end
