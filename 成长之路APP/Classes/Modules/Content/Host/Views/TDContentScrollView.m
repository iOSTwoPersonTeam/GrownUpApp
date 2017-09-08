//
//  TDContentScrollView.m
//  成长之路APP
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentScrollView.h"
#define functionHeaderViewHeight 95
#define HeaderSpaceViewHeight 60
@interface TDContentScrollView ()

@end

@implementation TDContentScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark ---布局--
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.functionHeaderView.frame =CGRectMake(0, 0, SCREEN_WIDTH, functionHeaderViewHeight);
    self.headerSpaceView.frame =CGRectMake(0, CGRectGetMaxY(self.functionHeaderView.frame), SCREEN_WIDTH, HeaderSpaceViewHeight);
    
}


#pragma mark ---private---



#pragma mark ---Delagate---



#pragma mark ----getter----
//主功能区按钮
- (UIView *)functionHeaderView {
    if(!_functionHeaderView){
        _functionHeaderView = [[UIView alloc]init];
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
        [self.headerView addSubview:_functionHeaderView];
    }
    return _functionHeaderView;
}

//主功能按钮下方区域
- (UIView *)headerSpaceView{
    if(!_headerSpaceView){
        _headerSpaceView = [[UIView alloc]init];
        _headerSpaceView.backgroundColor = [UIColor cyanColor];
        [self.headerView addSubview:_headerSpaceView];
    }
    return _headerSpaceView;
}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, functionHeaderViewHeight + HeaderSpaceViewHeight)];
        _headerView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_headerView];
    }
    return _headerView;
}









@end



