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

@interface TDNearbyAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableview;

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

}


-(Class)tableCellClass
{
    
    return  [TDNearbyAddressTableViewCell class];
}


#pragma mark --UITableViewDataSource, UITableViewDelagate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDNearbyAddressTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self tableCellClass]) forIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryNone;
    
    [cell getDataWithTitleAddress:@"北花闸北里社区" WithDetailAddress:@"北京市朝阳区朝阳区定福庄西街北里社区"];
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
