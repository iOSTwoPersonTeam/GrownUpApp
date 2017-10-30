//
//  XMLYFindAPI.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "XMLYBaseAPI.h"

@interface XMLYFindAPI : XMLYBaseAPI

/*
 *  请求精品歌词和 小编推荐数据
 */
+(void)requestRecommends:(XMLYBaseAPICompletion)completion;

/**
 *  请求发现新奇、猜你喜欢等数据
 */
+ (void)requestHotAndGuess:(XMLYBaseAPICompletion)completion;

/**
 *  请求正在直播等数据
 */
+ (void)requestLiveRecommend:(XMLYBaseAPICompletion)completion;
/**
 *  请求推荐中的banner
 */
+ (void)requestFooterAd:(XMLYBaseAPICompletion)completion;


@end
