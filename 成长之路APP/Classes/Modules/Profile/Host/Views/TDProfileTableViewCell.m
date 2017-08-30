//
//  TDProfileTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/7.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDProfileTableViewCell.h"

@interface TDProfileTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel; //描述文字
@property(nonatomic,strong)UIImageView *iconView; //图标
@property(nonatomic,strong)UILabel *descLabel; //内容

@end


@implementation TDProfileTableViewCell


-(void)setTitle:(NSString *)title withImageShow:(NSString *)icon
{

    [self.titleLabel setText:title];
    [self.iconView setImage:[UIImage imageNamed:icon]];
    if ([title isEqualToString:@"店铺关注"]) {
        
         [self.descLabel setText:@"1"];
    }
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

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(self.iconView.mas_right).offset(12);
        make.width.equalTo(@150);
        make.height.equalTo(@16);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@150);
        make.height.equalTo(@16);
    }];


    [super updateConstraints];
}

-(void)prepareForReuse
{
   _titleLabel.text =@"";
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

-(UILabel *)titleLabel
{
    if (_titleLabel ==nil) {
        
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.backgroundColor =[UIColor whiteColor];
        _titleLabel.font =[UIFont systemFontOfSize:16];
        _titleLabel.textColor =[UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }

    return _titleLabel;
}

-(UILabel *)descLabel
{
    if (_descLabel ==nil) {
        
        _descLabel =[[UILabel alloc] init];
        _descLabel.backgroundColor =[UIColor whiteColor];
        _descLabel.font =[UIFont systemFontOfSize:14];
        _descLabel.textColor =[UIColor lightGrayColor];
        _descLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_descLabel];
    }
    
    return _descLabel;
}







@end





