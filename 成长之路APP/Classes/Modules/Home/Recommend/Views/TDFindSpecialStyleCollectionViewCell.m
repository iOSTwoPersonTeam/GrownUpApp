//
//  TDFindSpecialStyleCollectionViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDFindSpecialStyleCollectionViewCell.h"

@interface TDFindSpecialStyleCollectionViewCell ()

@property(nonatomic, weak)UIView *titleAndMoreView;
@property(nonatomic, weak)UILabel *titileLabel; //标题
@property(nonatomic,weak)TDSubFindSpecialStyleTableView *tableView;

@end

@implementation TDFindSpecialStyleCollectionViewCell

-(void)setModel:(XMLYSpecialColumnModel *)model
{
    _model =model;
    self.titileLabel.text =_model.title;
    self.tableView.model =_model;
    [self.tableView reloadData];
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.titleAndMoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(self.contentView.mas_right).offset(0);;
        make.height.equalTo(@40);
    }];
    [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleAndMoreView.mas_bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@180);
    }];

}

#pragma mark --getter--
-(UIView *)titleAndMoreView
{
    if (!_titleAndMoreView) {
        UIView *titleAndMoreView =[[UIView alloc] init];
        titleAndMoreView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:titleAndMoreView];
        _titleAndMoreView =titleAndMoreView;
        
        UIButton *moreButton =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 15, 50, 15)];
        [moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        moreButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [moreButton setImage:[UIImage imageNamed:@"右箭头"] forState:UIControlStateNormal];
        [moreButton setImagePosition:ImageAndTitlePositionRight WithImageAndTitleSpacing:0];
        [titleAndMoreView addSubview:moreButton];
    }
    return _titleAndMoreView;
}

-(UILabel *)titileLabel
{
    if (!_titileLabel) {
        UILabel *titileLabel =[[UILabel alloc] init];
        titileLabel.backgroundColor =[UIColor clearColor];
        titileLabel.text =@"小编推荐";
        titileLabel.font =[UIFont systemFontOfSize:15];
        [self.titleAndMoreView addSubview:titileLabel];
        _titileLabel =titileLabel;
    }
    return _titileLabel;
}

-(TDSubFindSpecialStyleTableView *)tableView
{
    if (!_tableView) {
        TDSubFindSpecialStyleTableView *tableView =[[TDSubFindSpecialStyleTableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 180) style:UITableViewStylePlain];
        tableView.backgroundColor =[UIColor purpleColor];
        [self.contentView addSubview:tableView];
        _tableView =tableView;
    }
    return _tableView;
}


@end
