//
//  UILabel+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

//改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

//改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

//改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}


//换行同时修改字体颜色大小
+(void )changeLineForLabel:(UILabel *)label withLineIndex:(NSUInteger )index withTitleClolor:(UIColor *)titlecolor withTitleFont:(UIFont *)titleFont
{
    label.textAlignment =NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    NSMutableString *labelText = [NSMutableString stringWithString:label.text];
    if (![labelText containsString:@"\n"]) {
        [labelText insertString:@"\n" atIndex:index];
    }
    
    NSMutableAttributedString *attributer = [[NSMutableAttributedString alloc]initWithString:labelText];
    
    [attributer addAttribute:NSForegroundColorAttributeName
                       value:titlecolor
                       range:NSMakeRange(0, index)];
    
    [attributer addAttribute:NSFontAttributeName
                       value:titleFont
                       range:NSMakeRange(0, index)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];//调整行间距
    
    [paragraphStyle setLineSpacing:4];
    [attributer addAttribute:NSParagraphStyleAttributeName
                       value:paragraphStyle
                       range:NSMakeRange(0, labelText.length)];
    
    [paragraphStyle setAlignment:NSTextAlignmentCenter];//为了美观调整行间距，但是当调整行间距时上面设置的居中不能用看 所以要加这一句 [paragraphStyle setAlignment:NSTextAlignmentCenter] 不然没有居中效果
    
    label.attributedText = attributer;
//    [label sizeToFit];   //这句话是根据内容调整大小 这里不需要
    
}



@end
