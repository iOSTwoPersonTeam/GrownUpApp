//
//  TDLaunchAdModel.m
//  成长之路APP
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDLaunchAdModel.h"

@implementation TDLaunchAdModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
    }
    return self;
}
-(CGFloat)width
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}
-(CGFloat)height
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}

@end
