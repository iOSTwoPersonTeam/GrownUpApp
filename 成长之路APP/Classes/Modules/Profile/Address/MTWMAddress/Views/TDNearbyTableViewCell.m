//
//  TDNearbyTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDNearbyTableViewCell.h"

@interface TDNearbyTableViewCell ()

@property(nonatomic,strong)UILabel *addressLabel; //地址
@property(nonatomic,strong)UILabel *detailAddressLabel; //详细地址

@end

@implementation TDNearbyTableViewCell

-(void)getDataWithModel:(BMKPoiInfo *)info
{

    self.addressLabel.text =info.name;
    self.detailAddressLabel.text =info.address;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark --布局
-(void)updateConstraints
{
    [super updateConstraints];

    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@5);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@20);
    }];
    
    [self.detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_left);
        make.top.equalTo(self.addressLabel.mas_bottom);
        make.width.equalTo(self.addressLabel.mas_width);
        make.height.equalTo(self.addressLabel.mas_height);
    }];
    
    
}


#pragma mark ---getter--
//地址
-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel =[[UILabel alloc] init];
        _addressLabel.font =[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_addressLabel];
    }
    return _addressLabel;
}
//详细地址
-(UILabel *)detailAddressLabel
{
    if (!_detailAddressLabel) {
        _detailAddressLabel =[[UILabel alloc] init];
        _detailAddressLabel.font =[UIFont systemFontOfSize:14];
        _detailAddressLabel.textColor =[UIColor lightGrayColor];
        [self.contentView addSubview:_detailAddressLabel];
    }
    return _detailAddressLabel;
}


@end
