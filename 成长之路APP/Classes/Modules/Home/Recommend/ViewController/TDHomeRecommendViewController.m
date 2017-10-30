//
//  TDHomeRecommendViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeRecommendViewController.h"
#import "TDHomeRecommendViewModel.h"

#define kSectionEditCommen  0   //小编推荐
#define kSectionLive        1   //现场直播
#define kSectionGuess       2   //猜你喜欢
#define kSectionCityColumn  3   //城市歌单
#define kSectionSpecial     4   //精品听单
#define kSectionAdvertise   5   //推广
#define kSectionHotCommends 6   //热门推荐
#define kSectionMore        7   //更多分类

@interface TDHomeRecommendViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)SDCycleScrollView *headerCycleScrollView; //首页轮播图
@property(nonatomic,strong)NSArray *imagesURLStrings; //图片数组
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic, strong)UIView *headerView; //头部承载视图
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)TDHomeRecommendViewModel *viewModel;

@end

@implementation TDHomeRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.view addSubview:self.tableView];
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.viewModel refreshDataSource];
}

#pragma mark ---Private---







#pragma mark ---UITableViewDelegate/UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return [self.viewModel numberOfSections];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.viewModel numberOfItemsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor =[UIColor orangeColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel heightForRowAtIndex:indexPath];
}





#pragma mark ---getter--
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64-49) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView =[self headerView];
        _tableView.backgroundColor =[UIColor clearColor];
    }
    return _tableView;
}

-(TDHomeRecommendViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel =[[TDHomeRecommendViewModel alloc] init];
    }
    return _viewModel;
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4)];
        [_headerView addSubview:self.headerCycleScrollView];
    }
    return _headerView;
}

//------轮播图
-(SDCycleScrollView *)headerCycleScrollView
{
    if (!_headerCycleScrollView) {
        
        // 网络加载 --- 创建带标题的图片轮播器
        _headerCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _headerCycleScrollView.backgroundColor =[UIColor whiteColor];
        _headerCycleScrollView.infiniteLoop =YES;  //是否无限循环
        _headerCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight; //page控件是否居中
        _headerCycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
        // --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _headerCycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
            _headerCycleScrollView.titlesGroup =self.titleArray;
        });
        
        // block监听点击方式
        _headerCycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            
            NSLog(@">>>>>  %ld", (long)index);
        };
    }
    return _headerCycleScrollView;
}

//图片数组
-(NSArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
        _imagesURLStrings = @[
                              @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                              @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                              ];
    }
    return _imagesURLStrings;
}
//文字数组
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray =@[@"终于放假啦,哈哈哈😆",@"众志成城,抗洪救灾!……",@"北京定福庄---亲爱的北京!"];
    }
    return _titleArray;
}

@end
