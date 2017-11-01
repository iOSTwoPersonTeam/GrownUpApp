//
//  TDSubFindStyleCollectionView.h
//  成长之路APP
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDHomeRecommendModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDSubContentCollectionViewCell : UICollectionViewCell

@end

@interface TDSubFindStyleCollectionView : UICollectionView

@property(nonatomic, strong)XMLYFindEditorRecommendAlbumModel *model;

@end
