//
//  TDGoodsOrderViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDGoodsOrderViewController.h"
#import "TDPaymentViewController.h"

@interface TDGoodsOrderViewController ()

@property(nonatomic, strong)UILabel *AllMoneyLabel; //金额总数
@property(nonatomic, strong)UIButton *submitOrderButton; //提交订单

@end

@implementation TDGoodsOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"订单详情";
    [self.view addSubview:self.AllMoneyLabel]; //合计金额
    [self.view addSubview:self.submitOrderButton]; //提交订单按钮
}



#pragma mark --Private--
//点击提交订单--
-(void)clickSubmitOrder
{
    NSLog(@"提交订单---");
//    [self submitOrderData];  //调用后台下单接口
    
    TDPaymentViewController *Vc =[[TDPaymentViewController alloc] init];
    [self.navigationController pushViewController:Vc animated:YES];
}

#pragma mark ----提交订单接口(暂时不用)--
/*
-(void)submitOrderData
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString stringWithFormat:@"http://apitest.51negoo.com/%@",@"shop/saveOrder.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"8dbaa0353f6d11e6b99b00163e001341" forKey:@"ucode"];
    [dic setObject:@"哈哈" forKey:@"name"];
    [dic setObject:@"15712860200" forKey:@"telephone"];
    [dic setObject:@"" forKey:@"remark"];
    [dic setObject:@"1735" forKey:@"sendclubsid"];
    [dic setObject:@"2254" forKey:@"receiveuserid"];
    [dic setObject:@"11" forKey:@"shopid"];
    [dic setObject:@"1" forKey:@"itemnum"];
    [dic setObject:@"北京" forKey:@"address"];
    [dic setObject:@"0.01" forKey:@"amount"];
    [dic setObject:@"2" forKey:@"fromapp"];
    [manager POSTDataWithURL:url parameters:dic succeed:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            NSString *orderId =[NSString stringWithFormat:@"%@",responseObject[@"data"][@"ORDERID"]];
            TDPaymentViewController *Vc =[[TDPaymentViewController alloc] init];
            Vc.payMoney =@"0.08";
            Vc.shopName =@"李宁跑鞋";
            Vc.orderId = @"20170915115530112";
            [self.navigationController pushViewController:Vc animated:YES];
            
            NSLog(@"提交订单成功-----");
        }
    } failure:^(NSError *error) {
        
        NSLog(@"提交订单失败--%@",error);
        
    }];
}
*/

#pragma mark ---Delegate---



#pragma mark --getter--
-(UILabel *)AllMoneyLabel
{
    if (!_AllMoneyLabel) {

        _AllMoneyLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH-120, 50)];
        _AllMoneyLabel.text =[NSString stringWithFormat:@"合计:¥%@",@"0.01"];
        _AllMoneyLabel.font =[UIFont systemFontOfSize:15];
        _AllMoneyLabel.textAlignment =NSTextAlignmentRight;
        _AllMoneyLabel.backgroundColor =[UIColor whiteColor];
    }
    return _AllMoneyLabel;
}

-(UIButton *)submitOrderButton
{
    if (!_submitOrderButton) {
        _submitOrderButton =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AllMoneyLabel.frame), CGRectGetMinY(self.AllMoneyLabel.frame), 120, CGRectGetHeight(self.AllMoneyLabel.frame))];
        [_submitOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitOrderButton addTarget:self action:@selector(clickSubmitOrder) forControlEvents:UIControlEventTouchUpInside];
        _submitOrderButton.backgroundColor =GlobalThemeColor;
    }
    return _submitOrderButton;
}






@end



