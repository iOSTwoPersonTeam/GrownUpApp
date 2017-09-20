//
//  TDPaymentHeaderView.m
//  成长之路APP
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPaymentHeaderView.h"

@interface TDPaymentHeaderView ()

@property(nonatomic, strong)UIImageView *paymentADImageView; //支付页广告
@property(nonatomic, strong)UILabel *lineLanel; //分割线
@property(nonatomic, strong)UILabel *titlelabel; //标题
@property(nonatomic, strong)UILabel *moneyLabel; //金额

@end

@implementation TDPaymentHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.paymentADImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT/6));
    }];
    
    [self.lineLanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.paymentADImageView.mas_bottom).offset(80);
        make.width.equalTo(@(SCREEN_WIDTH-10));
        make.height.equalTo(@1);
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.lineLanel.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH/3 *2));
        make.height.equalTo(@20);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.titlelabel.mas_top);
        make.height.equalTo(self.titlelabel.mas_height);
        make.left.equalTo(self.titlelabel.mas_right).offset(20);
    }];
    
    
}


#pragma mark ---Private--


#pragma mark --Delagate---



#pragma mark ---getter--
-(UIImageView *)paymentADImageView
{
    if (!_paymentADImageView) {
        _paymentADImageView =[[UIImageView alloc] init];
        [_paymentADImageView setImage:[UIImage imageNamed:@"支付页面广告"]];
        _paymentADImageView.backgroundColor =[UIColor orangeColor];
        [self addSubview:_paymentADImageView];
    }
    return _paymentADImageView;
}

-(UILabel *)lineLanel
{
    if (!_lineLanel) {
        _lineLanel =[[UILabel alloc] init];
        _lineLanel.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLanel];
    }
    return _lineLanel;
}

-(UILabel *)titlelabel
{
    if (!_titlelabel) {
        _titlelabel =[[UILabel alloc] init];
        [self addSubview:_titlelabel];
        _titlelabel.text =@"西街小厨粥餐厅";
    }
    return _titlelabel;
}
-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc] init];
        _moneyLabel.text =@"¥ 0.01";
        _moneyLabel.textColor =[UIColor redColor];
        _moneyLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:_moneyLabel];
    }
    return _moneyLabel;
}







@end


