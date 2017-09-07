//
//  UIView+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/9/7.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (Additions)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addGesture_TapActionWithBlock:(GestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addGesture_LongPressActionWithBlock:(GestureActionBlock)block;



@end
