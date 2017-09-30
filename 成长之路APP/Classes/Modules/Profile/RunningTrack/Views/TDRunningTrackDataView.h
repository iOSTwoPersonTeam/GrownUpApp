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
@property(nonatomic, copy) void (^clickButtonBlock)(NSString *title); //按钮点击事件

@property(nonatomic, copy)NSDictionary *modelDic; //模型字典

@end
