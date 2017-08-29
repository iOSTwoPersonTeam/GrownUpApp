//
//  TDSettingsViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewController.h"

@interface TDSettingsViewController : TDRootTableViewController

@property(nonatomic,copy) void(^logoutBlock)(); //退出登录

@end
