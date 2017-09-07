//
//  TDThemeViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/3.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDThemeViewController.h"

// 颜色
#define PYTHEME_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define PYTHEME_RANDOM_COLOR  PYTHEME_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface TDThemeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation TDThemeViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"主题皮肤选择";
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.collectionView]; //添加
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 51;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = PYTHEME_RANDOM_COLOR;
    cell.layer.cornerRadius = 5;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出cell
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    
}



#pragma mark ---getter---
- (UICollectionView *)collectionView
{
    if (_collectionView == nil){
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 80) / 3;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = 20;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, SCREEN_HEIGHT-40-30) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
        
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    }
    return  _collectionView;
}


@end
