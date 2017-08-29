//
//  TDModelViewController.h
//  成长之路APP
//
//  Created by mac on 2017/7/29.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@class TDRootModel;

@interface TDModelViewController : TDRootViewController

@property(nullable,nonatomic,strong)TDRootModel *loadModel;

@property(nonatomic,assign)BOOL hudEnabled; //显示页面时,是否显示提示框,默认显示(加载提示框)

-(nullable Class)modelClass; //model类型

//数据加载以及状态,可由子类继承
-(void)modelWillLoad; //数据加载前调用
-(void)modelDidFinishLoad; //数据加载成功调用
-(void)modelDidFailedLoad; //数据加载失败调动


@end



