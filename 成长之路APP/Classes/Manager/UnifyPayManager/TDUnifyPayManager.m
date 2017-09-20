//
//  TDUnifyPayManager.m
//  成长之路APP
//
//  Created by mac on 2017/9/20.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDUnifyPayManager.h"

static TDUnifyPayManager *_manager =nil;

@implementation TDUnifyPayManager

/*
 创建请求管理者 单例形式
 */
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
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


/*******************微信支付*********************/
//检查是否安装微信
+ (BOOL)isWXAppInstalled{
    return [WXApi isWXAppInstalled];
}

//注册微信appId
+ (BOOL)wechatRegisterAppWithAppId:(NSString *)appId enableMTA:(BOOL)isEnableMTA{
    
    BOOL isbool = [WXApi registerApp:appId enableMTA:isEnableMTA];
    
    return isbool;
}

//处理微信通过URL启动App时传递回来的数据
+ (BOOL)wechatHandleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[TDUnifyPayManager sharedManager]];
}

//发起微信支付 ----最后向微信发起支付请求方法
- (void)wechatPayWithAppId:(NSString *)appId partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId package:(NSString *)package nonceStr:(NSString *)nonceStr timeStamp:(NSString *)timeStamp sign:(NSString *)sign respBlock:(TDUnifyPayManagerResultBlock )block{
    self.wechatResultBlock = block;
    
    if([WXApi isWXAppInstalled]){
        PayReq *req = [[PayReq alloc] init];
        req.openID = appId;
        req.partnerId = partnerId;
        req.prepayId = prepayId;
        req.package = package;
        req.nonceStr = nonceStr;
        req.timeStamp = (UInt32)timeStamp.integerValue;
        req.sign = sign;
        [WXApi sendReq:req];
    }
    else{
        if(self.wechatResultBlock){
            self.wechatResultBlock(-3, @"未安装微信");
        }
    }
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode){
            case 0:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(0, @"支付成功");
                }
                
                NSLog(@"支付成功");
                break;
            }
            case -1:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-1, @"支付失败");
                }
                
                NSLog(@"支付失败");
                break;
            }
            case -2:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-2, @"支付取消");
                }
                
                NSLog(@"支付取消");
                break;
            }
                
            default:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-99, @"未知错误");
                }
            }
                break;
        }
    }
}

/*******************支付宝支付********************/
//处理支付结果的回调
+ (BOOL)alipayHandleOpenURL:(NSURL *)url{
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
    //处理钱包或者独立快捷app支付跳回商户app携带的支付结果Url
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        TDUnifyPayManager *manager = [TDUnifyPayManager sharedManager];
        NSNumber *code = resultDic[@"resultStatus"];
        
        if(code.integerValue==9000){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(0, @"支付成功");
            }
        }
        else if(code.integerValue==4000 || code.integerValue==6002){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-1, @"支付失败");
            }
        }
        else if(code.integerValue==6001){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-2, @"支付取消");
            }
        }
        else{
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-99, @"未知错误");
            }
        }
        
    }];
    
    return YES;
}

//发起支付宝支付
- (void)aliPayOrder:(NSString *)order scheme:(NSString *)scheme respBlock:(TDUnifyPayManagerResultBlock )block{
    self.alipayResultBlock = block;
    
    __weak __typeof(&*self)ws = self;
    [[AlipaySDK defaultService] payOrder:order fromScheme:scheme callback:^(NSDictionary *resultDic) {
        
        NSNumber *code = resultDic[@"resultStatus"];
        
        if(code.integerValue==9000){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(0, @"支付成功");
            }
        }
        else if(code.integerValue==4000 || code.integerValue==6002){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-1, @"支付失败");
            }
        }
        else if(code.integerValue==6001){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-2, @"支付取消");
            }
        }
        else{
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-99, @"未知错误");
            }
        }
        
    }];
}







@end





