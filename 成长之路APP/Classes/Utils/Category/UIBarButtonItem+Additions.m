//
//  UIBarButtonItem+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"

@implementation UIBarButtonItem (Additions)


+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image
                                    highlighted:(UIImage *)highlightedImage
                                         target:(id)target
                                       selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 11.5, 20);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.imageView.contentMode=UIViewContentModeScaleAspectFit;
    button.adjustsImageWhenHighlighted = NO;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image
                                     highlighted:(UIImage *)highlightedImage
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 27, 27);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *) leftBarButtonItemWithTitle:(NSString *)title
                                      titleColor:(UIColor*)titleColor
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 32);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor ?: [UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button sizeToFit];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title
                                      titleColor:(UIColor*)titleColor
                                          target:(id)target
                                        selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 32);
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitleColor:titleColor ?: [UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end




