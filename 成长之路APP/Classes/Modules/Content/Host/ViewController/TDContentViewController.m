//
//  TDContentViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentViewController.h"
#import "TDContentTableView.h"
#import "TDContentScrollView.h"

#define functionHeaderViewHeight 95
#define HeaderSpaceViewHeight 60

@interface TDContentViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIView *mainNavView; //导航栏
@property(nonatomic, strong)UIView *coverNavView; //上移后的导航栏
@property (nonatomic,assign) CGFloat topOffsetY;
@property(nonatomic, strong)TDContentScrollView *mymainScrollview;
@property(nonatomic, strong)TDContentTableView *mymainTableView;

@end

@implementation TDContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topOffsetY = functionHeaderViewHeight + HeaderSpaceViewHeight;
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.mainNavView]; //常态导航栏
    
    [self.view addSubview:self.coverNavView];
    
    self.mymainScrollview =[[TDContentScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.mymainScrollview.backgroundColor =[UIColor orangeColor];
    self.mymainScrollview.delegate =self;
    [self.view addSubview:self.mymainScrollview];
    
    CGFloat orginY = HeaderSpaceViewHeight + functionHeaderViewHeight;
    CGFloat tableviewHeight = SCREEN_HEIGHT - orginY - 64;
    self.mymainTableView =[[TDContentTableView alloc] initWithFrame:CGRectMake(0, orginY, SCREEN_WIDTH, tableviewHeight)];
    self.mymainTableView.backgroundColor =[UIColor purpleColor];
    self.mymainTableView.scrollEnabled =NO;
    [self.mymainScrollview addSubview:self.mymainTableView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentSize:self.mymainTableView.contentSize];
}

- (void)updateContentSize:(CGSize)size {
    CGSize contentSize = size;
    contentSize.height = contentSize.height + _topOffsetY;
    _mymainScrollview.contentSize = contentSize;
    CGRect newframe = _mymainTableView.frame;
    newframe.size.height = size.height;
    _mymainTableView.frame = newframe;
}



#pragma mark---private--

- (void)functionViewAnimationWithOffsetY:(CGFloat)offsetY{
    if (offsetY > functionHeaderViewHeight / 2.0) {
        [self.mymainScrollview setContentOffset:CGPointMake(0, 95) animated:YES];
    }else {
        [self.mymainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)setScrollViewContentOffSetWithPoint:(CGPoint) point {
    if (!self.mymainTableView.mj_header.isRefreshing) {
        self.mymainTableView.contentOffset = point;
    }
}

#pragma mark ----Delagate---
#pragma mark - ScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat y = scrollView.contentOffset.y;
    
    if (y < - 65) {
        [self.mymainTableView.mj_header beginRefreshing];
    }else if(y > 0 && y <= functionHeaderViewHeight) {
        [self functionViewAnimationWithOffsetY:y];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f",y);
    if (y < 0) {
        self.mymainScrollview.functionHeaderView.alpha = 1;
        CGRect newFrame = self.mymainScrollview.headerView.frame;
        newFrame.origin.y = y;
        self.mymainScrollview.headerView.frame = newFrame;
        newFrame = self.mymainTableView.frame;
        newFrame.origin.y = y + _topOffsetY;
        self.mymainTableView.frame = newFrame;
        
        //偏移量给到tableview，tableview自己来滑动
        if (!self.mymainTableView.mj_header.isRefreshing) {
            self.mymainTableView.contentOffset = CGPointMake(0, y);
        }
        
        //功能区状态回归
        newFrame = self.mymainScrollview.functionHeaderView.frame;
        newFrame.origin.y = 0;
        self.mymainScrollview.functionHeaderView.frame = newFrame;
        
        //处理透明度
        _mainNavView.alpha = 1;
        _coverNavView.alpha = 0;
    }
    else if(y < functionHeaderViewHeight && y > 0) {
        CGRect newFrame = self.mymainScrollview.headerView.frame;
        newFrame.origin.y = y/2;
        self.mymainScrollview.functionHeaderView.frame = newFrame;
        
        //处理透明度
        CGFloat alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0;
        self.mymainScrollview.functionHeaderView.alpha = alpha;
        if (alpha > 0.5) {
            CGFloat newAlpha = alpha * 2 - 1;
            _mainNavView.alpha = newAlpha;
            _coverNavView.alpha = 0;
        }else {
            CGFloat newAlpha = alpha * 2;
            _mainNavView.alpha = 0;
            _coverNavView.alpha = 1 - newAlpha;
        }
    }
}





#pragma mark --getter--
//导航栏
- (UIView *)mainNavView{
    if(!_mainNavView){
        _mainNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _mainNavView.backgroundColor = [UIColor clearColor];
        
        UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 60, 30)];
        [payButton setImage:[UIImage SizeImage:@"设置" toSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        [payButton setTitle:@"账单" forState:UIControlStateNormal];
        payButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [payButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [payButton setImagePosition:ImageAndTitlePositionLeft WithImageAndTitleSpacing:10.0];
        [_mainNavView addSubview:payButton];
    }
    return _mainNavView;
}


- (UIView *)coverNavView{
    if(!_coverNavView){
        _coverNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _coverNavView.backgroundColor = [UIColor clearColor];
        NSArray *imageArray =@[@"设置",@"设置",@"设置"];
        float with =40;
        for (int i=0; i <imageArray.count; i++) {
            UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(30*(i +1) +with*i, 30, with, 25)];
            [button setImage:[UIImage  SizeImage:imageArray[i] toSize:CGSizeMake(25, 25)] forState:UIControlStateNormal];
            button.backgroundColor =[UIColor orangeColor];
            [_coverNavView addSubview:button];
        }
        
        _coverNavView.alpha = 0;
    }
    return _coverNavView;
}



@end



