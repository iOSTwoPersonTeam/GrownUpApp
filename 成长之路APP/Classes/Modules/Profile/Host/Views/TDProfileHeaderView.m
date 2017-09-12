//
//  TDProfileHeaderView.m
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDProfileHeaderView.h"

@interface TDProfileHeaderView ()

/*
 在刚刚新建类的`类扩展`中添加子控件属性（用`weak`声明，防止内存泄露）
 */
@property(nonatomic,weak) UIImageView *backImageView; //背景图片
@property (nonatomic,weak) UIView    *alphaView; //背景图片设置模糊效果
@property(nonatomic,weak) UIButton    *settingButton; //设置按钮
@property(nonatomic,weak) UIButton    *moreButton; //更多按钮
@property(nonatomic,weak) UIImageView *headerImageView;//头像
@property(nonatomic,weak) UILabel     *userNameLabel; //用户名称


@end

@implementation TDProfileHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
    
        [self configSubViews];
    }
 
    return self;
}

#pragma mark ---UI的添加--
- (void)configSubViews {
    [self backImageView];
    [self alphaView];
    [self settingButton];
    [self moreButton];
    [self headerImageView];
    [self userNameLabel];
}


#pragma mark --HTTP or Data
-(void)setDataModel:(TDUserModel *)dataModel
{

    if (dataModel.UCODE) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.ICON] placeholderImage:[UIImage imageNamed:@"find_radio_default"]];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.ICON] placeholderImage:[UIImage imageNamed:@"find_radio_default"]];
        self.userNameLabel.text =dataModel.USERNAME;
        
    }
    else {
        [self.backImageView setImage:[UIImage imageNamed:@"find_radio_default"]];
        [self.headerImageView setImage:[UIImage imageNamed:@"find_radio_default"]];
        self.userNameLabel.text =@"未登录";
    }

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat hspace = (self.frame.size.width - SCREEN_WIDTH) / 2.0f;
    CGFloat centx = self.frame.size.width / 2.0f;
    //背景视图
    self.backImageView.frame =CGRectMake(hspace, 0, SCREEN_WIDTH, self.frame.size.height);
    self.alphaView.frame = CGRectMake(hspace, 0, SCREEN_WIDTH, self.frame.size.height);
    //头像
    self.headerImageView.frame = CGRectMake(centx - 45.0, self.frame.size.height/3, 90, 90);
    //用户名称
    self.userNameLabel.frame =CGRectMake(CGRectGetMinX(self.headerImageView.frame), CGRectGetMaxY(self.headerImageView.frame)+10, 90, 30);
    
    //录音按钮
    self.moreButton.frame =CGRectMake(12 + hspace, self.headerImageView.frame.origin.y -60, 25, 25);
    //设置按钮
    self.settingButton.frame =CGRectMake(SCREEN_WIDTH-36 + hspace, CGRectGetMinY(self.moreButton.frame), 35, 35);

}


#pragma mark --private

/*
 * 头像点击事件
 */
-(void)clickheaderImage
{
    if (self.clickImageBlock) {
        self.clickImageBlock();
    }
}




#pragma mark --getter

/**
 *  背景图上方的一层蒙版
 */
- (UIView *)alphaView {
    if(!_alphaView) {
        UIView *alphaView = [[UIView alloc] init];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0.2f;
        [self addSubview:alphaView];
        _alphaView =alphaView;
    }
    return _alphaView;
}

/**
 *  后方的图片视图
 */
-(UIImageView *)backImageView
{
    if (!_backImageView) {
     
        UIImageView *backImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_radio_default"]];
        [self addSubview:backImageView];
        backImageView.backgroundColor =[UIColor orangeColor];
        _backImageView =backImageView;
    }
    return _backImageView;
}

/*
 *  设置按钮
 */
-(UIButton *)settingButton
{
    if (!_settingButton) {
        
        UIButton *settingButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [settingButton setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [self addSubview:settingButton];
        _settingButton =settingButton;
    }
    return _settingButton;
}

/*
 * 更多按钮
 */
-(UIButton *)moreButton
{
    if (!_moreButton) {
        UIButton *moreButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setImage:[UIImage imageNamed:@"邮箱白色"] forState:UIControlStateNormal];
        [self addSubview:moreButton];
        _moreButton =moreButton;
    }
    return _moreButton;
}

/*
 * 头像
 */
-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
       UIImageView *headerImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_radio_default"]];
        headerImageView.layer.masksToBounds =YES;
        headerImageView.layer.cornerRadius = 45.0f;
        headerImageView.layer.borderColor = [UIColor colorWithRed:0.76f green:0.69f blue:0.65f alpha:1.00f].CGColor;
        headerImageView.layer.borderWidth = 2.0f;
        headerImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        headerImageView.layer.shouldRasterize = YES;
        [self addSubview:headerImageView];
        _headerImageView =headerImageView;
        headerImageView.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickheaderImage)];
        [headerImageView addGestureRecognizer:tap];
        
    }
    return _headerImageView;
}

-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        UILabel *userNameLabel =[[UILabel alloc] init];
        userNameLabel.font =[UIFont systemFontOfSize:14];
        userNameLabel.textColor =[UIColor blackColor];
        userNameLabel.textAlignment =NSTextAlignmentCenter;
        userNameLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:userNameLabel];
        userNameLabel.userInteractionEnabled =YES;
        _userNameLabel =userNameLabel;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickheaderImage)];
        [userNameLabel addGestureRecognizer:tap];
    }
    return _userNameLabel;
}




@end








