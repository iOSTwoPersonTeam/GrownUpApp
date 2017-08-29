//
//  TDLoginViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDLoginViewController : TDRootViewController

@property(nonatomic, copy) void (^loginSuccessHandler)(); //登录成功后的回调

@end
