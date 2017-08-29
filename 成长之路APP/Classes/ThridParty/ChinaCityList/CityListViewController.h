//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//
#import "CityItem.h"

@protocol CityListViewDelegate <NSObject>

- (void)didClickedWithCity:(CityItem*)cityItem;

@end


@interface CityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) id<CityListViewDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *arrayLocatingCity;//定位城市数据
@property (strong, nonatomic) NSMutableArray *arrayHotCity;//热门城市数据
@property (strong, nonatomic) NSMutableArray *arrayHistoricalCity;//当前城市数据

@property(nonatomic,strong) UITableView *tableView;

@end
