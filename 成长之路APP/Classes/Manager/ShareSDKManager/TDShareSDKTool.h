//
//  TDShareSDKTool.h
//  成长之路APP
//
//  Created by mac on 2017/8/17.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDShareSDKTool : NSObject

/*
 *  TDSareSDKTool 单例
 */
+(id)shareManager;

/**
 *  注册ShareSDK
 */
-(void)registerShare;

/**
 *  第三方登录
 */
-(void)getUserInfoThirdLoginWithType:(SSDKPlatformType)type success:(void (^)(SSDKUser *user))succeed
                  failure:(void (^)(NSError *error))failure;


/**
 *  封装的分享方法(SDK自带布局)
 *  @param contentURLString  分享出去的链接
 *  @param contentTitle 分享的title
 *  @param contentDescription   分享title下面的简介
 *  @param contentImage  分享的图片的链接
 */
-(void)shareSystemUIWithContentURL:(NSString *)contentURLString andcontentTitle:(NSString*)contentTitle contentDescription:(NSString *)contentDescription contentImage:(NSString *)contentImage success:(void(^)(NSDictionary *userData))success failure:(void (^)(NSError *error))failure;

/**
 *  封装的分享方法(自定义分享UI的实现)
 *  @param contentURLString  分享出去的链接
 *  @param contentTitle 分享的title
 *  @param contentDescription   分享title下面的简介
 *  @param contentImage  分享的图片的链接
 */
-(void)shareCustomUIWithContentURL:(NSString *)contentURLString andcontentTitle:(NSString*)contentTitle contentDescription:(NSString *)contentDescription contentImage:(NSString *)contentImage success:(void(^)(NSDictionary *userData))success failure:(void (^)(NSError *error))failure;



@end




