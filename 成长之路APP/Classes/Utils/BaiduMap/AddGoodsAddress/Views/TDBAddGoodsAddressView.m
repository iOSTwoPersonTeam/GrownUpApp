//
//  TDBAddGoodsAddressView.m
//  成长之路APP
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDBAddGoodsAddressView.h"

@interface TDBAddGoodsAddressView ()

@property(nonatomic ,weak)UIView *bigAddressView; //地址承载view
@property(nonatomic ,weak)UIImageView *AddressImageView; //地址图片
@property(nonatomic ,weak)UILabel *titleAddressLabel; //地址
@property(nonatomic ,weak)UIImageView *arrowImageView; //地址箭头
@property(nonatomic ,weak)UILabel *lineLabel; //实线
@property(nonatomic ,weak)UITextField *detailAddressTextField; //详细地址
@property(nonatomic ,weak)UIButton *makeSureButton; //确定按钮

@end


@implementation TDBAddGoodsAddressView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
     
        [self setuplocationView];
    }
    return self;
}

#pragma mark --UI
-(void)setuplocationView
{
    [self AddressImageView];
    [self titleAddressLabel];
    [self arrowImageView];
    [self lineLabel];
    [self detailAddressTextField];
    [self makeSureButton];
}


#pragma mark --布局方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.bigAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(@0);
        make.height.equalTo(@81);
    }];
    
    [self.AddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bigAddressView.mas_right).offset(-5);
        make.top.equalTo(self.AddressImageView.mas_top);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.titleAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.AddressImageView.mas_right).offset(5);
        make.top.equalTo(@0);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-5);
        make.height.equalTo(@40);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleAddressLabel).offset(0);
        make.top.equalTo(self.titleAddressLabel.mas_bottom).offset(1);
        make.right.equalTo(self.bigAddressView.mas_right).offset(0);
        make.height.equalTo(@1);
    }];
    
    [self.detailAddressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineLabel.mas_left).offset(0);
        make.right.equalTo(self.lineLabel.mas_right).offset(0);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(0);
        make.height.equalTo(@40);
    }];
    
    [self.makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.bigAddressView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
}


#pragma mark ---private

//获取数值
-(void)getNewTitleAddress:(NSString *)titleAddress withDetailAddress:(NSString *)detailAddress
{
    self.titleAddressLabel.text =titleAddress;
    self.detailAddressTextField.text =detailAddress;
    
}

//更新获得主地址
-(void)clickGetAddress
{
    if (self.addAddressBlock) {
        self.addAddressBlock();
    }
}

//确定按钮
-(void)clickmakeSure
{
    if (self.makeSureBlock) {
        self.makeSureBlock(self.titleAddressLabel.text);
    }

}




#pragma mark ----delagate













#pragma mark ---getter



-(UIView *)bigAddressView
{
    if (!_bigAddressView) {
        UIView *bigAddressView =[[UIView alloc] init];
        bigAddressView.backgroundColor =[UIColor whiteColor];
        [self addSubview:bigAddressView];
        _bigAddressView =bigAddressView;
    }
  
    return _bigAddressView;
}

//地址图片
-(UIImageView *)AddressImageView
{
    if (!_AddressImageView) {
        UIImageView *AddressImageView =[[UIImageView alloc] init];
        AddressImageView.image =[UIImage imageNamed:@"locationArrow"];
        [self.bigAddressView addSubview:AddressImageView];
        AddressImageView.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGetAddress)];
        [AddressImageView addGestureRecognizer:tap];
        
        _AddressImageView =AddressImageView;

    }
    return _AddressImageView;
}

//主地址
-(UILabel *)titleAddressLabel
{
    if (!_titleAddressLabel) {
       UILabel *titleAddressLabel =[[UILabel alloc] init];
        titleAddressLabel.text =@"花园闸北里社区";
        titleAddressLabel.font =[UIFont systemFontOfSize:15 weight:2.0];
        titleAddressLabel.textColor =[UIColor blackColor];
        titleAddressLabel.backgroundColor =[UIColor whiteColor];
        [self.bigAddressView addSubview:titleAddressLabel];
        titleAddressLabel.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGetAddress)];
        [titleAddressLabel addGestureRecognizer:tap];
        
        _titleAddressLabel =titleAddressLabel;
    }
    return _titleAddressLabel;
}

//地址箭头
-(UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        UIImageView *arrowImageView =[[UIImageView alloc] init];
        arrowImageView.image =[UIImage imageNamed:@"RightArrow"];
        [self.bigAddressView addSubview:arrowImageView];
        arrowImageView.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGetAddress)];
        [arrowImageView addGestureRecognizer:tap];
        
        _arrowImageView =arrowImageView;
    }

    return _arrowImageView;
}

//实线
-(UILabel *)lineLabel
{
    if (!_lineLabel) {
        UILabel *lineLabel =[[UILabel alloc] init];
        lineLabel.backgroundColor =[UIColor lightGrayColor];
        [self.bigAddressView addSubview:lineLabel];
        _lineLabel =lineLabel;
    }
    return _lineLabel;
}
//详细地址
-(UITextField *)detailAddressTextField
{
    if (!_detailAddressTextField) {
        UITextField *detailAddressTextField =[[UITextField alloc] init];
        detailAddressTextField.text =@"高碑店";
        detailAddressTextField.font =[UIFont systemFontOfSize:15];
        [self.bigAddressView addSubview:detailAddressTextField];
        detailAddressTextField.backgroundColor =[UIColor whiteColor];
        _detailAddressTextField =detailAddressTextField;
        
    }
    return _detailAddressTextField;
}

//确定按钮
-(UIButton *)makeSureButton
{
    if (!_makeSureButton) {
        UIButton *makeSureButton =[[UIButton alloc] init];
        [makeSureButton setTitle:@"确定" forState:UIControlStateNormal];
        makeSureButton.titleLabel.font =[UIFont systemFontOfSize:16];
        makeSureButton.layer.masksToBounds =YES;
        makeSureButton.layer.cornerRadius =5.0;
        makeSureButton.backgroundColor =[UIColor colorWithRed:0/255.0 green:217/255.0 blue:106/255.0 alpha:1.0];
        [self addSubview:makeSureButton];
        _makeSureButton =makeSureButton;
        [makeSureButton addTarget:self action:@selector(clickmakeSure) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _makeSureButton;
}






@end




