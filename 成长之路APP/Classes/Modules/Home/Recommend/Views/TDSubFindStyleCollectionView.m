//
//  TDSubFindStyleCollectionView.m
//  成长之路APP
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSubFindStyleCollectionView.h"

@interface TDSubContentCollectionViewCell ()

@property(nonatomic, strong)UIImageView *titileImageView; //标题图片
@property(nonatomic, strong)UILabel *titleLabel; //标题
@property(nonatomic, strong)UILabel *detailLabel; //详情
@property(nonatomic, strong)XMLYFindEditorRecommendDetailModel *model;

@end

@implementation TDSubContentCollectionViewCell

-(void)setModel:(XMLYFindEditorRecommendDetailModel *)model
{
    _model =model;
    [self.titileImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverMiddle] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text =_model.intro;
    self.detailLabel.text =_model.title;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.titileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@105);
        make.height.equalTo(@100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titileImageView.mas_bottom).offset(3);
        make.left.equalTo(@0);
        make.right.equalTo(self.titileImageView.mas_right);
        make.height.equalTo(@40);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.left.equalTo(@0);
        make.right.equalTo(self.titleLabel.mas_right);
        make.height.equalTo(@15);
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
        _detailLabel.backgroundColor =[UIColor clearColor];
        _detailLabel.textAlignment =NSTextAlignmentCenter;
        _detailLabel.textColor =[UIColor grayColor];
        _detailLabel.font =[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

@end


@interface TDSubFindStyleCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation TDSubFindStyleCollectionView

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
    [self registerClass:[TDSubContentCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark -----Delagate&DateSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _model.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDSubContentCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    cell.model =_model.list[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 160);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 5, 20);
}



@end
