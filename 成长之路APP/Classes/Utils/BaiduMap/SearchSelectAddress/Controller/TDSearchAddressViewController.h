//
//  TDSearchAddressViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <PYSearch/PYSearch.h>

@interface TDSearchAddressViewController : TDRootViewController

@property(nonatomic ,copy) void(^searchGetResultBlock)(BMKPoiDetailResult *info);

@end
