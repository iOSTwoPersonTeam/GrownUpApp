//
//  TDAppDelegate+AppService.h
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDAppDelegate.h"

@interface TDAppDelegate (AppService)

/*
 * 初始化window,设置主窗口
 */
- (void)setMainWindow;

/*
 *  应用全局键盘管理
 */
-(void)setKeyboardManager;

/*
 * 全局网络状况监测
 */
-(void)networkStatusChange;

/*
 * 第三方登录和分享基本配置
 */
-(void)shardSDKBasedAPPlication;

/*
 * 百度地图基本配置
 */
-(void)setBaiDuMapBaseInformation;

/*
 * 添加视频或图片开屏广告
 */
-(void)addXHLaunchAd;

/*
 *  引导页
 */
-(void)addAppIntroduction;




@end




