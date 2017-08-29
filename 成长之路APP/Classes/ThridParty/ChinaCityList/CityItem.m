//
//  CityItem.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityItem.h"

@implementation CityItem

- (instancetype)init
{
    if (self = [super init]) {
        _name = @"";
        _TYPE = @"";
        _CODE = @"";
        _PCODE = @"";
        _PINYIN = @"";
        _city = @"";
        _address = @"";
        _point = CLLocationCoordinate2DMake(0, 0);
    }
    return self;
}

- (instancetype)initWithTitleName:(NSString *)titleName {
    if (self = [self init]) {
        _name = [NSString stringWithFormat:@"%@",titleName];
    }
    return self;
}

+ (instancetype)initWithTitleName:(NSString *)titleName {
    
    return [[self alloc] initWithTitleName:titleName];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"name" : @"NAME"};
}

@end
