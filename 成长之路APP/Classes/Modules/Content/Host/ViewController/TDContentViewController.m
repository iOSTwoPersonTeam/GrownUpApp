//
//  TDContentViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentViewController.h"

#define functionHeaderViewHeight 95
#define HeaderSpaceViewHeight 60

@interface TDContentViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView *mainNavView; //导航栏
@property(nonatomic, strong)UIScrollView *mainScrollView; //主ScrollView
@property(nonatomic, strong)UIView *functionHeaderView; //主功能按钮
@property(nonatomic, strong)UIView *headerSpaceView; //主功能区下方按钮
@property(nonatomic, strong)UIView *coverNavView; //上移后的导航栏
@property(nonatomic, strong)UITableView *mainTableView;
@property(nonatomic, strong)UIView *headerView;
@property (nonatomic,assign) CGFloat topOffsetY;

@end

@implementation TDContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topOffsetY = functionHeaderViewHeight + HeaderSpaceViewHeight;
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.mainNavView]; //常态导航栏
    [self.view addSubview:self.mainScrollView]; //主要ScrollView
    [self.mainScrollView addSubview:self.headerView];
    [self.headerView addSubview:self.functionHeaderView]; //主功能按钮
    [self.headerView addSubview:self.headerSpaceView]; //主功能区域下方按钮
    [self.mainScrollView addSubview:self.mainTableView];
    [self.view addSubview:self.coverNavView];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContentSize:self.mainTableView.contentSize];
}

- (void)updateContentSize:(CGSize)size {
    CGSize contentSize = size;
    contentSize.height = contentSize.height + _topOffsetY;
    _mainScrollView.contentSize = contentSize;
    CGRect newframe = _mainTableView.frame;
    newframe.size.height = size.height;
    _mainTableView.frame = newframe;
}


#pragma mark---private--

- (void)functionViewAnimationWithOffsetY:(CGFloat)offsetY{
    if (offsetY > functionHeaderViewHeight / 2.0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 95) animated:YES];
    }else {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)setScrollViewContentOffSetWithPoint:(CGPoint) point {
    if (!self.mainTableView.mj_header.isRefreshing) {
        self.mainTableView.contentOffset = point;
    }
}

#pragma mark ----Delagate---
#pragma mark ----tableViewDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor =[UIColor orangeColor];
    cell.textLabel.text =@"大家好";
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


#pragma mark  ---- ScrollViewDelegate
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
        self.functionHeaderView.alpha = 1;
        CGRect newFrame = self.headerView.frame;
        newFrame.origin.y = y;
        self.headerView.frame = newFrame;
        newFrame = self.mainTableView.frame;
        newFrame.origin.y = y + _topOffsetY;
        self.mainTableView.frame = newFrame;
        
        //偏移量给到tableview，tableview自己来滑动
        if (!self.mainTableView.mj_header.isRefreshing) {
            self.mainTableView.contentOffset = CGPointMake(0, y);
        }
        
        //功能区状态回归
        newFrame = self.functionHeaderView.frame;
        newFrame.origin.y = 0;
        self.functionHeaderView.frame = newFrame;
    }
    else if(y < functionHeaderViewHeight && y > 0) {
        CGRect newFrame = self.headerView.frame;
        newFrame.origin.y = y/2;
        self.functionHeaderView.frame = newFrame;
        
        //处理透明度
        CGFloat alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0;
        _functionHeaderView.alpha = alpha;
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

//主ScrollView
-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _mainScrollView.backgroundColor =[UIColor blueColor];
        _mainScrollView.delegate = self;
        _mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(155, 0, 0, 0);
    }
    return _mainScrollView;
}

//主功能区按钮
- (UIView *)functionHeaderView {
    if(!_functionHeaderView){
        _functionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, functionHeaderViewHeight)];
        _functionHeaderView.backgroundColor = [UIColor purpleColor];
        
        NSArray *titleArray =@[@"扫一扫",@"付款",@"卡券",@"定位"];
        NSArray *imageArray =@[@"设置",@"设置",@"设置",@"设置"];
        float with =60;
        float spaceX =(SCREEN_WIDTH -titleArray.count *with)/titleArray.count;
        
        for (int i=0; i <titleArray.count; i++) {
            UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(spaceX/2 +with*i +spaceX *i, 10, with, 80)];
            [button setImage:[UIImage  SizeImage:imageArray[i] toSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.backgroundColor =[UIColor orangeColor];
            button.titleLabel.font =[UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setImagePosition:ImageAndTitlePositionTop WithImageAndTitleSpacing:10.0];
            [_functionHeaderView addSubview:button];
        }

    }
    return _functionHeaderView;
}

//主功能按钮下方区域
- (UIView *)headerSpaceView{
    if(!_headerSpaceView){
        _headerSpaceView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.functionHeaderView.frame), SCREEN_WIDTH, HeaderSpaceViewHeight)];
        _headerSpaceView.backgroundColor = [UIColor cyanColor];
    }
    return _headerSpaceView;
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

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, functionHeaderViewHeight + HeaderSpaceViewHeight)];
        _headerView.backgroundColor = [UIColor yellowColor];
    }
    return _headerView;
}


//taleView
-(UITableView *)mainTableView
{
    if (_mainTableView ==nil) {
        CGFloat orginY = HeaderSpaceViewHeight + functionHeaderViewHeight;
        CGFloat tableviewHeight = SCREEN_HEIGHT - orginY - 64;
        _mainTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, orginY, SCREEN_WIDTH, tableviewHeight) style:UITableViewStylePlain];
        _mainTableView.delegate =self;
        _mainTableView.dataSource =self;
        _mainTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator=NO;
        _mainTableView.scrollEnabled = NO;
        
    }
    return _mainTableView;
}




@end






