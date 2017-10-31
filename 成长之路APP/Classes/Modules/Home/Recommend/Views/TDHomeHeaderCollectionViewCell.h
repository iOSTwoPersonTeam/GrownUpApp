//
//  TDHomeHeaderCollectionViewCell.h
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHomeRecommendModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDHomeHeaderCollectionViewCell : UICollectionViewCell

/*
 *  轮播图
 */
@property(nonatomic, strong)XMLYFindFocusImagesModel *model;


/*
 * 下方轮播图模型
 */
@property(nonatomic, strong)XMLYFindDiscoverColumnsModel *discoverModel;

@end
