//
//  TDUnifyPayManager.h
//  成长之路APP
//
//  Created by mac on 2017/9/20.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
//微信SDK头文件
#import "WXApi.h"
//支付宝支付SDK
#import <AlipaySDK/AlipaySDK.h>

/**
 resultCode:
 0    -    支付成功
 -1   -    支付失败
 -2   -    支付取消
 -3   -    未安装App(适用于微信)
 -4   -    设备或系统不支持，或者用户未绑卡(适用于ApplePay)
 -99  -    未知错误
 */
typedef void (^TDUnifyPayManagerResultBlock) (NSInteger resultCode, NSString * resultMsg);


@interface TDUnifyPayManager : NSObject<WXApiDelegate>

+ (TDUnifyPayManager *)sharedManager;

/***********************************************/
/*******************微信支付*********************/
/***********************************************/

/**微信支付结果回调*/
@property (strong, nonatomic)TDUnifyPayManagerResultBlock wechatResultBlock;

/**检查是否安装微信*/
+ (BOOL)isWXAppInstalled;

/**注册微信appId*/
+ (BOOL)wechatRegisterAppWithAppId:(NSString *)appId enableMTA:(BOOL)isEnableMTA;

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wechatHandleOpenURL:(NSURL *)url;

/**发起微信支付*/
- (void)wechatPayWithAppId:(NSString *)appId
                 partnerId:(NSString *)partnerId
                  prepayId:(NSString *)prepayId
                   package:(NSString *)package
                  nonceStr:(NSString *)nonceStr
                 timeStamp:(NSString *)timeStamp
                      sign:(NSString *)sign
                 respBlock:(TDUnifyPayManagerResultBlock )block;

/***********************************************/
/*******************支付宝支付********************/
/***********************************************/

/**支付宝支付结果回调*/
@property (strong, nonatomic)TDUnifyPayManagerResultBlock alipayResultBlock;

/**处理支付宝通过URL启动App时传递回来的数据*/
+ (BOOL)alipayHandleOpenURL:(NSURL *)url;

/**发起支付宝支付*/
- (void)aliPayOrder:(NSString *)order
             scheme:(NSString *)scheme
          respBlock:(TDUnifyPayManagerResultBlock )block;





@end
