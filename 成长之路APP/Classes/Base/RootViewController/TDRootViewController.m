//
//  TDRootViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDRootViewController ()

@end

@implementation TDRootViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return _statuaBarStyle;
}
//动态更新状态栏颜色
-(void)setStatuaBarStyle:(UIStatusBarStyle)statuaBarStyle
{
    _statuaBarStyle =statuaBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     //注意这里的设置,影响到ViewController控制器的布局的问题
    self.view.backgroundColor = GlobalBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hidesBottomBarWhenPushed = YES;
    self.preferredContentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    self.statuaBarStyle = UIStatusBarStyleDefault;
    self.backEnabled =YES;
    self.isHidenNaviBar =NO; //默认不隐藏
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


/*
 *  是否显示返回按钮
 */
-(void)setBackEnabled:(BOOL)backEnabled
{
    _backEnabled =backEnabled;
    NSInteger VCCount =self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (backEnabled && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftBarButtonItemWithImage:[UIImage imageNamed:@"返回"] highlighted:[UIImage imageNamed:@"返回"] target:self selector:@selector(back)];
    } else{
    
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }

}

/*
 *  是否隐藏导航栏
 */
-(void)setIsHidenNaviBar:(BOOL)isHidenNaviBar
{
    _isHidenNaviBar =isHidenNaviBar;
    
    if (isHidenNaviBar ==YES) {
     
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

//返回事件
- (void)back
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self navigationBack];
}







@end





