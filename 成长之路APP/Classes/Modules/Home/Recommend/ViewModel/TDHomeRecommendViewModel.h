//
//  TDHomeRecommendViewModel.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDHomeRecommendModel.h"
#import "TDHomeFindLiveModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDHomeRecommendViewModel : NSObject

//更新数据的信号量
@property(nonatomic,readonly)RACSignal *updateContentSignal;

/*
 *  推荐数据动态
 */
@property(nonatomic, strong)TDHomeRecommendModel *recommendModel;

/**
 *  推荐、热门
 */
@property (nonatomic, strong) TDHomeFindHotGuessModel  *hotGuessModel;

/**
 *  直播数据动态
 */
@property (nonatomic, strong) TDHomeFindLiveModel      *liveModel;



-(void)refreshDataSource;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (CGSize)sizeForRowAtIndex:(NSIndexPath *)indexPath;

@end






