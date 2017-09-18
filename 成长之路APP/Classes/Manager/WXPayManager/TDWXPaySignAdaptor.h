//
//  TDWXPaySignAdaptor.h
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//  TDWXPaySignAdaptor（微信签名工具类）

#import <Foundation/Foundation.h>

@interface TDWXPaySignAdaptor : NSObject


@property (nonatomic,strong) NSMutableDictionary *dic;

//下订单时候首次签名
- (instancetype)initWithWechatAppId:(NSString *)wechatAppId
                        wechatMCHId:(NSString *)wechatMCHId
                            tradeNo:(NSString *)tradeNo
                   wechatPartnerKey:(NSString *)wechatPartnerKey
                           payTitle:(NSString *)payTitle
                           orderNo :(NSString *)orderNo
                           totalFee:(NSString *)totalFee
                           deviceIp:(NSString *)deviceIp
                          notifyUrl:(NSString *)notifyUrl
                          tradeType:(NSString *)tradeType;

//创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key
                        partnerid:(NSString *)partnerid_key
                         prepayid:(NSString *)prepayid_key
                          package:(NSString *)package_key
                         noncestr:(NSString *)noncestr_key
                        timestamp:(UInt32)timestamp_key;

//订单查询的SIGN
- (NSDictionary *)queryWithWechatAppId:(NSString *)wechatAppId
                        wechatMCHId:(NSString *)wechatMCHId
                   wechatPartnerKey:(NSString *)wechatPartnerKey
                            tradeNo:(NSString *)tradeNo
                           orderNo :(NSString *)orderNo;


@end
