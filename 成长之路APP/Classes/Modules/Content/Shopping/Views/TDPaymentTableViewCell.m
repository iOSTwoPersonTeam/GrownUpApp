//
//  TDPaymentTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPaymentTableViewCell.h"

@interface TDPaymentTableViewCell ()

@property(nonatomic, strong)UIImageView *markIconImageView; //图标
@property(nonatomic, strong)UILabel *titleLabel; //标题

@end

@implementation TDPaymentTableViewCell

- (void)setTitle:(nonnull NSString*)title
   withImageShow:(nonnull NSString*)icon
{

    self.markIconImageView.image =[UIImage imageNamed:icon];
    self.titleLabel.text =title;
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

#pragma mark --Private---
-(void)updateConstraints
{
    [super updateConstraints];
    self.markIconImageView.frame =CGRectMake(20, 20, 20, 20);
    self.titleLabel.frame =CGRectMake(CGRectGetMaxX(self.markIconImageView.frame) +10, CGRectGetMinY(self.markIconImageView.frame), SCREEN_WIDTH/2, 20);
    self.selectImageView.frame =CGRectMake(SCREEN_WIDTH -50, CGRectGetMinY(self.markIconImageView.frame), 25, 25);
}

#pragma mark ---Delegate---




#pragma mark ---getter---
-(UIImageView *)markIconImageView
{
    if (!_markIconImageView) {
        _markIconImageView =[[UIImageView alloc] init];
        [self.contentView addSubview:_markIconImageView];
    }
    return _markIconImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIImageView *)selectImageView
{
    if (!_selectImageView) {
        _selectImageView =[[UIImageView alloc] init];
        [_selectImageView setHighlightedImage:[UIImage imageNamed:@"同意条款"]];
        [_selectImageView setImage:[UIImage imageNamed:@"未选中"]];
        _selectImageView.userInteractionEnabled =YES;
        [self.contentView addSubview:_selectImageView];
    }
    return _selectImageView;
}






@end



