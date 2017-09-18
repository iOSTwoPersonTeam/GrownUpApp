//
//  TDPaymentStatusViewController.m
//  EveryDay
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 Tidoo. All rights reserved.
//

#import "TDPaymentStatusViewController.h"

@interface TDPaymentStatusViewController ()

@property(nonatomic,strong)UIImageView *statusImageView;
@property(nonatomic,strong)UILabel *statusLabel;

@end

@implementation TDPaymentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"支付"; //头部标题显示

    [self.view addSubview:self.statusImageView]; //添加图片
    [self.view addSubview:self.statusLabel];  //添加文字
    self.statusImageView.highlighted =!self.statusType;
}


#pragma mark ---Private---
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma Delegate----



#pragma mark ----getter---
-(UIImageView *)statusImageView
{
    if (!_statusImageView) {
        _statusImageView =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -40, SCREEN_HEIGHT/3, 80, 80)];
        _statusImageView.backgroundColor =[UIColor whiteColor];
        [_statusImageView setImage:[UIImage imageNamed:@"支付成功"]];
        [_statusImageView setHighlightedImage:[UIImage imageNamed:@"支付失败"]];
    }
    return _statusImageView;
}

-(UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusImageView.frame) +10, SCREEN_WIDTH, 30)];
        _statusLabel.backgroundColor =[UIColor whiteColor];
        _statusLabel.textAlignment =NSTextAlignmentCenter;
        _statusLabel.font =[UIFont systemFontOfSize:22];
        if (self.statusType) {
             _statusLabel.text =@"恭喜您,付款成功!";
        } else{
            _statusLabel.text =@"很抱歉,付款失败!";
        }
    }
    return _statusLabel;
}


@end
