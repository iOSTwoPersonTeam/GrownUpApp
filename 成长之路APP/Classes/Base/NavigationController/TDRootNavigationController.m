//
//  TDRootNavigationController.m
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootNavigationController.h"
#import "TDTabBarViewController.h"

@interface TDRootNavigationController ()

@end

@implementation TDRootNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.backgroundColor = [UIColor whiteColor];
        self.navigationBar.tintColor = GlobalThemeColor;
        self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18],NSForegroundColorAttributeName : GlobalThemeColor};
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1 && [self.parentViewController isKindOfClass:[TDTabBarViewController class]]) {
        [(TDTabBarViewController*)self.parentViewController xmTabBarHidden:YES animated:YES];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 2 && [self.parentViewController isKindOfClass:[TDTabBarViewController class]]) {
        [(TDTabBarViewController*)self.parentViewController xmTabBarHidden:NO animated:YES];
    }
    return [super popViewControllerAnimated:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}


@end




