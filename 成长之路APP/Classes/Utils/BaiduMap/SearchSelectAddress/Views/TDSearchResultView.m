//
//  TDSearchResultView.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDSearchResultView.h"
#import "TDNearbyAddressTableViewCell.h"

@interface TDSearchResultView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray<BMKPoiInfo *> *suggestionSearchArr;

@end


@implementation TDSearchResultView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]){
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    self.tableview.frame =self.frame;
}

-(void)getDataWithInfo:(NSMutableArray<BMKPoiInfo *> *)suggestionSearchArr
{
    _suggestionSearchArr =suggestionSearchArr;
    
    [self.tableview reloadData];

}



#pragma mark --delagate---
#pragma mark --tableViewDelagate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _suggestionSearchArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    TDNearbyAddressTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[TDNearbyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    
//    BMKPoiInfo *dic =_suggestionSearchArr[indexPath];
    [cell getDataWithTitleAddress: _suggestionSearchArr[indexPath.row].name WithDetailAddress: _suggestionSearchArr[indexPath.row].address];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.resultIndexPathBlock) {
        self.resultIndexPathBlock(_suggestionSearchArr[indexPath.row]);
    }
}


#pragma mark ---getter---
-(UITableView *)tableview
{
    if (_tableview ==nil) {
        
        _tableview =[[UITableView alloc] init];
#warning 注意在tableView中必须进行代理的相关设置 不然不能正常显示--------
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//        _tableview.showsVerticalScrollIndicator=NO;
        [self addSubview:_tableview];
        
    }
    return _tableview;
}

@end




