//
//  TDRootModel.m
//  成长之路APP
//
//  Created by mac on 2017/7/29.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootModel.h"

@implementation TDRootModel

+(instancetype)createModelWithDelegate:(id<TDModelDelegate>)modelDelegate
{
    TDRootModel *model =[[self alloc] init];
    model.modelDelagate =modelDelegate;
    [model loadData];
 
    return model;
}

-(instancetype)init
{
    if (self =[super init]) {
        
        _pageRow =20;
        _pageNumber =1;
        _allItems =[NSMutableArray array];
    }
   
    return self;
}

#pragma mark --加载数据
-(void)loadData
{
    if ([self.modelDelagate respondsToSelector:@selector(modelWillLoad)]) {
        
        [self.modelDelagate modelWillLoad];
    }

}

#pragma mark --加载更多数据或刷新
-(void)loadMore:(BOOL)more
{
    if (more) {
        _loadingMore =YES;
        _pageNumber +=1;
    }
    else{
        _refreshing =YES;
        _pageNumber =1;
        [_allItems removeAllObjects];
    }

    [self loadData];
}

#pragma mark --带参数加载更多数据或刷新
-(void)loadMore:(BOOL)more withExtraparams:(id)extraparameter
{
    _extraParameter =extraparameter;

    [self loadMore:more];
}



@end



