//
//  TDFindSpecialStyleCollectionViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDFindSpecialStyleCollectionViewCell.h"
@interface TDFindSpecialStyleCollectionViewCell ()

@property(nonatomic, strong)UIImageView *titileImageView; //标题图片
@property(nonatomic, strong)UILabel *titleLabel; //标题
@property(nonatomic, strong)UILabel *detailLabel; //详情

@end

@implementation TDFindSpecialStyleCollectionViewCell

-(void)setModel:(NSDictionary *)model
{
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titileImageView.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
}

#pragma mark --getter--
-(UIImageView *)titileImageView
{
    if (!_titileImageView) {
        _titileImageView =[[UIImageView alloc] init];
        _titileImageView.backgroundColor =[UIColor redColor];
        [self.contentView addSubview:_titileImageView];
    }
    return _titileImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.backgroundColor =[UIColor yellowColor];
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        _titleLabel.font =[UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines =0;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel =[[UILabel alloc] init];
        _detailLabel.backgroundColor =[UIColor grayColor];
        _detailLabel.textAlignment =NSTextAlignmentCenter;
        _detailLabel.textColor =[UIColor grayColor];
        _detailLabel.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}



@end
