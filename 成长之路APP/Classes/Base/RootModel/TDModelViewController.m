//
//  TDModelViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/29.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDModelViewController.h"
#import "TDRootModel.h"

@interface TDModelViewController ()<TDModelDelegate>

@end

@implementation TDModelViewController

-(instancetype)init
{
    if (self =[super init]) {
        
        //是否显示提示框,默认显示
        _hudEnabled =NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _loadModel = [[self modelClass] createModelWithDelegate:self];
}

-(Class)modelClass
{
   
    return [TDRootModel class];
}

#pragma mark ---TDModelDalagate
//开始加载数据
-(void)modelWillLoad
{
  //显示提示框
    if (_hudEnabled) {
        
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

}

//加载数据完成
-(void)modelDidFinishLoad
{

   //隐藏提示框
    if (self.hudEnabled) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }

}

//加载数据失败
-(void)modelDidFailedLoad
{
   //隐藏提示框
    if (self.hudEnabled) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }

}







@end






