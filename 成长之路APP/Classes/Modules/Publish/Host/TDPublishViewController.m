//
//  TDPublishViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPublishViewController.h"

@interface TDPublishViewController ()

@end

@implementation TDPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布需求";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithTitle:@"取消" titleColor:[UIColor redColor] target:self selector:@selector(cancel)];
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end





