//
//  XMLYBaseAPI.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "XMLYBaseAPI.h"

@implementation XMLYBaseAPI

+(NSMutableDictionary *)params
{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    [dic setObject:@"iPhone" forKey:@"device"];
    return dic;
}


@end
