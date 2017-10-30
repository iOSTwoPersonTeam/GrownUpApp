//
//  TDHomeFindHotGuessModel.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDHomeRecommendModel.h"

@class XMLYFindDiscoverProperityModel,XMLYFindDiscoverColumnsModel,XMLYFindDiscoverDetailModel,XMLYFindGuessMode,XMLYCityColumnModel,XMLYHotRecommend,XMLYHotRecommendItemModel;

/**
 *  热门、推荐模型
 */
@interface TDHomeFindHotGuessModel : NSObject

//
@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, strong) XMLYFindDiscoverColumnsModel *discoveryColumns;

@property (nonatomic, strong) XMLYFindGuessMode            *guess;

@property (nonatomic, strong) XMLYCityColumnModel          *cityColumn;

@property (nonatomic, strong) XMLYHotRecommend             *hotRecommends;

@end

#pragma mark - 发现新奇

@interface XMLYFindDiscoverColumnsModel : NSObject

@property (nonatomic, assign) NSInteger         ret;

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, strong) NSMutableArray<XMLYFindDiscoverDetailModel *>    *list;

@end

@interface XMLYFindDiscoverDetailModel : NSObject

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, copy)   NSString          *subtitle;

@property (nonatomic, copy)   NSString          *coverPath;

@property (nonatomic, copy)   NSString          *contentType;

@property (nonatomic, copy)   NSString          *url;

@property (nonatomic, copy)   NSString          *sharePic;

@property (nonatomic, assign) BOOL              enableShare;

@property (nonatomic, assign) BOOL              isExternalUrl;

@property (nonatomic, strong) XMLYFindDiscoverProperityModel  *properties;

@end

@interface XMLYFindDiscoverProperityModel : NSObject

@property (nonatomic, copy)   NSString           *contentType;

@property (nonatomic, assign) NSInteger          rankingListId;

@property (nonatomic, assign) BOOL               isPaid;

@property (nonatomic, copy)   NSString           *key;

@end

#pragma mark - 猜你喜欢

@interface XMLYFindGuessMode : NSObject

@property (nonatomic, assign) BOOL              hasMore;

@property (nonatomic, copy)   NSString          *title;

@property (nonatomic, strong) NSMutableArray    *list;

@end

#pragma mark - 城市相册

@interface XMLYCityColumnModel : NSObject

@property (nonatomic, assign) BOOL                                                  hasMore;

@property (nonatomic, copy)   NSString                                              *title;

@property (nonatomic, assign) NSInteger                                             count;

@property (nonatomic, strong) NSMutableArray<XMLYFindEditorRecommendDetailModel *>  *list;

@property (nonatomic, copy)   NSString                                              *contentType;

@property (nonatomic, copy)   NSString                                              *code;

@end


#pragma mark - 热门推荐

@interface XMLYHotRecommend : NSObject

@property (nonatomic, assign) NSInteger    ret;

@property (nonatomic, copy)   NSString     *title;

@property (nonatomic, strong) NSMutableArray<XMLYHotRecommendItemModel *>   *list;

@end


@interface XMLYHotRecommendItemModel : NSObject

@property (nonatomic, copy) NSString    *title;

@property (nonatomic, copy) NSString    *contentType;

@property (nonatomic, assign) BOOL      isFinished;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger categoryType;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) BOOL      hasMore;

@property (nonatomic, strong) NSMutableArray<XMLYFindEditorRecommendDetailModel *>    *list;

@property (nonatomic, assign) BOOL      filterSupported;

@property (nonatomic, assign) BOOL      isPaid;

@end
