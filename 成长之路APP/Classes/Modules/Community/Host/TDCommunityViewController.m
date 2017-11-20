//
//  TDCommunityViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDCommunityViewController.h"
#import "ZJScrollPageView.h"
#import "TDActivityStatusViewController.h"
#import "TDFriendStatusViewController.h"
#import "TDMessageViewController.h"

@interface TDCommunityViewController ()<ZJScrollPageViewDelegate>
@property(nonatomic,strong)ZJScrollPageView *scrollPageView;
@property(nonatomic,strong)NSArray *themeArray; //主题分类
@property(nonatomic,strong)NSArray *childViewControllers; //子控制器
@property(nonatomic, strong)MarqueeLabel *rollWordLabel; //滚动文字

@end

@implementation TDCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.scrollPageView]; //添加标题segment
    
    NSString *markString =@" 环信聊天登录账号:15712860260,15712860261均可";
    self.rollWordLabel.text =markString;
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
-(MarqueeLabel *)rollWordLabel
{
    if (!_rollWordLabel) {
        _rollWordLabel =[[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _rollWordLabel.backgroundColor =[UIColor whiteColor];
        _rollWordLabel.font =[UIFont systemFontOfSize:15];
        _rollWordLabel.textColor =[UIColor blackColor];
        _rollWordLabel.marqueeType =MLContinuous;
        _rollWordLabel.animationCurve =UIViewAnimationOptionCurveLinear;
        _rollWordLabel.userInteractionEnabled =YES;
        _rollWordLabel.rate =50;
        _rollWordLabel.fadeLength =10;
        [self.view addSubview:_rollWordLabel];
    }
    return _rollWordLabel;
}
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
        _scrollPageView =[[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT -40) segmentStyle:style titles:self.themeArray parentViewController:self delegate:self];
        
    }
    return _scrollPageView;
}

-(NSArray *)themeArray
{
    if (!_themeArray) {
        _themeArray =@[@"消息实现",@"联系人实现",@"朋友圈"];
    }
    return _themeArray;
}
-(NSArray *)childViewControllers
{
    if (!_childViewControllers) {
        _childViewControllers =@[
                                 [[TDMessageViewController alloc]init],
                                 [[TDFriendStatusViewController alloc]init],
                                 [[TDActivityStatusViewController alloc]init]
  
                                 ];
    }
    return _childViewControllers;
}


@end
