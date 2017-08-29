//
//  UIBarButtonItem+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)


+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image
                                    highlighted:(UIImage *)highlightedImage
                                         target:(id)target
                                       selector:(SEL)selector;

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image
                                     highlighted:(UIImage *)highlightedImage
                                          target:(id)target
                                        selector:(SEL)selector;

+ (UIBarButtonItem *) leftBarButtonItemWithTitle:(NSString *)title
                                      titleColor:(UIColor*)titleColor
                                          target:(id)target
                                        selector:(SEL)selector;

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title
                                      titleColor:(UIColor*)titleColor
                                          target:(id)target
                                        selector:(SEL)selector;

@end




