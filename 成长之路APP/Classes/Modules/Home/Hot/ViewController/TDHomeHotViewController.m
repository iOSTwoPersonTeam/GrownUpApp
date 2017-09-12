//
//  TDHomeHotViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeHotViewController.h"

@interface TDHomeHotViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView; //首页轮播图
@property(nonatomic,strong)NSArray *imagesURLStrings; //图片数组
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation TDHomeHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.cycleScrollView];  //添加轮播图
}


#pragma mark ---Private---





#pragma mark ---Delegate----



#pragma mark ---getter--
//------轮播图
-(SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/4) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.backgroundColor =[UIColor whiteColor];
        _cycleScrollView.infiniteLoop =YES;  //是否无限循环
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight; //page控件是否居中
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
        // --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
            _cycleScrollView.titlesGroup =self.titleArray;
        });
        
        // block监听点击方式
        _cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            
            NSLog(@">>>>>  %ld", (long)index);
        };
    }
    return _cycleScrollView;
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
