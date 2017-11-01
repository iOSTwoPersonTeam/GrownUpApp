//
//  TDHomeRecommendViewController.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeRecommendViewController.h"
#import "TDHomeRecommendViewModel.h"
#import "TDHomeHeaderCollectionViewCell.h"
#import "TDFindStyleCollectionViewCell.h"
#import "TDFindLiveStyleCollectionViewCell.h"
#import "TDFindSpecialStyleCollectionViewCell.h"

/*
 注册cellID
 */
#define kSectionADImageCellID    @"kSectionADImageID"   //顶部广告轮播图部分cellID
#define kSectionEditCommenCellID  @"kSectionEditCommenID"   //小编推荐cellID
#define kSectionLiveCellID        @"kSectionLiveID"    //现场直播cellID
#define kSectionSpecialCellID     @"kSectionSpecialCellID"    //精品听单cellID

/*
 分区section
 */
#define kSectionADImage     0      //顶部广告轮播图
#define kSectionEditCommen  1   //小编推荐
#define kSectionLive        2   //现场直播
#define kSectionSpecial     3   //精品听单

@interface TDHomeRecommendViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)TDHomeRecommendViewModel *viewModel;

@end

@implementation TDHomeRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    [self.viewModel refreshDataSource];
}

#pragma mark ---Private---







#pragma mark ---UICollectionViewDelegate/UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel numberOfSections];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==kSectionADImage) {
        TDHomeHeaderCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kSectionADImageCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.model =self.viewModel.recommendModel.focusImages;
        cell.discoverModel =self.viewModel.hotGuessModel.discoveryColumns;
        return cell;
    }
   else if (indexPath.section ==kSectionEditCommen) {
        TDFindStyleCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kSectionEditCommenCellID forIndexPath:indexPath];
        cell.backgroundColor =[UIColor whiteColor];
        cell.model =self.viewModel.recommendModel.editorRecommendAlbums;
        return cell;
    }
   else if (indexPath.section ==kSectionLive) {
        TDFindLiveStyleCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kSectionLiveCellID forIndexPath:indexPath];
        cell.backgroundColor =[UIColor whiteColor];
       cell.model =self.viewModel.liveModel;
        return cell;
    }
   else if (indexPath.section ==kSectionSpecial) {
       TDFindSpecialStyleCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kSectionSpecialCellID forIndexPath:indexPath];
       cell.backgroundColor =[UIColor whiteColor];
       cell.model = self.viewModel.recommendModel.specialColumn;
       return cell;
   }
    return nil;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return [self.viewModel sizeForRowAtIndex:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section ==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else if (section ==1){
        
        return UIEdgeInsetsMake(5, 10, 5, 10);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark ---getter--
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection =UICollectionViewScrollDirectionVertical;
        _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64-49-40) collectionViewLayout:flowlayout];
        _collectionView.delegate =self;
        _collectionView.dataSource =self;
         _collectionView.backgroundColor =[UIColor whiteColor];
        [self.view addSubview:_collectionView];
        //注册cell
 
        [_collectionView registerClass:[TDHomeHeaderCollectionViewCell class] forCellWithReuseIdentifier:kSectionADImageCellID];
        [_collectionView registerClass:[TDFindStyleCollectionViewCell class] forCellWithReuseIdentifier:kSectionEditCommenCellID];
        [_collectionView registerClass:[TDFindLiveStyleCollectionViewCell class] forCellWithReuseIdentifier:kSectionLiveCellID];
        [_collectionView registerClass:[TDFindSpecialStyleCollectionViewCell class] forCellWithReuseIdentifier:kSectionSpecialCellID];
       //注册头部view
//        [_collectionView registerClass:[HeaderCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
    return _collectionView;
}

-(TDHomeRecommendViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel =[[TDHomeRecommendViewModel alloc] init];
    }
    return _viewModel;
}

@end
