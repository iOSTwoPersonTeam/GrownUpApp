//
//  TDProfileTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/7.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDProfileTableViewCell.h"

@interface TDProfileTableViewCell ()

@property(nonatomic,strong)UILabel *descLabel; //描述文字
@property(nonatomic,strong)UIImageView *iconView; //图标

@end


@implementation TDProfileTableViewCell


-(void)setTitle:(NSString *)title withImageShow:(NSString *)icon
{

    [self.descLabel setText:title];
    [self.iconView setImage:[UIImage imageNamed:icon]];
   
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@15);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(self.iconView.mas_right).offset(12);
        make.width.equalTo(@150);
        make.height.equalTo(@16);
    }];

    [super updateConstraints];
}

-(void)prepareForReuse
{
   _descLabel.text =@"";
    _iconView.image =nil;
}

-(UIImageView *)iconView
{
    if (_iconView ==nil) {
        
        _iconView =[[UIImageView alloc] init];
        _iconView.backgroundColor =[UIColor  whiteColor];
        _iconView.contentMode =UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    }

    return _iconView;
}

-(UILabel *)descLabel
{
    if (_descLabel ==nil) {
        
        _descLabel =[[UILabel alloc] init];
        _descLabel.backgroundColor =[UIColor whiteColor];
        _descLabel.font =[UIFont systemFontOfSize:16];
        _descLabel.textColor =[UIColor blackColor];
        [self.contentView addSubview:_descLabel];
    }

    return _descLabel;
}








@end





