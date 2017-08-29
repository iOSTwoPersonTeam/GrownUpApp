//
//  TDMessageViewController.m
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDMessageViewController.h"
#import "TDMessageDetailViewController.h"

@interface TDMessageViewController ()

@end

@implementation TDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor redColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TDMessageDetailViewController *VC =[[TDMessageDetailViewController alloc] init];
    VC.title =@"消息详情";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
