//
//  TDSubFindSpecialStyleTableView.h
//  成长之路APP
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDHomeRecommendModel.h"
#import "TDHomeFindHotGuessModel.h"

@interface TDsubFindSpecialStyleTableViewCell : UITableViewCell

@property(nonatomic, strong)XMLYSpecialColumnDetailModel *model;

@end

@interface TDSubFindSpecialStyleTableView : UITableView

@property(nonatomic,strong)XMLYSpecialColumnModel *model;

@end
