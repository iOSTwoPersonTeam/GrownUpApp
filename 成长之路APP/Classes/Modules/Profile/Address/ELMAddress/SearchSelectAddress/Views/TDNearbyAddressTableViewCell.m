//
//  TDNearbyAddressTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDNearbyAddressTableViewCell.h"

@interface TDNearbyAddressTableViewCell ()

@property(nonatomic,strong)UILabel *markLabel; //标识

@property(nonatomic,strong)UILabel *titleAddressLabel; //主地址

@property(nonatomic,strong)UILabel *detailAddressLabel; //详细地址

@end

@implementation TDNearbyAddressTableViewCell

-(void)getDataWithTitleAddress:(NSString *)titleAddress WithDetailAddress:(NSString *)datailAddress
{

    self.titleAddressLabel.text =titleAddress;
    self.detailAddressLabel.text =datailAddress;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}


-(void)prepareForReuse
{
    
    self.titleAddressLabel.text =nil;
    self.detailAddressLabel.text =nil;

}


-(void)updateConstraints
{
    [super updateConstraints];
   [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.contentView.mas_left).offset(10);
       make.centerY.equalTo(self.contentView.mas_centerY);
       make.width.equalTo(@10);
       make.height.equalTo(@10);
   }];
    
    [self.titleAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.markLabel.mas_right).offset(5);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@(SCREEN_WIDTH-40));
    }];
    
    [self.detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleAddressLabel.mas_left).offset(0);
        make.top.equalTo(self.titleAddressLabel.mas_bottom).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(self.titleAddressLabel.mas_width);
    }];
}

#pragma mark ---getter--

-(UILabel *)markLabel
{
    if (!_markLabel) {
        
        _markLabel =[[UILabel alloc] init];
        _markLabel.backgroundColor =[UIColor lightGrayColor];
        _markLabel.layer.masksToBounds =YES;
        _markLabel.layer.cornerRadius =5.0;
        [self.contentView addSubview:_markLabel];
    }
    return _markLabel;
}

-(UILabel *)titleAddressLabel
{
    if (!_titleAddressLabel) {
        
        _titleAddressLabel =[[UILabel alloc] init];
        _titleAddressLabel.font =[UIFont systemFontOfSize:16 weight:0.4];
        [self.contentView addSubview:_titleAddressLabel];
//        _titleAddressLabel.backgroundColor =[UIColor purpleColor];
    }
    return _titleAddressLabel;
}

-(UILabel *)detailAddressLabel
{
    if (!_detailAddressLabel) {
        
        _detailAddressLabel =[[UILabel alloc] init];
        _detailAddressLabel.font =[UIFont systemFontOfSize:14];
        _detailAddressLabel.textColor =[UIColor lightGrayColor];
        [self.contentView addSubview:_detailAddressLabel];
//        _detailAddressLabel.backgroundColor =[UIColor yellowColor];
    }
    return _detailAddressLabel;
}



@end




