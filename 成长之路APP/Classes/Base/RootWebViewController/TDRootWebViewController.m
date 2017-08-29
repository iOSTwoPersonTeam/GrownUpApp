//
//  TDRootWebViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/21.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootWebViewController.h"
#import "UIImage+CYButtonIcon.h"
#import "UIButton+WHE.h"

@interface TDRootWebViewController ()

@end

@implementation TDRootWebViewController

- (void)loadView
{
    [super loadView];
    
    self.title = self.title ?: @"浏览器";
}

+ (instancetype)loadURL:(NSString *)url
{
    TDRootWebViewController *webVC = [[TDRootWebViewController alloc] initWithURLString:url];
    webVC.showWebPageTitle = NO;
    webVC.showURLWhileLoading = NO;
    webVC.loadingBarTintColor =GlobalThemeColor;
    return webVC;
}








@end
