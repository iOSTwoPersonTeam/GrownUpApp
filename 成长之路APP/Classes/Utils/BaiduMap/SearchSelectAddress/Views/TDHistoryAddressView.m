//
//  TDHistoryAddressView.m
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHistoryAddressView.h"
#import "TTGTextTagCollectionView.h"

@interface TDHistoryAddressView ()<TTGTagCollectionViewDelegate>

@property(nonatomic ,weak)UILabel *titleLabel; //标题
@property(nonatomic ,weak)UIButton *delateButton; //删除
@property(nonatomic,weak)TTGTextTagCollectionView *abilityView; //能力标签

@end

@implementation TDHistoryAddressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        NSArray *tagText =@[@"的身高多少",@"多个地方和",@"的发货速度",@"的返回的分数",@"第三个哈哈的分数",@"都会发的"];
        [self.abilityView addTags:tagText];
    }
  
    return self;
}


#pragma mark --布局UI-------
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame =CGRectMake(20, 20, 200, 20);
    self.delateButton.frame =CGRectMake(SCREEN_WIDTH-40, CGRectGetMinY(self.titleLabel.frame), 20, 20);
    self.abilityView.frame =CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame)+30, SCREEN_WIDTH-40, SCREEN_HEIGHT/2);


}




#pragma mark ---getter---

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        UILabel *titleLabel =[[UILabel alloc] init];
        titleLabel.textColor =[UIColor grayColor];
        titleLabel.font =[UIFont systemFontOfSize:18 weight:0.2];
        titleLabel.text =@"历史搜索";
        [self addSubview:titleLabel];
        _titleLabel =titleLabel;
    }
    return _titleLabel;
}

-(UIButton *)delateButton
{
    if (!_delateButton) {
        
        UIButton *delateButton =[[UIButton alloc] init];
        [delateButton setImage:[UIImage imageNamed:@"Delate"] forState:UIControlStateNormal];
        [self addSubview:delateButton];
        _delateButton =delateButton;
    }
    return _delateButton;
}

-(TTGTextTagCollectionView *)abilityView
{
    if (!_abilityView) {
        
       TTGTextTagCollectionView *abilityView = [[TTGTextTagCollectionView alloc] init];
        abilityView.alignment = TTGTagCollectionAlignmentLeft;
        abilityView.numberOfLines = 0;
        abilityView.selectionLimit = 0;
        abilityView.scrollDirection = TTGTagCollectionScrollDirectionVertical;
        abilityView.showsVerticalScrollIndicator = NO;
        abilityView.enableTagSelection = YES;
        abilityView.delegate = self;
        abilityView.defaultConfig.tagBorderWidth = 0.5;
        abilityView.defaultConfig.tagCornerRadius = 4.f;
        abilityView.defaultConfig.tagTextFont = [UIFont systemFontOfSize:13];
        abilityView.defaultConfig.tagSelectedTextColor = [UIColor lightGrayColor];
        abilityView.defaultConfig.tagBackgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        abilityView.defaultConfig.tagSelectedBackgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        abilityView.defaultConfig.tagShadowColor = nil;
        abilityView.defaultConfig.tagShadowOffset = CGSizeMake(0, 0);
        abilityView.defaultConfig.tagExtraSpace = CGSizeMake(20, 10);
        abilityView.defaultConfig.tagTextColor = [UIColor grayColor];
        abilityView.backgroundColor =[UIColor whiteColor];
        
        [self addSubview:abilityView];
        _abilityView =abilityView;
    }
    return _abilityView;
}







@end



