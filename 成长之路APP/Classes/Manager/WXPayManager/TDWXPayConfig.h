//
//  TDWXPayConfig.h
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#ifndef TDWXPayConfig_h
#define TDWXPayConfig_h

#import "WXApi.h"
#import "TDWXPayManager.h"  //微信支付调用类
#import "TDWXPaySignAdaptor.h" //微信签名工具类
#import "XMLDictionary.h"       //XML转换工具类


/**
 -----------------------------------
 微信支付需要配置的参数
 -----------------------------------
 */

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define TDWechatAPPID       @"wxf78bf92fd40a6c3f"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define TDWechatAPPSecret   @"9c42ee1cbe724d644c23ec11469be368"
// 微信支付商户号 商户id
#define TDWechatMCHID       @"1354209202"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。 商户密钥
#define TDWechatPartnerKey  @"0559ae314231027469940a17d365ab44"



/**
 -----------------------------------
 微信下单接口
 -----------------------------------
 */

#define TDUrlWechatPay       @"https://api.mch.weixin.qq.com/pay/unifiedorder"
#define TDUrlWechatQuery       @"https://api.mch.weixin.qq.com/pay/orderquery"

/**
 -----------------------------------
 统一下单请求参数键值
 -----------------------------------
 */

#define WXAPPID         @"appid"            // 应用id
#define WXMCHID         @"mch_id"           // 商户号
#define WXNONCESTR      @"nonce_str"        // 随机字符串
#define WXSIGN          @"sign"             // 签名
#define WXBODY          @"body"             // 商品描述
#define WXOUTTRADENO    @"out_trade_no"     // 商户订单号
#define WXTOTALFEE      @"total_fee"        // 总金额
#define WXEQUIPMENTIP   @"spbill_create_ip" // 终端IP
#define WXNOTIFYURL     @"notify_url"       // 通知地址
#define WXTRADETYPE     @"trade_type"       // 交易类型
#define WXPREPAYID      @"prepay_id"        // 预支付交易会话


#endif /* TDWXPayConfig_h */


