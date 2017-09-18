//
//  TDPaymentViewController.h
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDPaymentViewController : TDRootViewController

@property(nonatomic, strong)NSString *payMoney; //支付金额
@property(nonatomic, strong)NSString *shopName; //商品名称
@property(nonatomic, strong)NSString *orderId; //订单id

@end
