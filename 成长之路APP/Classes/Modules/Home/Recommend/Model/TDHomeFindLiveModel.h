//
//  TDHomeFindLiveModel.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDHomeFindLiveDetailModel;

@interface TDHomeFindLiveModel : NSObject

@property (nonatomic, strong) NSMutableArray<TDHomeFindLiveDetailModel *> *data;

@property (nonatomic, assign) NSInteger  ret;

@end


@interface TDHomeFindLiveDetailModel : NSObject

/**
 *  频道ID
 */
@property (nonatomic, assign) NSInteger chatId;

/**
 *  封面路径
 */
@property (nonatomic, copy)   NSString  *coverPath;

/**
 *  未知参数
 */
@property (nonatomic, assign) NSInteger endTs;

/**
 *  唯一标识
 */
@property (nonatomic, assign) NSInteger cid;

/**
 *  名称
 */
@property (nonatomic, copy)   NSString  *name;

/**
 *  联网数量
 */
@property (nonatomic, assign) NSInteger onlineCount;

/**
 *  播放量
 */
@property (nonatomic, assign) NSInteger playCount;

/**
 *  未知参数
 */
@property (nonatomic, assign) NSInteger scheduleId;

/**
 *  短描述
 */
@property (nonatomic, copy)   NSString  *shortDescription;

@property (nonatomic, assign) NSInteger startTs;
@property (nonatomic, assign) NSInteger status;

@end
