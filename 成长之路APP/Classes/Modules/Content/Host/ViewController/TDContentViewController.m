//
//  TDContentViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentViewController.h"
#import "ZJScrollPageView.h"
#import "TDRecommendViewController.h"
#import "TDDownViewController.h"
#import "TDShoppingViewController.h"

@interface TDContentViewController ()<UIScrollViewDelegate,ZJScrollPageViewDelegate>

@property(nonatomic,strong)ZJScrollPageView *scrollPageView;
@property(nonatomic,strong)NSArray *themeArray; //主题分类
@property(nonatomic,strong)NSArray *childViewControllers; //子控制器


@end

@implementation TDContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.view addSubview:self.scrollPageView]; //添加标题segment

}

#pragma mark ---private---





#pragma mark ----Delagate---
#pragma mark ---ZJScrollPageViewDelegate
-(NSInteger)numberOfChildViewControllers
{
    return self.childViewControllers.count;
}

-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = (UIViewController<ZJScrollPageViewChildVcDelegate>*)reuseViewController;
    
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    
    return childVc;
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}





#pragma mark --getter---
-(ZJScrollPageView *)scrollPageView
{
    if (!_scrollPageView) {
        
        ZJSegmentStyle *style =[[ZJSegmentStyle alloc] init];
        //显示滚动条
        style.showLine =YES;
        //标题不滚动
        style.scrollTitle =NO;
        //segmentView是否有弹性
        style.segmentViewBounces =NO;
        //取消点击时候的动画效果
        style.animatedContentViewWhenTitleClicked =NO;
        //取消内容视图弹框
        //        style.scrollContentView =NO;
        //标题颜色
        style.selectedTitleColor = [UIColor redColor];
        //标题滚动条颜色
        style.scrollLineColor = [UIColor redColor];
        //标题字体
        style.titleFont =[UIFont systemFontOfSize:16];
        //颜色渐变
        style.gradualChangeTitleColor =YES;
        //初始化
        _scrollPageView =[[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) segmentStyle:style titles:self.themeArray parentViewController:self delegate:self];
        
    }
    return _scrollPageView;
}

-(NSArray *)themeArray
{
    if (!_themeArray) {
        _themeArray =@[@"推荐",@"下载",@"购物"];
    }
    return _themeArray;
}
-(NSArray *)childViewControllers
{
    if (!_childViewControllers) {
        _childViewControllers =@[[[TDRecommendViewController alloc]init],
                                 [[TDDownViewController alloc]init],
                                 [[TDShoppingViewController alloc]init]
                                 ];
    }
    return _childViewControllers;
}




@end



