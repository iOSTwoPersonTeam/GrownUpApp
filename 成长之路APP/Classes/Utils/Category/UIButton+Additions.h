//
//  UIButton+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageAndTitlePosition) {
    ImageAndTitlePositionLeft  = 0, //图片左 文字右 默认
    ImageAndTitlePositionRight = 1, //图片右 文字左
    ImageAndTitlePositionTop   = 2, //图片上 文字下
    ImageAndTitlePositionBottom = 3, //图片下 文字上
};

@interface UIButton (Additions)


/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(ImageAndTitlePosition )postion WithImageAndTitleSpacing:(CGFloat )spacing;

/*
 *  按钮添加倒计时
 */
-(void)countDown_startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;




@end


