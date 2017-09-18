//
//  TDShoppingViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDShoppingViewController.h"
#import "TDGoodsOrderViewController.h"

@interface TDShoppingViewController ()

@end

@implementation TDShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TDGoodsOrderViewController *Vc =[[TDGoodsOrderViewController alloc] init];
    [self.navigationController pushViewController:Vc animated:YES];

}




@end
