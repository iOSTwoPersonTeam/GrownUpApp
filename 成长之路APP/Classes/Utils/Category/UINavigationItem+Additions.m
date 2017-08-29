//
//  UINavigationItem+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UINavigationItem+Additions.h"

@implementation UINavigationItem (Additions)


+ (UILabel *)titleViewForTitle:(NSString *)title
{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.font = [UIFont fontWithName:@"Helvetica" size:18];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = GlobalThemeColor;
    titleView.text = [NSString stringWithFormat:@"%@",title];
    [titleView sizeToFit];
    return titleView;
}




@end



