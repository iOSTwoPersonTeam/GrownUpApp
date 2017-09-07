//
//  TDRootViewController.h
//  成长之路APP
//
//  Created by mac on 2017/7/27.
//  Copyright © 2017年 hui. All rights reserved.
//

@interface TDRootViewController : UIViewController


/*
 * 修改状态栏颜色
 */
@property(nonatomic, assign)UIStatusBarStyle statuaBarStyle;

/*
 * 是否隐藏导航栏
 */
@property(nonatomic, assign)BOOL isHidenNaviBar;

/*
 * 显示返回按钮 默认显示Yes
 */
@property (nonatomic, assign) BOOL backEnabled;

/*
 *  返回事件方法
 */
- (void)back;


@end
