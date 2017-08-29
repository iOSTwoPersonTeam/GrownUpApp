//
//  TDSettingsTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSettingsTableViewCell.h"

@interface TDSettingsTableViewCell ()

@property(nonatomic,strong)UILabel *descLabel; //描述文字

@end

@implementation TDSettingsTableViewCell


-(void)setTitle:(NSString *)title
{
    
    [self.descLabel setText:title];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints
{
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.equalTo(@150);
        make.height.equalTo(@16);
    }];
    
    [super updateConstraints];
}

-(void)prepareForReuse
{
    _descLabel.text =@"";
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
