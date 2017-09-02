//
//  TDMTNearbySearchViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/2.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDMTNearbySearchViewController.h"
#import "TDNearbyTableViewCell.h"
#import "BaiduMapManager.h"

@interface TDMTNearbySearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic ,weak)UISearchBar *customSearchBar; //系统自带搜索框
@property(nonatomic ,strong)UITableView *tableview; //列表
@property(nonatomic ,strong)NSArray<BMKPoiInfo *> *dataArray; //数组

@end

@implementation TDMTNearbySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.leftBarButtonItem =[UIBarButtonItem leftBarButtonItemWithImage:[UIImage imageNamed:@"返回"] highlighted:[UIImage imageNamed:@"返回"]  target:self selector:@selector(clickCancel)];
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem rightBarButtonItemWithTitle:@"搜索" titleColor:[UIColor redColor] target:self selector:@selector(clickSourch)];
    
    [self customSearchBar]; //添加搜索框
    [self.view addSubview:self.tableview];  //添加列表
    [self.customSearchBar becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden =NO;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_customSearchBar removeFromSuperview];
}



#pragma mark --private---
//返回
-(void)clickCancel
{
    [self.view resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//搜索点击
-(void)clickSourch
{


}


#pragma mark ---Delagate--
#pragma mark ---TableViewDelagate-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    TDNearbyTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[TDNearbyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryNone;
    }

    BMKPoiInfo *info =self.dataArray[indexPath
                                     .row];
    [cell getDataWithModel:info];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark --UISearchBarDelegate---
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        
 
    } else{
        
        [[BaiduMapManager shareLocationManager] getPoiResultWithCity:@"北京" withSearchKeyword:searchText result:^(BMKPoiResult *result) {

            self.dataArray =result.poiInfoList;
            [self.tableview reloadData];
            
        } errorCode:^(BMKSearchErrorCode error) {
            
        }];
    }
    
}


#pragma mark --getter--
-(UISearchBar *)customSearchBar
{
    if (!_customSearchBar) {
        
        CGRect mainViewBounds = self.navigationController.view.bounds;
        UISearchBar *customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-140)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-140, 40)];
        customSearchBar.delegate = self;
        customSearchBar.showsCancelButton = NO;
        customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        customSearchBar.layer.masksToBounds =YES;
        customSearchBar.layer.cornerRadius =40;
        customSearchBar.placeholder =@"请输入搜索地址……";
        [self.navigationController.view addSubview:customSearchBar];  //添加搜索框
        _customSearchBar =customSearchBar;
    }
    return _customSearchBar;
}
-(UITableView *)tableview
{
    if (_tableview ==nil) {
        
        _tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
#warning 注意在tableView中必须进行代理的相关设置 不然不能正常显示--------
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        //        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.backgroundColor =[UIColor whiteColor];
        
    }
    return _tableview;
}




@end
