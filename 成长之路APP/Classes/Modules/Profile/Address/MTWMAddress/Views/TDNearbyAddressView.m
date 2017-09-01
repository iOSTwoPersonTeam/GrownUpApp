//
//  TDNearbyAddressView.m
//  成长之路APP
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDNearbyAddressView.h"
#import "TDNearbyTableViewCell.h"

@interface TDNearbyAddressView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,weak)UITableView *tableview;
@property(nonatomic ,strong)NSArray<BMKPoiInfo *> *dataArray;


@end

@implementation TDNearbyAddressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{

    [self tableview]; //列表添加
}

#pragma mark ---布局
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame =self.bounds;
    frame.size.height -=60;
    _tableview.frame =frame;
}

#pragma mark --public--
-(void)getDataWithArray:(NSArray<BMKPoiInfo *> *)dataArray
{
    self.dataArray =dataArray;
    BMKPoiInfo *info =dataArray[1];
    NSLog(@"%@-----",info.name);
    
    [self.tableview reloadData];
}



#pragma mark --delagate--
#pragma mark ---tabeleViewDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    TDNearbyTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[TDNearbyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType =UITableViewCellAccessoryNone;
    }

    BMKPoiInfo *info =self.dataArray[indexPath.row];
    [cell getDataWithModel:info];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo *info =self.dataArray[indexPath.row];
    if (self.selectIndexPathBlock) {
        self.selectIndexPathBlock(info.name);
    }
    
}







#pragma mark ---getter--

-(UITableView *)tableview
{
    if (_tableview ==nil) {

       UITableView *tableview =[[UITableView alloc] init];
#warning 注意在tableView中必须进行代理的相关设置 不然不能正常显示--------
        tableview.delegate =self;
        tableview.dataSource =self;
//        tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableview.showsVerticalScrollIndicator=NO;
        [self addSubview:tableview];
        _tableview =tableview;
    }
    return _tableview;
}









@end





