//
//  TDRootTableViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewController.h"
#import "TDRootModel.h"
#import "TDRootTableViewCell.h"

@interface TDRootTableViewController ()

@end

@implementation TDRootTableViewController

-(instancetype)init
{
    if (self =[super init]) {
        _refreshEnabled =NO;
        _emptyDataEnabled =NO;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     *  tableView适配ios11方法
     */
#warning mark ---ios11适配 tableView适配----
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView =[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor =GlobalBackgroundColor;
    _tableView.scrollEnabled =YES;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.showsHorizontalScrollIndicator =NO;
    
    //消除多余隐藏和顶部留白
    _tableView.tableFooterView =[UIView new];
    _tableView.tableHeaderView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
    
    //注册cell类型   同时保证定义的cellID不相同
    [_tableView registerClass:[self tableCellClass] forCellReuseIdentifier:NSStringFromClass([self tableCellClass])];
    
    //显示空数据
    if (_emptyDataEnabled) {
        
        _tableView.emptyDataSetSource =self;
        _tableView.emptyDataSetDelegate =self;
    }
    
    //显示下拉刷新
    if (_refreshEnabled) {
        
        _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self.loadModel loadMore:NO];
        }];
    }
    
}


#pragma mark ---UITableViewDataSource,UITableViewDelagate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //主要是看数组内是否包含数组,如果包含可能就是两级数据格式 这是分区就会增多
    if (self.loadModel.allItems.count && [[self.loadModel.allItems lastObject] isKindOfClass:[NSArray class]]) {
        
        return self.loadModel.allItems.count;
    }
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.loadModel.allItems.count &&[[self.loadModel.allItems objectAtIndex:section] isKindOfClass:[NSArray class]]) {
        
        return [[self.loadModel.allItems objectAtIndex:section] count];
    }
    
    return self.loadModel.allItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDRootTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self tableCellClass]) forIndexPath:indexPath];
    [cell setObject:[self.loadModel.allItems objectAtIndex:indexPath.row]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header =[[UIView alloc] init];
    header.backgroundColor =[UIColor lightGrayColor];
    
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer =[[UIView alloc] init];
    footer.backgroundColor =[UIColor grayColor];
    
    return footer;
}

//cell自定义类型,也是注册类型,用于定义自己的cell样式----
- (Class)tableCellClass
{
    // overriden by subclass
    return [TDRootTableViewCell class];
}


#pragma mark ----TDModelDelegate Model基类代理方法

- (void)modelDidFinishLoad
{
    [super modelDidFinishLoad];
    
    //停止下拉刷新
    if (_refreshEnabled && self.loadModel.refreshing) {
        
        self.loadModel.refreshing = NO;
        [_tableView.mj_header endRefreshing];
    }
    
    //停止上拉刷新
    if (self.loadModel.loadingMore) {
        self.loadModel.loadingMore = NO;
        
        if (self.loadModel.hasMore) {
            [self.tableView.mj_footer endRefreshing];
        }
        else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData]; //展示已经没有新数据
        }
    }
    else if (self.loadModel.hasMore) {
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^(){
            [self.loadModel loadMore:YES];
        }];
    }
    
    //显示数据
    [self.tableView reloadData];
    [self.tableView reloadEmptyDataSet];
}


#pragma mark -----DZNEmptyDataSet 空数据显示

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:@"暂时没有内容"];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"img"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
}




@end






