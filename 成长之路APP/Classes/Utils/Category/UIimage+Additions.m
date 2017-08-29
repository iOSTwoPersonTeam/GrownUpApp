//
//  UIImage+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

/** * 自由拉伸一张图片
 * @param name 图片名字 
 * @param left 左边开始位置比例 值范围0-1 
 * @param top 上边开始位置比例 值范围0-1 
 *  @return 拉伸后的Image
*/
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

/** 
 * 根据颜色和大小获取Image 
 * @param color 颜色
 * @param size 大小 
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set]; UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 
 * 根据图片和颜色返回一张加深颜色以后的图片 
 */
+ (UIImage *)colorizeImage:(NSString *)baseImageName withColor:(UIColor *)theColor {
    
    UIImage *baseImage =[UIImage imageNamed:baseImageName];
    UIGraphicsBeginImageContext(CGSizeMake(baseImage.size.width*2, baseImage.size.height*2));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width * 2, baseImage.size.height * 2);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    [theColor set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return newImage;
}


/*
 * 根据图片 对原有图片进行等比率缩放
 */
+ (UIImage *)scaleImage:(NSString *)imageName toScale:(float)scaleSize

{
    UIImage *image =[UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
     return scaledImage;
}

/*
 *  自由调整图片的大小
 */
+ (UIImage *)SizeImage:(NSString *)imageName toSize:(CGSize)reSize

{
    UIImage *image =[UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/*
 *  处理某个特定View  根据view生成相应的图片
 */
+ (UIImage*)captureView:(UIView *)theView

{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**图片剪切为圆形并且可以带边框
 * @param imageName 原始图片
 * @return 剪切后的圆形图片
 */
+ (UIImage *)getRoundImageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color imageName:(NSString *)imageName
{
    //获取size
    UIImage *image =[UIImage imageNamed:imageName];
    //获取图片尺寸
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 * borderW);
    
    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //绘制一个大圆,填充
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];

    //3.添加一个裁剪区域
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    
    //4.把图片绘制到裁剪区域当中.
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    //取出图片
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return roundImage;
    
}


/** 
 * 从给定UIView中截图：UIView转UIImage 
 */
+ (UIImage *)cutScreenFromView:(UIView *)view
{
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //在新建的图形上下文中渲染view的layer
    [view.layer renderInContext:context];
    
    [[UIColor clearColor] setFill];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}


/*
 * 截取scrollView的所有，包括下面没显示的（UITabelview，UIWebView类似）
 */
- (UIImage*)getScrollViewContentCapture:(UIScrollView *)scrollview
{
    
    UIImage* viewImage = nil;
    
    UIScrollView *scrollView =scrollview;
    
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}




@end







