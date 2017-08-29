//
//  NSString+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)validateMobile;     //手机号格式
- (BOOL)validateIdCard;     //身份证号格式

- (NSString *)getMd5;       //Md5加密字符串

// 获取指定最大宽度、最大高度、字体大小的string的size
- (CGSize)getSizeWithMaxWidth:(float)width maxHeight:(float)height withFontSize:(CGFloat)fontSize;

@end
