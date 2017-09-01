//
//  TDNearbyAddressViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface TDNearbyAddressViewController : TDRootTableViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic,assign)CLLocationCoordinate2D location;

@end
