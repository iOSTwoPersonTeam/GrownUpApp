//
//  TDLaunchAdModel.h
//  成长之路APP
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLaunchAdModel : NSObject

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *content;

/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *openUrl;

/**
 *  广告分辨率
 */
@property (nonatomic, copy) NSString *contentSize;

/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;


/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat width;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat height;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end
