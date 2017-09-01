//
//  TDNearbyAddressView.h
//  成长之路APP
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDNearbyAddressView : UIView

@property(nonatomic ,copy) void(^selectIndexPathBlock)(NSString *address);

-(void)getDataWithArray:(NSArray <BMKPoiInfo *> *)dataArray;



@end
