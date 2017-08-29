//
//  NSString+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additions)


/**
 *	@brief	正则校验-手机号码---所有类型的电话号码
 *
 *	@return	返回是否合法手机号码（BOOL）
 */
- (BOOL)validateMobile
{
    //验证手机号格式
    NSString *MOBILE = @"^((13[0-9])|(15[^4,\\D])|(14[5,7])|(17[0,6-8])|(18[0-9]))\\d{8}$";
    NSPredicate *regextestmobile=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL res = [regextestmobile evaluateWithObject:self];
    if (res)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *	@brief	正则校验-身份证号码
 *
 *	@return	返回是否合法身份证号（BOOL）
 */
- (BOOL)validateIdCard
{
    NSString *valueRegex1 = @"^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\\d{3}(x|X))|(\\d{4}))";
    NSPredicate *valueTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valueRegex1];
    NSString *valueRegex2 = @"^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((([02468][048])|([13579][26]))0229))|([0-9][0-9])((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))(\\d{3})";
    NSPredicate *valueTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valueRegex2];
    return [valueTest1 evaluateWithObject:self] || [valueTest2 evaluateWithObject:self];
}

//---MD5加密
- (NSString *)getMd5
{
    if (self == nil || [self length] == 0)
    {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}


// 获取指定最大宽度、最大高度、字体大小的string的size
- (CGSize)getSizeWithMaxWidth:(float)width maxHeight:(float)height withFontSize:(CGFloat)fontSize
{
    CGSize size =  [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}

@end
