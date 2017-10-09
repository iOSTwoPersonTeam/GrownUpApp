//
//  TDRunningTrackDataView.h
//  成长之路APP
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDRunningTrackDataView : UIView

@property(nonatomic, copy) void (^clickIntoMapBlock)(); //点击地图事件
@property(nonatomic, copy) void (^clickButtonBlock)(NSString *title); //继续暂停按钮点击事件
@property(nonatomic, copy) void(^clickEndButtonTimeBlock)(NSString *title ,NSTimeInterval timeInterval); //结束按钮

-(void)getDateWithDistance:(NSString *)distance withSpeed:(CGFloat )speeds withSpace:(NSInteger )spaces;

@end
