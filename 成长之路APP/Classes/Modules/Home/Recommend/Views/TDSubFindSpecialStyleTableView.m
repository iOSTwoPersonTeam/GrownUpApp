//
//  TDSubFindSpecialStyleTableView.m
//  成长之路APP
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSubFindSpecialStyleTableView.h"

@interface TDsubFindSpecialStyleTableViewCell ()

@property(nonatomic, strong)UIImageView *titileImageView; //标题图片
@property(nonatomic, strong)UILabel *titleLabel; //标题
@property(nonatomic, strong)UILabel *detailLabel; //详情
@property(nonatomic, strong)UILabel *numberLabel; //歌曲数量

@end

@implementation TDsubFindSpecialStyleTableViewCell

-(void)setModel:(XMLYSpecialColumnDetailModel *)model
{
    _model =model;
    [self.titileImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverPath] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text =_model.title;
    self.detailLabel.text =_model.subtitle;
    self.numberLabel.text =_model.footnote;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@10);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titileImageView.mas_top).offset(0);
        make.left.equalTo(self.titileImageView.mas_right).offset(6);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(6);
        make.left.equalTo(self.detailLabel.mas_left);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
}

#pragma mark --getter--
-(UIImageView *)titileImageView
{
    if (!_titileImageView) {
        _titileImageView =[[UIImageView alloc] init];
        _titileImageView.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_titileImageView];
    }
    return _titileImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc] init];
        _titleLabel.backgroundColor =[UIColor clearColor];
        _titleLabel.textAlignment =NSTextAlignmentLeft;
        _titleLabel.font =[UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines =0;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel =[[UILabel alloc] init];
        _detailLabel.backgroundColor =[UIColor clearColor];
        _detailLabel.textAlignment =NSTextAlignmentLeft;
        _detailLabel.textColor =[UIColor grayColor];
        _detailLabel.font =[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel =[[UILabel alloc] init];
        _numberLabel.backgroundColor =[UIColor clearColor];
        _numberLabel.textAlignment =NSTextAlignmentLeft;
        _numberLabel.textColor =[UIColor grayColor];
        _numberLabel.font =[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
}

@end

@interface TDSubFindSpecialStyleTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TDSubFindSpecialStyleTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self =[super initWithFrame:frame style:style]) {
        [self setTableView];
    }
    return self;
}

-(void)setTableView
{
    self.delegate =self;
    self.dataSource =self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDsubFindSpecialStyleTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[TDsubFindSpecialStyleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model =self.model.list[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}




@end
