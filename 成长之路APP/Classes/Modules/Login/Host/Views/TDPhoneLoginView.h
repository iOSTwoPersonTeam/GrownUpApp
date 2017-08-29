//
//  TDPhoneLoginView.h
//  成长之路APP
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDPhoneLoginView : UIView

@property(nonatomic,copy) void(^loginBlock)(NSString *userText, NSString *passwordtext); //登录
@property(nonatomic,copy) void(^registerBlock)(); //注册
@property(nonatomic,copy) void(^forgetPassword)(); //忘记密码

@end
