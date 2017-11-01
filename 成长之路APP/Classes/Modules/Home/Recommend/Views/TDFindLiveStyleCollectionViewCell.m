//
//  TDFindLiveStyleCollectionViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDFindLiveStyleCollectionViewCell.h"

@interface TDFindLiveStyleCollectionViewCell ()<SDCycleScrollViewDelegate>

@property(nonatomic, weak)UIView *titleAndMoreView;
@property(nonatomic, weak)UILabel *titileLabel; //标题
@property(nonatomic, strong)SDCycleScrollView *contentTitileImageView; //轮播图片
@property(nonatomic, strong)UILabel *contentTitleLabel; //标题
@property(nonatomic, strong)UILabel *contentDetailLabel; //详情
@property(nonatomic,strong)NSMutableArray *imageArray; //轮播图数组

@end

@implementation TDFindLiveStyleCollectionViewCell

-(void)setModel:(TDHomeFindLiveModel *)model
{
    _model =model;
    self.titileLabel.text =@"现场直播";
    [self.imageArray removeAllObjects];
    [_model.data enumerateObjectsUsingBlock:^(TDHomeFindLiveDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@---",obj.coverPath);
        [self.imageArray addObject:obj.coverPath];
    }];
    self.contentTitileImageView.imageURLStringsGroup =self.imageArray;

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
    
    [self.contentTitileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleAndMoreView.mas_bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@100);
    }];
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTitileImageView.mas_bottom).offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.contentDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTitleLabel.mas_bottom).offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
}

#pragma mark --delegate-
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    TDHomeFindLiveDetailModel *detailModel =_model.data[index];
    self.contentTitleLabel.text =detailModel.name;
    self.contentDetailLabel.text =detailModel.shortDescription;
}


#pragma mark --getter--
-(UIView *)titleAndMoreView
{
    if (!_titleAndMoreView) {
        UIView *titleAndMoreView =[[UIView alloc] init];
        titleAndMoreView.backgroundColor =[UIColor clearColor];
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

-(SDCycleScrollView *)contentTitileImageView
{
    if (!_contentTitileImageView) {
        _contentTitileImageView =[[SDCycleScrollView alloc] init];
        _contentTitileImageView.delegate =self;
        _contentTitileImageView.infiniteLoop =YES;
        _contentTitileImageView.showPageControl =NO;
        _contentTitileImageView.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:_contentTitileImageView];
    }
    return _contentTitileImageView;
}

-(UILabel *)contentTitleLabel
{
    if (!_contentTitleLabel) {
        _contentTitleLabel =[[UILabel alloc] init];
        _contentTitleLabel.backgroundColor =[UIColor clearColor];
        _contentTitleLabel.textAlignment =NSTextAlignmentLeft;
        _contentTitleLabel.font =[UIFont systemFontOfSize:13];
        _contentTitleLabel.numberOfLines =0;
        [self.contentView addSubview:_contentTitleLabel];
    }
    return _contentTitleLabel;
}

-(UILabel *)contentDetailLabel
{
    if (!_contentDetailLabel) {
        _contentDetailLabel =[[UILabel alloc] init];
        _contentDetailLabel.backgroundColor =[UIColor clearColor];
        _contentDetailLabel.textAlignment =NSTextAlignmentLeft;
        _contentDetailLabel.textColor =[UIColor grayColor];
        _contentDetailLabel.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_contentDetailLabel];
    }
    return _contentDetailLabel;
}

-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}

@end
