//
//  TDHomeRecommendModel.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeRecommendModel.h"

@implementation TDHomeRecommendModel

@end

@implementation XMLYFindEditorRecommendAlbumModel

@end

@implementation XMLYSpecialColumnModel

@end

@implementation XMLYSpecialColumnDetailModel

@end

@implementation XMLYFindFocusImagesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[XMLYFindFocusImageDetailModel class]};
}

@end

@implementation XMLYFindFocusImageDetailModel

@end

@implementation XMLYFindEditorRecommendDetailModel

@end
