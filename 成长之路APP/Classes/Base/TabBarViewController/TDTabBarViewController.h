//
//  TDTabBarViewController.h
//  成长之路APP
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 hui. All rights reserved.
//

#pragma mark - @interface TabBarView

@protocol TabBarViewDelegate <NSObject>
-(void)tabBarViewSelectedItem:(NSInteger)index;
-(void)tabBarViewCenterItemClick:(UIButton *)button;
@end

@interface TabBarView : UIView

@property (nonatomic, strong) UIImage * backgroundImage;
@property (nonatomic, strong) UIImage * centerImage;
@property (nonatomic, strong) NSString *centerTitle;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, assign) NSUInteger badgeValue;
@property (nonatomic, assign) NSInteger itemSelectedIndex;
@property (nonatomic, strong) UIButton * centerButton;
@property (nonatomic, assign) BOOL showCenter;

@property (nonatomic, weak) id<TabBarViewDelegate>delegate;

- (id)initWithItemSelectedImages:(NSMutableArray *)selected
                    normalImages:(NSMutableArray *)normal
                          titles:(NSMutableArray *)titles;
-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index;

@end

//tab controller
@class TDTabBarViewController;
@protocol TDTabBarViewControllerDelegate <NSObject>

@optional
-(void)tabBarController:(TDTabBarViewController*)tabController didSelectIndex:(NSInteger)index;
-(void)tabBarControllerdDidSelectCenter:(TDTabBarViewController*)tabController;
@end



@interface TDTabBarViewController : UITabBarController

@property (nonatomic, strong)TabBarView * tabBarView;

@property (nonatomic, assign) NSInteger selectedItem;

/** 是否显示中间按钮，默认为NO */
@property (nonatomic, assign) BOOL showCenterItem;

/** 中间按钮的图片 */
@property (nonatomic, strong) UIImage * centerItemImage;

/** 中间按钮的文字 */
@property (nonatomic, strong) NSString * centerItemTitle;

/** 中间按钮控制的试图控制器 */
@property (nonatomic, strong) UIViewController * xm_centerViewController;

/** 文字颜色 */
@property (nonatomic, strong) UIColor * textColor;

@property (nonatomic, weak) id<TDTabBarViewControllerDelegate>XMDelegate;


/**
 *  指定item设置badgeValue
 */
-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index;

/**
 *  隐藏或显示TabBar
 */
-(void)xmTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

/**
 *  隐藏或显示中间试图控制器
 */
-(void)showCenterViewController:(BOOL)show animated:(BOOL)animated;

- (id)initWithTabBarSelectedImages:(NSMutableArray *)selected
                      normalImages:(NSMutableArray *)normal
                            titles:(NSMutableArray *)titles;





@end




@interface XMButton : UIButton

@property (nonatomic, assign) NSUInteger badgeValue;
+ (instancetype)xm_shareButton;

@end



