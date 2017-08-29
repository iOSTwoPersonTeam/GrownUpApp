//
//  TDRootModel.h
//  成长之路APP
//
//  Created by mac on 2017/7/29.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDModelDelegate <NSObject>

@optional
-(void)modelWillLoad; //数据加载前调用
-(void)modelDidFinishLoad; //数据加载成功调用
-(void)modelDidFailedLoad; //数据加载失败调用

@end

@interface TDRootModel : NSObject

@property(nonatomic,assign)NSInteger pageRow; //每页请求数据 默认20
@property(nonatomic,assign)NSInteger pageNumber; //请求哪页数据
@property(nonatomic,strong)id extraParameter; //附加参数
@property(nonatomic,assign)BOOL hasMore; //是否还有更多数据
@property(nonatomic,assign)BOOL refreshing; //是否正在刷新(下拉)
@property(nonatomic,assign)BOOL loadingMore; //是否正在加载更多数据(上拉)
@property(nonatomic,strong)NSMutableArray *allItems; //解析获得数据,元素为数组或者单个对象
@property(nonatomic,weak)id<TDModelDelegate> modelDelagate; //设置代理

+(instancetype)createModelWithDelegate:(id<TDModelDelegate>)modelDelegate;
-(void)loadData;   //加载数据

-(void)loadMore:(BOOL)more; //more为YES,加载更多; more为NO,刷新
-(void)loadMore:(BOOL)more withExtraparams:(id)extraparameter; //带参数请求更多或刷新



@end



