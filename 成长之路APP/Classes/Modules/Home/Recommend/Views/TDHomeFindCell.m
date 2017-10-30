//
//  TDHomeFindCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeFindCell.h"

@interface TDHomeFindCell ()

@property(nonatomic, strong)UILabel *titleLabel;


@end

@implementation TDHomeFindCell

-(void)setRecommendModel:(XMLYFindEditorRecommendAlbumModel *)recommendModel
{
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)setCityColumn:(XMLYCityColumnModel *)cityColumn
{
    
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)setHotRecommedItemModel:(XMLYHotRecommendItemModel *)hotRecommedItemModel
{
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}





@end
