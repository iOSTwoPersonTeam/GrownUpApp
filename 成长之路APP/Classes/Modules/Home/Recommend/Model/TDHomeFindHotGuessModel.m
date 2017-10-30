//
//  TDHomeFindHotGuessModel.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeFindHotGuessModel.h"

@implementation TDHomeFindHotGuessModel

@end

@implementation XMLYFindDiscoverColumnsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":@"XMLYFindDiscoverDetailModel"};
}

@end


@implementation XMLYFindDiscoverDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"properties":@"XMLYFindDiscoverProperityModel"};
}

@end

@implementation XMLYFindDiscoverProperityModel


@end

@implementation XMLYFindGuessMode


@end


@implementation XMLYCityColumnModel


@end


@implementation XMLYHotRecommend


@end

@implementation XMLYHotRecommendItemModel


@end
