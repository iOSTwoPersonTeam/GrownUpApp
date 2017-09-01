//
//  TDAddressProfileView.h
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDAddressProfileView : UIView

@property(nonatomic ,weak)UILabel *elmTitleLabel;  //饿了么标题
@property(nonatomic ,weak)UILabel *elmDetailLabel; //饿了么详情
@property(nonatomic ,weak)UILabel *mtwmTitleLabel; //美团外卖标题
@property(nonatomic ,weak)UILabel *mtwmDetailLabel; //美团外卖详情

@property(nonatomic ,copy) void(^elmAddressBlock)();
@property(nonatomic ,copy) void(^mtwmAddressBlock)();


@end
