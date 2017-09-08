//
//  TDContentScrollView.h
//  成长之路APP
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDContentScrollView : UIScrollView


@property(nonatomic, strong)UIView *functionHeaderView; //上方主功能区域
@property(nonatomic, strong)UIView *headerSpaceView;  //功能区下方空间
@property(nonatomic, strong)UIView *headerView;

@end
