//
//  UIImage+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

/** * 自由拉伸一张图片
 * @param name 图片名字
 * @param left 左边开始位置比例 值范围0-1
 * @param top 上边开始位置比例 值范围0-1
 *  @return 拉伸后的Image
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 * 根据颜色和大小获取Image
 * @param color 颜色
 * @param size 大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(NSString *)baseImageName withColor:(UIColor *)theColor;

/*
 * 根据图片 对原有图片进行等比率缩放
 */
+ (UIImage *)scaleImage:(NSString *)imageName toScale:(float)scaleSize;

/*
 *  自由调整图片的大小
 */
+ (UIImage *)SizeImage:(NSString *)imageName toSize:(CGSize)reSize;

/*
 *  处理某个特定View  根据view生成相应的图片
 */
+ (UIImage*)captureView:(UIView *)theView;

/**图片剪切为圆形并且可以带边框
 * @param imageName 原始图片
 * @return 剪切后的圆形图片
 */
+ (UIImage *)getRoundImageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color imageName:(NSString *)imageName;

/**
 * 从给定UIView中截图：UIView转UIImage
 */
+ (UIImage *)cutScreenFromView:(UIView *)view;

/*
 * 截取scrollView的所有，包括下面没显示的（UITabelview，UIWebView类似）
 */
- (UIImage*)getScrollViewContentCapture:(UIScrollView *)scrollview;



@end


