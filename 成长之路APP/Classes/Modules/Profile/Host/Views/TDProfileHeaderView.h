//
//  TDProfileHeaderView.h
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDProfileHeaderView : UIView

@property(nonatomic,copy) void(^clickImageBlock)();

//提供一个`模型`属性，重写模型属性的set方法
@property(nonatomic,strong) TDUserModel *dataModel; //数据

@end
