//
//  TDThirdPartyLoginView.m
//  成长之路APP
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDThirdPartyLoginView.h"

@interface TDThirdPartyLoginView ()

@property(nonatomic, strong) UILabel *lineLabel; //实线
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *weixinButton; //微信
@property(nonatomic, strong) UIButton *QQButton; //QQ
@property(nonatomic, strong) UIButton *weiboButton; //微博

@end

@implementation TDThirdPartyLoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
    }
    
    return self;
}


#pragma mark ---private
//微信
-(void)clickweixinbutton
{
    if (self.clickweixinBlock) {
        self.clickweixinBlock();
    }
}
//QQ
-(void)clickQQButton
{
    if (self.clickQQBlock) {
        self.clickQQBlock();
    }
}
//微博
-(void)clickweiboBotton
{
    if (self.clickweiboBlock) {
        self.clickweiboBlock();
    }
    
}


#pragma mark --布局
-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(@10);
        make.height.equalTo(@1);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.lineLabel.mas_centerY);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@20);
    }];
    
    [self.weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-SCREEN_WIDTH/3);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(60);
        make.width.equalTo(@(80));
        make.height.equalTo(@(100));
    }];
    
    [self.QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.weixinButton.mas_top).offset(0);
        make.width.equalTo(self.weixinButton.mas_width);
        make.height.equalTo(self.weixinButton.mas_height);
    }];

    [self.weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(SCREEN_WIDTH/3);
        make.top.equalTo(self.weixinButton.mas_top).offset(0);
        make.width.equalTo(self.weixinButton.mas_width);
        make.height.equalTo(self.weixinButton.mas_height);
    }];
    
    [self.weixinButton setImagePosition:ImageAndTitlePositionTop WithImageAndTitleSpacing:10];
    [self.QQButton setImagePosition:ImageAndTitlePositionTop WithImageAndTitleSpacing:10];
    [self.weiboButton setImagePosition:ImageAndTitlePositionTop WithImageAndTitleSpacing:10];
}




#pragma mark ---getter

-(UILabel *)lineLabel
{
    if (!_lineLabel) {
        
        _lineLabel =[[UILabel alloc] init];
        _lineLabel.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLabel];
    }
    return _lineLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.text =@"其他方式登录";
        _titleLabel.font =[UIFont systemFontOfSize:14];
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        _titleLabel.backgroundColor =[UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
  
    return _titleLabel;
}

-(UIButton *)weixinButton
{
    if (!_weixinButton) {
        
        _weixinButton =[[UIButton alloc] init];
        [_weixinButton setImage:[UIImage SizeImage:@"weixinMark" toSize:CGSizeMake(60, 60)] forState:UIControlStateNormal];
        [_weixinButton setTitle:@"微信登录" forState:UIControlStateNormal];
        _weixinButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_weixinButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:_weixinButton];
        [_weixinButton addTarget:self action:@selector(clickweixinbutton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinButton;
}

-(UIButton *)QQButton
{
    if (!_QQButton) {
        
        _QQButton =[[UIButton alloc] init];
        [_QQButton setImage:[UIImage SizeImage:@"QQMark" toSize:CGSizeMake(60, 60)] forState:UIControlStateNormal];
        [_QQButton setTitle:@"QQ登录" forState:UIControlStateNormal];
        _QQButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_QQButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:_QQButton];
        [_QQButton addTarget:self action:@selector(clickQQButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QQButton;
}

-(UIButton *)weiboButton
{
    if (!_weiboButton) {
        
        _weiboButton =[[UIButton alloc] init];
        [_weiboButton setImage:[UIImage SizeImage:@"weiboMark" toSize:CGSizeMake(60, 60)] forState:UIControlStateNormal];
        [_weiboButton setTitle:@"微博登录" forState:UIControlStateNormal];
        [_weiboButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _weiboButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:_weiboButton];
        [_weiboButton addTarget:self action:@selector(clickweiboBotton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboButton;
}










@end




