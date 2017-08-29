//
//  TDAppIntroductionViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDAppIntroductionViewController.h"
#import "TDGuidePageHUD.h"

@interface TDAppIntroductionViewController ()

@end

@implementation TDAppIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the viewO(∩_∩)O.
    // 设置APP引导页
        self.view.backgroundColor =[UIColor whiteColor];
        // 静态引导页
        [self setStaticGuidePage];
        
        // 动态引导页
        //         [self setDynamicGuidePage];
        
        // 视频引导页
        //         [self setVideoGuidePage];
}


#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
    TDGuidePageHUD *guidePage = [[TDGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    __weak typeof(self) unself =self;
    guidePage.startButtonBlock = ^{
        
        if (unself.introductionFadedBlock) {
            unself.introductionFadedBlock();
        }
    };
    guidePage.slideInto = YES;
    [self.view addSubview:guidePage];
}

#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    TDGuidePageHUD *guidePage = [[TDGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    __weak typeof(self) unself =self;
    guidePage.startButtonBlock = ^{
        
        if (unself.introductionFadedBlock) {
            unself.introductionFadedBlock();
        }
    };
    guidePage.slideInto = YES;
    [self.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    TDGuidePageHUD *guidePage = [[TDGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    __weak typeof(self) unself =self;
    guidePage.startButtonBlock = ^{
        
        if (unself.introductionFadedBlock) {
            unself.introductionFadedBlock();
        }
    };
    [self.view addSubview:guidePage];
}



@end




