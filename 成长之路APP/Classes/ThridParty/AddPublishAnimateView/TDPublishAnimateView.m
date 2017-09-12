//
//  TDPublishAnimateView.m
//  成长之路APP
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPublishAnimateView.h"

#define JumpHeight 615

@interface TDButton : UIButton

@end

@implementation TDButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat magre =8; //间距
    CGFloat imgW =self.imageView.frame.size.width;
    CGFloat imgH =self.imageView.frame.size.width;
    CGFloat imgX =(self.frame.size.width-imgW)/2;
    self.imageView.frame =CGRectMake(imgX , 0, imgW, imgH);
    CGFloat titleH =self.titleLabel.frame.size.height;
    self.titleLabel.frame =CGRectMake(0, imgH +magre, self.frame.size.width, titleH);
    self.titleLabel.textAlignment =NSTextAlignmentCenter;
    
}

@end


@interface TDPublishAnimateView ()
{

    int columnNumber;
}
@property(nonatomic,strong)NSTimer *timer;
@property(assign,nonatomic)NSUInteger downIndex;
@property(assign,nonatomic)NSUInteger upIndex;
@property(nonatomic,strong)NSMutableArray *viewArray;

@end

@implementation TDPublishAnimateView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        [self  setMenu];
    }
    return self;
}

//按九宫格计算方式排列按钮
- (void)setMenu{
    int columnCount= self.columnCount ?self.columnCount :3;
    CGFloat width = self.frame.size.width/columnCount;
    CGFloat edge = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i<self.imageNameArray.count; i++) {
            int row=i/columnCount;
            int loc=i%columnCount;
            TDButton *button = [[TDButton alloc] init];
            button.frame = CGRectMake(edge+(edge+width)*loc, JumpHeight+edge+(edge+width-10)*row, width, width);
            [button setImage:[UIImage imageNamed:self.imageNameArray[i]] forState:UIControlStateNormal];
            if (self.textArray) {
            [button setTitle:self.textArray[i] forState:UIControlStateNormal];
            }
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.viewArray addObject:button];
        }
    });
}

#pragma mark --Private---
#pragma mark ---向上出现----
-(void)popupBtn
{
    if (_upIndex == self.viewArray.count) {
        [self.timer invalidate];
        _upIndex = 0;
        return;
    }
    UIView *myView = self.viewArray[_upIndex];
    [self setUpBtnAnim:myView];
    _upIndex++;
}

//设置按钮从第一个开始向上滑动显示
- (void)setUpBtnAnim:(UIView *)btn
{
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
        btn.transform = CGAffineTransformMakeTranslation(0, -JumpHeight);
    } completion:^(BOOL finished){
        
        //获取当前显示的菜单控件的索引
        _downIndex = self.imageNameArray.count - 1;
    }];
}

#pragma mark ---按钮从后往前下落
- (void)returnDownVC{
    
    if (_downIndex == -1) {
        [self.timer invalidate];
        return;
    }
    UIView *myView = self.viewArray[_downIndex];
    [self setDownBtnAnim:myView withIndex:_downIndex];
    _downIndex--;
}
//按钮下滑并返回上一个控制器
- (void)setDownBtnAnim:(UIView *)btn withIndex:(NSInteger )index
{
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, JumpHeight);
    } completion:^(BOOL finished) {
        if (index ==0) {
            if (self.completion) {
                self.completion();
            }
        }
    }];
}

#pragma mark ---Public----
#pragma mark ---显示添加按钮--
- (void)show {

    //定时器控制每个按钮弹出的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popupBtn) userInfo:nil repeats:YES];
}
#pragma mark ---按钮点击事件--
- (void)buttonAction:(TDButton*)button {
    NSInteger index = button.tag;
    if ([self.delegate respondsToSelector:@selector(addAnimateViewButton:andIndex:)]) {
        [self.delegate addAnimateViewButton:button andIndex:index];
    }
}
#pragma mark ---关闭点击事件--
- (void)close:(void(^)())completion{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnDownVC) userInfo:nil repeats:YES];
    
    self.completion = ^{
        completion();
    };
}

#pragma mark ---getter---
-(NSMutableArray *)viewArray
{
    if (_viewArray ==nil) {
        
        _viewArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _viewArray;
}


@end

