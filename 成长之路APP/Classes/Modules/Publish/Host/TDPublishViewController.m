//
//  TDPublishViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPublishViewController.h"

@interface TDPublishViewController ()

@property(nonatomic,strong)UIButton *cancelButton;

@end

@implementation TDPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.cancelButton.backgroundColor =[UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.cancelButton.transform = CGAffineTransformRotate(self.cancelButton.transform, M_PI);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}



#pragma mark ---Private---
- (void)clickCancel
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cancelButton.transform = CGAffineTransformRotate(self.cancelButton.transform, -M_PI_2*1.5);
    }];
    
        [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark ----Delegate----



#pragma mark ----getter----
-(UIButton *)cancelButton
{
    if (_cancelButton ==nil) {
        
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        backView.backgroundColor =[UIColor whiteColor];
        [self.view addSubview:backView];
        
        UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(backView.frame), SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor =[UIColor lightGrayColor];
        [backView addSubview:lineLabel];
        
        
        _cancelButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -10, 15, 20, 20)];
        [_cancelButton setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
        [backView addSubview:_cancelButton];
        [_cancelButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
    
}

@end





