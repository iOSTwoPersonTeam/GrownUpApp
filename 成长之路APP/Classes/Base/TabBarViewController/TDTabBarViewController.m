//
//  TDTabBarViewController.h
//  成长之路APP
//
//  Created by mac on 2017/7/20.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDTabBarViewController.h"

#define SCREENWIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark -  @implementation TDTabBarViewController

@interface TDTabBarViewController()<TabBarViewDelegate>
/**
 *  记录上次点击按钮的索引
 */
@property (nonatomic, assign) NSUInteger lastIndex;
@end


@implementation TDTabBarViewController

- (id)initWithTabBarSelectedImages:(NSMutableArray *)selected
                      normalImages:(NSMutableArray *)normal
                            titles:(NSMutableArray *)titles{
    if ([super init]) {
        
        self.tabBarView = [[TabBarView alloc]initWithItemSelectedImages:selected normalImages:normal titles:titles];
        self.tabBarView.backgroundColor = [UIColor whiteColor];
        self.tabBarView.delegate = self;
        [self.view addSubview:self.tabBarView];
        self.tabBarView.itemSelectedIndex = 0;
        
    }
    return self;
}

-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index{
    [self.tabBarView tabBarBadgeValue:value item:index];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tabBar removeFromSuperview];
}

#pragma mark - 初始化数据
-(void)setShowCenterItem:(BOOL)showCenterItem{
    _showCenterItem = showCenterItem;
    self.tabBarView.showCenter = _showCenterItem;
}
-(void)setCenterItemImage:(UIImage *)centerItemImage{
    _centerItemImage = centerItemImage;
    self.tabBarView.centerImage = centerItemImage;
}
-(void)setCenterItemTitle:(NSString *)centerItemTitle{
    _centerItemTitle = centerItemTitle;
    self.tabBarView.centerTitle = centerItemTitle;
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.tabBarView.textColor = _textColor;
}

-(void)setSelectedItem:(NSInteger)selectedItem{
    _selectedItem = selectedItem;
    self.selectedIndex = _selectedItem;
    self.tabBarView.itemSelectedIndex = _selectedItem;
}

-(void)setXm_centerViewController:(UIViewController *)xm_centerViewController{
    _xm_centerViewController = xm_centerViewController;
}




#pragma mark - TabBarViewDelegate
-(void)tabBarViewSelectedItem:(NSInteger)index{
    self.lastIndex = index;
    self.selectedIndex = index;
    if ([self.XMDelegate respondsToSelector:@selector(tabBarController:didSelectIndex:)]) {
        [self.XMDelegate tabBarController:self didSelectIndex:index];
    }
}
-(void)tabBarViewCenterItemClick:(UIButton *)button{
    if ([self.XMDelegate respondsToSelector:@selector(tabBarControllerdDidSelectCenter:)]) {
        [self.XMDelegate tabBarControllerdDidSelectCenter:self];
    }
    else {
        [self presentViewController:_xm_centerViewController animated:YES completion:nil];
    }
}
#pragma mark - 共有方法
-(void)showCenterViewController:(BOOL)show animated:(BOOL)animated{
    
    if (show) {
        [self presentViewController:_xm_centerViewController animated:animated completion:nil];
        return;
    }
    [self xmTabBarHidden:NO animated:YES];
    [self dismissViewControllerAnimated:animated completion:nil];
}

-(void)xmTabBarHidden:(BOOL)hidden animated:(BOOL)animated{
    
    NSTimeInterval duration;
    
    animated == YES?duration = 0.24:0;
    
    [UIView animateWithDuration:duration animations:^{
        if (hidden) {
            self.tabBarView.frame = CGRectMake(0, SCREENHEIGHT + 50, SCREENWIDTH, 49);
        }else{
            self.tabBarView.frame = CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49);
        }
    } completion:^(BOOL finished) {
        
    }];
}


@end





#pragma mark - /////////////// TabBarView ///////////////
#pragma mark

@interface TabBarView ()
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, strong) NSMutableArray * titleLabels;


@property (nonatomic, strong) NSMutableArray * unSelectedImages;
@property (nonatomic, strong) NSMutableArray * selectedImages;
@property (nonatomic, strong) NSMutableArray * titles;

@end
@implementation TabBarView

-(id)initWithItemSelectedImages:(NSMutableArray *)selected
                   normalImages:(NSMutableArray *)normal
                         titles:(NSMutableArray *)titles{
    if ([super init]) {
        self.frame = CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49);
        self.buttonArray = [NSMutableArray array];
        self.titleLabels = [NSMutableArray array];
        
        self.unSelectedImages = normal;
        self.selectedImages = selected;
        self.titles = titles;
        [self createUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
    }
    return self;
}

-(void)createUI{
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.line];
    
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.image = self.backgroundImage;
    [self addSubview:self.backgroundImageView];
    
    self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerButton];
    
    
    
    for (int i = 0; i < self.unSelectedImages.count; i ++) {
        
        XMButton * button = [XMButton xm_shareButton];
        [button setImage:self.unSelectedImages[i] forState:UIControlStateNormal];
        [button setImage:self.selectedImages[i] forState:UIControlStateSelected];
        
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        
        
    }
    
}

-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index{
    XMButton * button = self.buttonArray[index];
    button.badgeValue = value;
}


-(void)setItemSelectedIndex:(NSInteger)itemSelectedIndex{
    _itemSelectedIndex = itemSelectedIndex;
    for (XMButton * item in self.buttonArray) {
        item.selected = NO;
        if (item.tag == itemSelectedIndex)  item.selected = YES;
    }
}

-(void)setShowCenter:(BOOL)showCenter{
    _showCenter = showCenter;
}
-(void)setCenterImage:(UIImage *)centerImage{
    _centerImage = centerImage;
    [self.centerButton setImage:_centerImage forState:UIControlStateNormal];
    [self.centerButton setImageEdgeInsets:UIEdgeInsetsMake(0, 7.5, 15, 7.5)];
}
- (void)setCenterTitle:(NSString *)centerTitle{
    _centerTitle = centerTitle;
    [self.centerButton setTitle:centerTitle forState:UIControlStateNormal];
    [self.centerButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.centerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.centerButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [self.centerButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -130, 0, 0)];
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    for (XMButton * button in self.buttonArray) {
        [button setTitleColor:textColor forState:UIControlStateSelected];
    }
}

-(void)buttonClick:(XMButton *)button{
    for (XMButton * item in self.buttonArray) item.selected = NO;
    /**
     *  选中哪一个item将上面的badgeValue清零
     */
    [self tabBarBadgeValue:0 item:button.tag];
    
    button.selected = !button.selected;
    [self.delegate tabBarViewSelectedItem:button.tag];
}

-(void)centerButtonClick:(UIButton *)button{
    [self.delegate tabBarViewCenterItemClick:button];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    self.backgroundImageView.frame = CGRectMake(0, 0.5, self.frame.size.width, self.frame.size.height - 0.5);
    
    NSUInteger count = self.buttonArray.count%2 == 0 ? self.buttonArray.count:self.buttonArray.count+1;
    
    /** 中间按钮的宽高 */
    CGFloat centerButtonWH = 60;
    /** 普通按钮的高度 */
    CGFloat buttonHeight = 48.5;
    /** 普通按钮的宽度 */
    CGFloat buttonWidth = self.frame.size.width/count;
    CGFloat centerButtonX = (self.frame.size.width - centerButtonWH)*0.5;
    
    if (_showCenter) {
        self.centerButton.frame = CGRectMake(centerButtonX, self.frame.size.height - centerButtonWH, centerButtonWH, centerButtonWH);
        buttonWidth = (self.frame.size.width- centerButtonWH - 20)/count;
    }
    
    CGFloat buttonX = 0;
    
    for (int i = 0; i < self.buttonArray.count;i ++) {
        XMButton * button = self.buttonArray[i];
        if (_showCenter && button.tag == count/2) {
            buttonX += centerButtonWH + 20;
        }
        button.frame = CGRectMake(buttonX, 0.5, buttonWidth, buttonHeight);
        buttonX += buttonWidth;
    }
    
}

@end





/** 图标在上，文本在下按钮的图文间隔比例（0-1）*/
#define xm_buttonTopRadio 0.7

@interface XMButton ()
@property (nonatomic, strong) UILabel * badgeValueLabel;

@end

@implementation XMButton


+ (instancetype)xm_shareButton{
    
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.badgeValueLabel = [[UILabel alloc]init];
        self.badgeValueLabel.backgroundColor = [UIColor redColor];
        self.badgeValueLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeValueLabel.font = [UIFont systemFontOfSize:11];
        self.badgeValueLabel.textColor = [UIColor whiteColor];
        self.badgeValueLabel.layer.masksToBounds = YES;
        self.badgeValueLabel.layer.cornerRadius = 6.5;
        [self addSubview:self.badgeValueLabel];
        
    }
    return self;
}
-(void)setBadgeValue:(NSUInteger)badgeValue{
    _badgeValue = badgeValue;
    self.badgeValueLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_badgeValue];
}
- (void)alignmentTop{
    
    // 获得按钮的大小
    CGFloat xm_btnWidth = self.bounds.size.width;
    CGFloat xm_btnHeight = self.bounds.size.height;
    // 获得按钮中UILabel文本的大小
    CGFloat xm_labelWidth = self.titleLabel.bounds.size.width;
    CGFloat xm_labelHeight = self.titleLabel.bounds.size.height;
    // 获得按钮中image图标的大小
    CGFloat xm_imageWidth = 28;
    CGFloat xm_imageHeight = 28;
    
    
    /** 没有文字，返回普通按钮 */
    if (self.titleLabel.text == nil) return;
    
    
    /** 设置button上的图片或文字 */
    
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    xm_labelWidth = CGRectGetWidth(frame);
    xm_labelHeight = CGRectGetHeight(frame);
    
    CGFloat imageX = (xm_btnWidth - xm_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, xm_btnHeight * 0.5 - xm_imageHeight * xm_buttonTopRadio, xm_imageWidth, xm_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, xm_btnHeight * 0.5 + xm_labelHeight * xm_buttonTopRadio, xm_labelWidth, xm_labelHeight);
    
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
    
    
}

- (CGSize)sizeWithFont:(UIFont *)font string:(NSString *)text
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(self.frame.size.width * 0.35, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self alignmentTop];
    
    /** 设置badgeValue */
    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:12] string:self.badgeValueLabel.text];
    
    if (self.badgeValue == 0) {
        self.badgeValueLabel.frame = CGRectMake(self.frame.size.width*0.65, 3, 0, 0);
        return;
    }
    if (size.width < 10) size.width = 10;
    self.badgeValueLabel.frame = CGRectMake(self.frame.size.width*0.65, 3, size.width + 3, 13);
    
}

@end


