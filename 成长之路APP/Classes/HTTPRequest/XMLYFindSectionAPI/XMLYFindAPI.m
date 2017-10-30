//
//  XMLYFindAPI.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "XMLYFindAPI.h"

#define kRecommendAPI     @"http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.21"

#define kHotAndGuessAPI   @"http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.21"

#define kLiveRecommendAPI @"http://live.ximalaya.com/live-activity-web/v3/activity/recommend"

#define kRecomBannerAPI   @"http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.21"

@implementation XMLYFindAPI

#pragma mark --请求精品歌词和 小编推荐数据
+(void)requestRecommends:(XMLYBaseAPICompletion)completion
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //调用请求方法  GET请求
    [manager GETDataWithURL:kRecommendAPI parameters:nil succeed:^(id responseObject) {
        if (completion) {
            completion(responseObject,YES);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil,NO);
        }
    }];
}

#pragma mark --请求发现新奇、猜你喜欢等数据
+ (void)requestHotAndGuess:(XMLYBaseAPICompletion)completion
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //调用请求方法  GET请求
    [manager GETDataWithURL:kHotAndGuessAPI parameters:nil succeed:^(id responseObject) {
        if (completion) {
            completion(responseObject,YES);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil,NO);
        }
    }];
    
}

#pragma mark --请求正在直播等数据
+ (void)requestLiveRecommend:(XMLYBaseAPICompletion)completion
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //调用请求方法  GET请求
    [manager GETDataWithURL:kLiveRecommendAPI parameters:nil succeed:^(id responseObject) {
        if (completion) {
            completion(responseObject,YES);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil,NO);
        }
    }];
    
}

#pragma mark --请求推荐中的banner
+ (void)requestFooterAd:(XMLYBaseAPICompletion)completion
{
    
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //调用请求方法  GET请求
    [manager GETDataWithURL:kRecomBannerAPI parameters:nil succeed:^(id responseObject) {
        if (completion) {
            completion(responseObject,YES);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(nil,NO);
        }
    }];
    
    
}












@end
