//
//  TDCategotyCollectionView.h
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHomeRecommendModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDCategotyCollectionCell : UICollectionViewCell

@end

@interface TDCategotyCollectionView : UICollectionView

@property (nonatomic, strong) XMLYFindDiscoverColumnsModel *discoverModel;

@end
