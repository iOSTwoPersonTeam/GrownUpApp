//
//  TDBAddGoodsAddressViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDBAddGoodsAddressViewController : TDRootViewController

@property(nonatomic, copy) void(^getAddressBlock)(NSString *detailAddress ,CLLocationCoordinate2D location);

@end
