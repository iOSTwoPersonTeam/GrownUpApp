//
//  TDMTMapViewController.h
//  成长之路APP
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDMTMapViewController : TDRootViewController

@property(nonatomic, assign)CLLocationCoordinate2D location; //经纬度
@property(nonatomic, copy) void(^getAddressBlock)(NSString *detailAddress ,CLLocationCoordinate2D location);

@end
