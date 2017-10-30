//
//  XMLYBaseAPI.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XMLYBaseAPICompletion)(id responseObject,BOOL success);

@interface XMLYBaseAPI : NSObject

+(NSMutableDictionary *)params;

@end
