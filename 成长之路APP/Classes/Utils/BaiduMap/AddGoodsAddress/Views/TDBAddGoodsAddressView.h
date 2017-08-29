//
//  TDBAddGoodsAddressView.h
//  成长之路APP
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDBAddGoodsAddressView : UIView

@property(nonatomic ,copy) void(^addAddressBlock)(); //选择地址
@property(nonatomic ,copy) void(^makeSureBlock)(); //确认

-(void)getNewTitleAddress:(NSString *)titleAddress withDetailAddress:(NSString *)detailAddress;

@end


