//
//  TDHomeHeaderCollectionViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeHeaderCollectionViewCell.h"
#import "TDCategotyCollectionView.h"

@interface TDHomeHeaderCollectionViewCell ()<SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)SDCycleScrollView *headerCycleScrollView; //首页轮播图
@property(nonatomic,weak)TDCategotyCollectionView *categoryCollectionView; //分类
@property(nonatomic,strong)NSMutableArray *imageArray; //轮播图数组

@end

@implementation TDHomeHeaderCollectionViewCell

#pragma mark ------public--
-(void)setModel:(XMLYFindFocusImagesModel *)model
{
    _model =model;
    [self.imageArray removeAllObjects];
    [_model.list enumerateObjectsUsingBlock:^(XMLYFindFocusImageDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.imageArray addObject:obj.pic];
    }];
    self.headerCycleScrollView.imageURLStringsGroup = self.imageArray;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)setDiscoverModel:(XMLYFindDiscoverColumnsModel *)discoverModel
{
    _discoverModel = discoverModel;
    self.categoryCollectionView.discoverModel =_discoverModel;
    [self.categoryCollectionView reloadData]; //获取数据后要重新刷新界面
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

#pragma mark --布局--
-(void)updateConstraints
{
    [super updateConstraints];
    [self.headerCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(SCREEN_HEIGHT/5));
    }];
    [self.categoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerCycleScrollView.mas_bottom);
        make.left.equalTo(_headerCycleScrollView.mas_left);
        make.right.equalTo(_headerCycleScrollView.mas_right);
        make.height.equalTo(@90);
    }];
}



#pragma mark --getter-----
//------轮播图
-(SDCycleScrollView *)headerCycleScrollView
{
    if (!_headerCycleScrollView) {
        // 网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *headerCycleScrollView = [[SDCycleScrollView alloc] init];
        headerCycleScrollView.placeholderImage =[UIImage imageNamed:@"placeholder"];
        headerCycleScrollView.delegate =self;
        headerCycleScrollView.infiniteLoop =YES;  //是否无限循环
        headerCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight; //page控件是否居中
        headerCycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self addSubview:headerCycleScrollView];
        _headerCycleScrollView =headerCycleScrollView;
        
        // block监听点击方式
        headerCycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            NSLog(@">>>>>  %ld", (long)index);
        };
    }
    return _headerCycleScrollView;
}

-(TDCategotyCollectionView *)categoryCollectionView
{
    if (!_categoryCollectionView) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        layout.itemSize =CGSizeMake(60, 90);
        TDCategotyCollectionView *categoryCollectionView =[[TDCategotyCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerCycleScrollView.frame), SCREEN_WIDTH, 90) collectionViewLayout:layout];
        [self addSubview:categoryCollectionView];
        categoryCollectionView.backgroundColor =[UIColor clearColor];
        categoryCollectionView.showsHorizontalScrollIndicator =NO;
        _categoryCollectionView =categoryCollectionView;
    }
    return _categoryCollectionView;
}

-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}


@end
