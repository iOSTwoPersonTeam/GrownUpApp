//
//  TDRootViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDRootViewController ()

@end

@implementation TDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     //注意这里的设置,影响到ViewController控制器的布局的问题
    self.view.backgroundColor = GlobalBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hidesBottomBarWhenPushed = YES;
    self.preferredContentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    if (self.backEnabled) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftBarButtonItemWithImage:[UIImage imageNamed:@"返回"] highlighted:[UIImage imageNamed:@"返回"] target:self selector:@selector(back)];
    }
    
}

//返回事件
- (void)back
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self navigationBack];
}







@end





