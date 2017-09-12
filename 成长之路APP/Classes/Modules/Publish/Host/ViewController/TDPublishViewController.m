//
//  TDPublishViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPublishViewController.h"
#import "TDPublishAnimateView.h"

@interface TDPublishViewController ()<TDPublishAnimateViewDeleagte>
@property(nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,strong)TDPublishAnimateView *buttonView;
@property(nonatomic,strong)NSArray *textArr;
@property(nonatomic,strong)NSArray *imgArr;

@end

@implementation TDPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage SizeImage:@"发布背景" toSize:self.view.bounds.size]];
    //毛玻璃 模糊效果
     [self addBlurEffect];
    self.cancelButton.backgroundColor =[UIColor clearColor];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.cancelButton.transform = CGAffineTransformRotate(self.cancelButton.transform, M_PI);
    }];
    [self.buttonView show];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

#pragma mark ---Private---
- (void)clickCancel
{
    [self.buttonView close:^{
        self.cancelButton.transform = CGAffineTransformRotate(self.cancelButton.transform, -M_PI_2*1.5);
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self clickCancel];
}


#pragma mark ----Delegate----
#pragma mark ----TDPublishAnimateViewDeleagte---
-(void)addAnimateViewButton:(UIButton *)button andIndex:(NSInteger)index
{
    DLog(@"%ld------",(long)index);

}


#pragma mark ----getter----
-(TDPublishAnimateView *)buttonView
{
    if (!_buttonView) {
        _buttonView =[[TDPublishAnimateView alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT/2 +30, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        _buttonView.backgroundColor =[UIColor clearColor];
        _buttonView.textArray = self.textArr;
        _buttonView.imageNameArray = self.imgArr;
        _buttonView.delegate = self;
        [self.view addSubview:_buttonView];
    }
    return _buttonView;
}

-(NSArray *)textArr
{
    if (!_textArr) {
        _textArr =@[@"文字",@"图片",@"视频",@"语音",@"投票",@"签到"];
    }
    return _textArr;
}

-(NSArray *)imgArr
{
    if (!_imgArr) {
        _imgArr =@[@"publish_文字",@"publish_图片",@"publish_视频",@"publish_语音",@"publish_投票",@"publish_签到"];
    }
    return _imgArr;
}

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

//毛玻璃 模糊效果
- (void)addBlurEffect {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.bounds;
    //         effectView.alpha = 0.9;
    [self.view addSubview:effectView];
    [self.view sendSubviewToBack:effectView];
}



@end





