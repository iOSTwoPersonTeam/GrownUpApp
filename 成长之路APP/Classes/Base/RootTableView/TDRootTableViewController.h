//
//  TDRootTableViewController.h
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDModelViewController.h"

@interface TDRootTableViewController : TDModelViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong,readonly)UITableView *tableView;

@property(nonatomic,assign)BOOL refreshEnabled; //是否允许刷新,默认为NO
@property(nonatomic,assign)BOOL emptyDataEnabled; //是否显示空数据展示,默认为NO

-(Class)tableCellClass; //子类决定显示样式



@end
