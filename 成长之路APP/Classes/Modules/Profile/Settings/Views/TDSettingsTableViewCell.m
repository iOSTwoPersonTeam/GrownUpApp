//
//  TDSettingsTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSettingsTableViewCell.h"

@interface TDSettingsTableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel; //描述文字
@property(nonatomic,strong)UILabel *detailLabel; //详情文字

@end

@implementation TDSettingsTableViewCell


- (void)getDataWithTitle:(nonnull NSString*)title WithDetailText:(NSString *_Nullable)detailText WithIndexPath:(NSInteger )index
{
    if (index ==0) {
        self.accessoryType =UITableViewCellAccessoryNone;
        self.detailLabel.text =detailText;
        self.detailLabel.hidden =NO;
    }
    else{
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        self.detailLabel.hidden =YES;
    }
    [self.titleLabel setText:title];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.equalTo(@150);
        make.height.equalTo(@16);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@80);
        make.height.equalTo(@16);
    }];
    
    [super updateConstraints];
}

-(void)prepareForReuse
{
    _titleLabel.text =@"";
    _detailLabel.text =@"";
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

-(UILabel *)detailLabel
{
    if (_detailLabel ==nil) {
        
        _detailLabel =[[UILabel alloc] init];
        _detailLabel.backgroundColor =[UIColor whiteColor];
        _detailLabel.font =[UIFont systemFontOfSize:14];
        _detailLabel.textColor =[UIColor redColor];
        _detailLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}


@end
