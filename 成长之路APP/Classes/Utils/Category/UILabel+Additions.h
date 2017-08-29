//
//  UILabel+Additions.h
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)


/**
 * 改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 * 改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 * 改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;



@end



