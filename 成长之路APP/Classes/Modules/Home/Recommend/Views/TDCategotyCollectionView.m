//
//  TDCategotyCollectionView.m
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDCategotyCollectionView.h"

@interface TDCategotyCollectionCell ()

@property(nonatomic, strong)UIImageView *topImageView;
@property(nonatomic, strong)UILabel *bottomLabel;
@property(nonatomic, copy)XMLYFindDiscoverDetailModel *model;

@end

@implementation TDCategotyCollectionCell

-(void)setModel:(XMLYFindDiscoverDetailModel *)model
{
    _model =model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverPath] placeholderImage:[UIImage imageNamed:@""]];
    self.bottomLabel.text =_model.title;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@45);
        make.height.equalTo(@45);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
}

#pragma mark --getter--
-(UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView =[[UIImageView alloc] init];
        _topImageView.backgroundColor =[UIColor clearColor];
        _topImageView.layer.masksToBounds =YES;
        _topImageView.layer.cornerRadius =22.5;
        [self.contentView addSubview:_topImageView];
    }
    return _topImageView;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel =[[UILabel alloc] init];
        _bottomLabel.backgroundColor =[UIColor clearColor];
        _bottomLabel.textAlignment =NSTextAlignmentCenter;
        _bottomLabel.font =[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_bottomLabel];
    }
    return _bottomLabel;
}

@end



@interface TDCategotyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation TDCategotyCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self =[super initWithFrame:frame collectionViewLayout:layout]) {

        [self setCollectionView];
    }
    return self;
}

-(void)setCollectionView
{
    self.dataSource =self;
    self.delegate =self;
    [self registerClass:[TDCategotyCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark -----Delagate&DateSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.discoverModel.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDCategotyCollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    cell.model =self.discoverModel.list[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5,5);
}







@end
