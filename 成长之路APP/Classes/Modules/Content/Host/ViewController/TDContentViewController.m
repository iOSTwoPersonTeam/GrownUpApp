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
@property(nonatomic, strong)TDContentScrollView *mainScrollview;
@property(nonatomic, strong)TDContentTableView *mainTableView;

@end

@implementation TDContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topOffsetY = functionHeaderViewHeight + HeaderSpaceViewHeight;

    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.mainNavView]; //添加常态导航栏
    [self.view addSubview:self.coverNavView]; //添加变化后的导航栏
    [self.view addSubview:self.mainScrollview]; //添加主ScrollView
    [self.mainScrollview addSubview:self.mainTableView]; //添加主TableView
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentSize:self.mainTableView.contentSize];
}

#pragma mark---private--
- (void)updateContentSize:(CGSize)size {
    CGSize contentSize = size;
    contentSize.height = contentSize.height + _topOffsetY;
    _mainScrollview.contentSize = contentSize;
    CGRect newframe = _mainTableView.frame;
    newframe.size.height = size.height;
    _mainTableView.frame = newframe;
}

- (void)functionViewAnimationWithOffsetY:(CGFloat)offsetY{
    if (offsetY > functionHeaderViewHeight / 2.0) {
        [self.mainScrollview setContentOffset:CGPointMake(0, 95) animated:YES];
    }else {
        [self.mainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)setScrollViewContentOffSetWithPoint:(CGPoint) point {
    if (!self.mainTableView.mj_header.isRefreshing) {
        self.mainTableView.contentOffset = point;
    }
}

#pragma mark ----Delagate---
#pragma mark - ScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat y = scrollView.contentOffset.y;
    
    if (y < - 65) {
        [self.mainTableView.mj_header beginRefreshing];
    }else if(y > 0 && y <= functionHeaderViewHeight) {
        [self functionViewAnimationWithOffsetY:y];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%f",y);
    if (y < 0) {
        self.mainScrollview.functionHeaderView.alpha = 1;
        CGRect newFrame = self.mainScrollview.headerView.frame;
        newFrame.origin.y = y;
        self.mainScrollview.headerView.frame = newFrame;
        newFrame = self.mainTableView.frame;
        newFrame.origin.y = y + _topOffsetY;
        self.mainTableView.frame = newFrame;
        
        //偏移量给到tableview，tableview自己来滑动
        if (!self.mainTableView.mj_header.isRefreshing) {
            self.mainTableView.contentOffset = CGPointMake(0, y);
        }
        //功能区状态回归
        newFrame = self.mainScrollview.functionHeaderView.frame;
        newFrame.origin.y = 0;
        self.mainScrollview.functionHeaderView.frame = newFrame;
        
        //处理透明度
        _mainNavView.alpha = 1;
        _coverNavView.alpha = 0;
    }
    else if(y < functionHeaderViewHeight && y > 0) {
        CGRect newFrame = self.mainScrollview.headerView.frame;
        newFrame.origin.y = y/2;
        self.mainScrollview.functionHeaderView.frame = newFrame;
        
        //处理透明度
        CGFloat alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0;
        self.mainScrollview.functionHeaderView.alpha = alpha;
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
        
        UIButton *emailButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 25, 25)];
        [emailButton setImage:[UIImage imageNamed:@"邮箱"] forState:UIControlStateNormal];
        [emailButton setImagePosition:ImageAndTitlePositionLeft WithImageAndTitleSpacing:10.0];
        [_mainNavView addSubview:emailButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, CGRectGetMinY(emailButton.frame), 60, 30)];
        titleLabel.text =@"内容";
        titleLabel.font =[UIFont fontWithName:@"Helvetica" size:18];
        titleLabel.textColor =GlobalThemeColor;
        [_mainNavView addSubview:titleLabel];

        UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, CGRectGetMinY(emailButton.frame), 25, 25)];
        [payButton setImage:[UIImage imageNamed:@"历史"] forState:UIControlStateNormal];
        [payButton setImagePosition:ImageAndTitlePositionLeft WithImageAndTitleSpacing:10.0];
        [_mainNavView addSubview:payButton];
        
        UILabel *lineLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor =GlobalBackgroundColor;
        [_mainNavView addSubview:lineLabel];

    }
    return _mainNavView;
}

- (UIView *)coverNavView{
    if(!_coverNavView){
        _coverNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _coverNavView.backgroundColor = [UIColor clearColor];
        NSArray *imageArray =@[@"邮箱",@"下载",@"历史"];
        float with =27;
        for (int i=0; i <imageArray.count; i++) {
            UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(30*(i +1) +with*i, 30, with, 27)];
            [button setImage:[UIImage  imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [_coverNavView addSubview:button];
        }
        UILabel *lineLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor =GlobalBackgroundColor;
        [_coverNavView addSubview:lineLabel];
        _coverNavView.alpha = 0;
    }
    return _coverNavView;
}

//主ScrollView
-(TDContentScrollView *)mainScrollview
{
    if (!_mainScrollview) {
        _mainScrollview =[[TDContentScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64 -49)];
        _mainScrollview.backgroundColor =[UIColor whiteColor];
        _mainScrollview.delegate =self;
        _mainScrollview.scrollIndicatorInsets = UIEdgeInsetsMake(155, 0, 0, 0);
    }
    return _mainScrollview;
}

//主TableView
-(TDContentTableView *)mainTableView
{
    if (!_mainTableView) {
        CGFloat orginY = HeaderSpaceViewHeight + functionHeaderViewHeight;
        CGFloat tableviewHeight = SCREEN_HEIGHT - orginY - 64;
        _mainTableView =[[TDContentTableView alloc] initWithFrame:CGRectMake(0, orginY, SCREEN_WIDTH, tableviewHeight)];
        _mainTableView.backgroundColor =[UIColor clearColor];
        _mainTableView.scrollEnabled =NO;
    }
    return _mainTableView;
}





@end



