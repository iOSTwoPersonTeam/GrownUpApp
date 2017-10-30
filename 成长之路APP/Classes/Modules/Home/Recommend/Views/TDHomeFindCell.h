//
//  TDHomeFindCell.h
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewCell.h"
#import "TDHomeRecommendModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDHomeFindCell : TDRootTableViewCell

/**
 *  小编推荐模型
 */
@property (nonatomic, strong) XMLYFindEditorRecommendAlbumModel *recommendModel;

/**
 *  城市
 */
@property (nonatomic, strong) XMLYCityColumnModel               *cityColumn;

/**
 *  热门推荐
 */
@property (nonatomic, strong) XMLYHotRecommendItemModel         *hotRecommedItemModel;


@end
