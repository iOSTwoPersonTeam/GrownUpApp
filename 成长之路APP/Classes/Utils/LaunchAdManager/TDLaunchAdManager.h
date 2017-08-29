//
//  TDLaunchAdManager.h
//  成长之路APP
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLaunchAdManager : NSObject


@property(nonatomic,copy) void (^launchShowFinishBlock)(); //广告显示完成回调

/*
 *  单例
 */
+(TDLaunchAdManager *)shareManager;

/*
 *  添加视频或图片广告的方法
 */
-(void)setupXHLaunchAd;
/*
 *  预先下载视频图片
 */
-(void)downLoadVideoAndImageWithURL;




@end
