//
//  TDWXPayManager.h
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    /** 微信支付 */
    wxPay,
    /** 订单查询 */
    wxOrderquery
    
} RequestType;



@interface DWWXPaySuccessModels : NSObject

/**
 *  此字段是通信标识，非交易标识，交易是否成功需要查看result_code来判断
 *  SUCCESS/FAIL
 */
@property (copy, nonatomic) NSString *return_code;
/**
 *  返回信息，如非空，为错误原因
 *  签名失败
 *  参数格式校验错误
 */
@property (copy, nonatomic) NSString *return_msg;

/**应用APPID*/
@property (copy, nonatomic) NSString *appid;
/**商户号*/
@property (copy, nonatomic) NSString *mch_id;
/**设备号，*/
@property (copy, nonatomic) NSString *device_info;
/**随机字符串*/
@property (copy, nonatomic) NSString *nonce_str;
/**签名*/
@property (copy, nonatomic) NSString* sign;
/**业务结*/
@property (copy, nonatomic) NSString *result_code;
/**错误代码*/
@property (copy, nonatomic) NSString *err_code;
/**错误代码描述*/
@property (copy, nonatomic) NSString *err_code_des;
/**交易类型*/
@property (copy, nonatomic) NSString *trade_type;
/**预支付交易会话标识*/
@property (copy, nonatomic) NSString *prepay_id;
/**交易状态*/
@property (copy, nonatomic) NSString *trade_state;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)wxPaySuccessWithDictionary:(NSDictionary *)dict;

@end



@interface TDWXPayManager : NSObject<WXApiDelegate>

/** 微信返回结果的回调 */
@property(nonatomic, copy) void(^BackCode)(NSString *backCode);

/** 微信返回内容的回调 */
@property(nonatomic, copy) void(^BackResp)(BaseResp *backResp);

/** 微信返回的错误信息 */
@property(nonatomic, copy) void(^Return_ErrorCode)(NSString *return_msg, NSString *err_code, NSString *err_code_des);

/** 微信返回的交易订单状态信息 */
@property(nonatomic, copy) void(^BackTrade_stateMsg)(NSString *backTrade_stateMsg, NSString *backTrade_state);

@property(nonatomic, assign) RequestType requestType;

/*
 *  单例
 */
+ (instancetype)sharedManager;

/** 检查是否安装微信 */
+ (BOOL)get_isWXAppInstalled;

/** 判断当前微信的版本是否支持OpenApi */
+ (BOOL)get_isWXAppSupportApi;

/** 获取微信的itunes安装地址 */
+ (NSString *)getWXAppInstallUrl;

/** 获取当前微信SDK的版本号 */
+ (NSString *)getApiVersion;

/**
 *  向微信终端程序注册第三方应用。
 *
 *  @param appid        微信开发者ID
 *  @param isEnableMTA  是否支持MTA数据上报
 */
- (BOOL)get_RegisterApp:(NSString *)appid enableMTA:(BOOL)isEnableMTA;

/*!
 *  @author dwang
 *  @brief 首次签名并转化付款的XML格式(支付时候使用)
 *  @param tradeTitle        商品标题
 *  @param total_fee    总金额
 *  @return xmlString
 *
 */
- (NSString *)get_payParametersSetTradeTitle:(NSString *)tradeTitle total_fee:(NSString *)total_fee;

/*!
 *  @author dwang
 *  @brief 查询订单签名转化为XML格式(查询支付结果时候,注意传入的订单号必须是支付过且真实存在的)
 *  @param orderNO     商品订单号或者微信订单号
 *  @return xmlString
 *
 */
- (NSString *)query_payParametersSetOrderNO:(NSString *)orderNO;

/*!
 *  @author dwang
 *
 *  @brief 发送支付网络请求(支付)
 *
 *  @param xml                      最终发送的XML
 *  @param return_ErrorCode         失败的错误信息
 *  @param backResp                 微信返回内容的回调
 *  @param backCode                 微信返回结果的回调
 *  param backTrade_stateMsg        微信支付查询结果的回调
 */
- (void)get_requestType:(RequestType)requestType withXml:(NSString*)xml backResp:(void(^)(BaseResp *backResp))backResp backCode:(void(^)(NSString *backCode))backCode return_ErrorCode:(void(^)(NSString *return_msg, NSString *err_code, NSString *err_code_des))return_ErrorCode backTrade_stateMsg:(void(^)(NSString *backTrade_stateMsg, NSString *backTrade_state))backTrade_stateMsg;





@end


