//
//  TDNearbyAddressViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDNearbyAddressViewController.h"
#import "TDRootModel.h"
#import "TDRootTableViewCell.h"
#import "TDNearbyAddressTableViewCell.h"
#import "BaiduMapManager.h"

@interface TDNearbyAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TDNearbyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emptyDataEnabled = YES;
    self.refreshEnabled = YES;
    
    CGRect frame =self.view.frame;
    frame.size.height -=44+40;
    self.tableView.frame =frame;

    self.dataArray =[NSMutableArray array];
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index
{
    NSArray *keywordArray =@[@"公司",@"写字楼",@"小区",@"学校"];
    [[BaiduMapManager shareLocationManager] getNearbyResultWithLocation:_location withSearchKeyword:keywordArray[index] resultSucceed:^(BMKPoiResult *nearbyResult) {
        
        self.dataArray =[NSMutableArray arrayWithArray:nearbyResult.poiInfoList];
        [self.tableView reloadData];
        
    } errorCode:^(BMKSearchErrorCode error) {
        
    }];

}

-(Class)tableCellClass
{
    
    return  [TDNearbyAddressTableViewCell class];
}


#pragma mark --UITableViewDataSource, UITableViewDelagate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDNearbyAddressTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self tableCellClass]) forIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryNone;
    
    BMKPoiInfo *info =self.dataArray[indexPath.row];
    [cell getDataWithTitleAddress:info.name WithDetailAddress:info.address];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


#pragma mark -----DZNEmptyDataSet

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:@"该分类下还没有可用的服务哦!\n快去联系客服吧" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16] ,NSForegroundColorAttributeName : [UIColor grayColor]}];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"img"];
}










@end
