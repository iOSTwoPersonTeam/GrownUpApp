//
//  TDThirdPartyLoginView.h
//  成长之路APP
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDThirdPartyLoginView : UIView

@property(nonatomic,copy) void(^clickweixinBlock)(); //微信
@property(nonatomic,copy) void(^clickQQBlock)(); //QQ
@property(nonatomic,copy) void(^clickweiboBlock)(); //微信

@end



