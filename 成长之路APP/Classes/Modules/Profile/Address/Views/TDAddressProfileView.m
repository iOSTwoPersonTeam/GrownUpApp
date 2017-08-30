//
//  TDAddressProfileView.m
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDAddressProfileView.h"

@interface TDAddressProfileView ()

@property(nonatomic ,weak)UIImageView *elmImageView; //饿了么编辑
@property(nonatomic ,weak)UIImageView *mtwmImageView; //饿了么编辑

@end

@implementation TDAddressProfileView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ( self =[super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
}

#pragma mark ---UI--
-(void)setupView
{
    [self elmTitleLabel];
    [self elmDetailLabel];
    [self mtwmTitleLabel];
    [self mtwmDetailLabel];
    [self elmImageView];
    [self mtwmImageView];
}


#pragma mark ---布局--
-(void)layoutSubviews
{
    [super layoutSubviews];

    [self.elmTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@25);
    }];
    
    [self.elmDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.elmTitleLabel.mas_left).offset(0);
        make.top.equalTo(self.elmTitleLabel.mas_bottom).offset(0);
        make.width.equalTo(self.elmTitleLabel.mas_width);
        make.height.equalTo(self.elmTitleLabel.mas_height);
    }];
    
    [self.mtwmTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.elmTitleLabel.mas_left);
        make.top.equalTo(self.elmDetailLabel.mas_bottom).offset(10);
        make.width.equalTo(self.elmDetailLabel.mas_width);
        make.height.equalTo(self.elmDetailLabel.mas_height);
    }];
    
    [self.mtwmDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mtwmTitleLabel.mas_left);
        make.top.equalTo(self.mtwmTitleLabel.mas_bottom);
        make.width.equalTo(self.mtwmTitleLabel.mas_width);
        make.height.equalTo(self.mtwmTitleLabel.mas_height);
    }];
    
    [self.elmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.elmTitleLabel.mas_bottom).offset(-10);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    [self.mtwmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mtwmTitleLabel.mas_bottom).offset(-10);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];

}


#pragma mark ---pricate--
-(void)clickelmAddress
{
    if (self.elmAddressBlock) {
        self.elmAddressBlock();
    }
}

-(void)clickmtwmAddress
{
    if (self.mtwmAddressBlock) {
        self.mtwmAddressBlock();
    }
}



#pragma mark ---getter--
-(UILabel *)elmTitleLabel
{
    if (!_elmTitleLabel) {
        UILabel *elmTitleLabel =[[UILabel alloc] init];
        elmTitleLabel.backgroundColor =[UIColor whiteColor];
        elmTitleLabel.text =@"北京天安门城楼";
        [self addSubview:elmTitleLabel];
        elmTitleLabel.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickelmAddress)];
        [elmTitleLabel addGestureRecognizer:tap];
        _elmTitleLabel =elmTitleLabel;
    }
    return _elmTitleLabel;
}

-(UILabel *)elmDetailLabel
{
    if (!_elmDetailLabel) {
        UILabel *elmDetailLabel =[[UILabel alloc] init];
        elmDetailLabel.backgroundColor =[UIColor whiteColor];
        elmDetailLabel.textColor =[UIColor lightGrayColor];
        elmDetailLabel.font =[UIFont systemFontOfSize:14];
        elmDetailLabel.text =@"纬度:----经度:-----";
        [self addSubview:elmDetailLabel];
        _elmDetailLabel =elmDetailLabel;
        elmDetailLabel.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickelmAddress)];
        [elmDetailLabel addGestureRecognizer:tap];
    }
    return _elmDetailLabel;
}

-(UILabel *)mtwmTitleLabel
{
    if (!_mtwmTitleLabel) {
        UILabel *mtwmTitleLabel =[[UILabel alloc] init];
        mtwmTitleLabel.backgroundColor =[UIColor whiteColor];
        mtwmTitleLabel.text =@"北京海淀安河桥北";
        [self addSubview:mtwmTitleLabel];
        _mtwmTitleLabel =mtwmTitleLabel;
        mtwmTitleLabel.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickmtwmAddress)];
        [mtwmTitleLabel addGestureRecognizer:tap];
    }
    return _mtwmTitleLabel;
}

-(UILabel *)mtwmDetailLabel
{
    if (!_mtwmDetailLabel) {
        UILabel *mtwmDetailLabel =[[UILabel alloc] init];
        mtwmDetailLabel.backgroundColor =[UIColor whiteColor];
        mtwmDetailLabel.textColor =[UIColor lightGrayColor];
        mtwmDetailLabel.font =[UIFont systemFontOfSize:14];
        mtwmDetailLabel.text =@"纬度:---经度:----";
        [self addSubview:mtwmDetailLabel];
        _mtwmDetailLabel =mtwmDetailLabel;
        mtwmDetailLabel.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickmtwmAddress)];
        [mtwmDetailLabel addGestureRecognizer:tap];
    }
    return _mtwmDetailLabel;
}

-(UIImageView *)elmImageView
{
    if (!_elmImageView) {
        
        UIImageView *elmImageView =[[UIImageView alloc] init];
        elmImageView.image =[UIImage imageNamed:@"意见反馈"];
        [self addSubview:elmImageView];
        _elmImageView =elmImageView;
    }
    return _elmImageView;
}

-(UIImageView *)mtwmImageView
{
    if (!_mtwmImageView) {
        UIImageView *mtwmImageView =[[UIImageView alloc] init];
        mtwmImageView.image =[UIImage imageNamed:@"意见反馈"];
        [self addSubview:mtwmImageView];
        _mtwmImageView =mtwmImageView;
    }
    return _mtwmImageView;
}


@end


