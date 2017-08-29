//
//  TDBAddGoodsAddressViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDBAddGoodsAddressViewController : TDRootViewController

@property(nonatomic,strong)NSString *currentDetailAddress; //当前详细地理位置(经过反编码的)
@property(nonatomic,strong)NSString *currentCity; //当前城市

@property(nonatomic,strong)NSString *currentPositionString; //当前经纬度NSString

@end
