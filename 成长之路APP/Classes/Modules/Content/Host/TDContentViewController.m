//
//  TDContentViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDContentViewController.h"
#import "TDContentDetailViewController.h"

@interface TDContentViewController ()

@end

@implementation TDContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor yellowColor];

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TDContentDetailViewController *VC =[[TDContentDetailViewController alloc] init];
     VC.title =@"内容详情";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
