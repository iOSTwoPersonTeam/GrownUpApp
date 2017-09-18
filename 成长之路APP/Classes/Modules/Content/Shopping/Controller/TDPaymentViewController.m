//
//  TDPaymentViewController.m
//  成长之路APP
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPaymentViewController.h"
#import "TDWXPayManager.h"
#import "TDPaymentStatusViewController.h"

@interface TDPaymentViewController ()

@property(nonatomic, strong)UIButton *paymentButton;

@end

@implementation TDPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"支付订单";
    [self.view addSubview:self.paymentButton];
    
}


#pragma mark --Private--
//确认支付点击事件
-(void)clickMakeSurePay
{
    NSLog(@"确认支付-----");
//    [self getPayOrderBackgroundServer]; //请求后台接口
    
//    [self getPayOrderWeichatServer]; //直接请求微信服务器
    
    TDPaymentStatusViewController *vc =[[TDPaymentStatusViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
        vc.statusType =NO;
    
}

#pragma makr ---直接请求微信服务器获取数据--
-(void)getPayOrderWeichatServer
{
    //微信支付
    NSString *xmlstr =[[TDWXPayManager sharedManager] get_payParametersSetTradeTitle:@"李宁跑鞋" total_fee:@"0.01"];
    [[TDWXPayManager sharedManager] get_requestType:wxPay withXml:xmlstr backResp:^(BaseResp *backResp) {
        
        NSLog(@"%@----",backResp);
    } backCode:^(NSString *backCode) {
        NSLog(@"%@---",backCode);
        if ([backCode isEqualToString:@"支付成功"]) {
            [self getPayStatusDate];
        }
        
    } return_ErrorCode:^(NSString *return_msg, NSString *err_code, NSString *err_code_des) {
        
        NSLog(@"%@---%@----%@",return_msg,err_code,err_code_des);
    } backTrade_stateMsg:^(NSString *backTrade_stateMsg, NSString *backTrade_state){
        
    }];

}

-(void)getPayStatusDate
{
    //微信支付结果查询(这里传入的订单号 必须是已经支付过真实存在的)
    NSString *xmlStr =[[TDWXPayManager sharedManager] query_payParametersSetOrderNO:@"20170916175312167"];
    [[TDWXPayManager sharedManager] get_requestType:wxOrderquery withXml:xmlStr backResp:^(BaseResp *backResp) {
        NSLog(@"%@----",backResp);
    } backCode:^(NSString *backCode) {
        NSLog(@"%@---",backCode);
    } return_ErrorCode:^(NSString *return_msg, NSString *err_code, NSString *err_code_des) {
        NSLog(@"%@---%@----%@",return_msg,err_code,err_code_des);
    } backTrade_stateMsg:^(NSString *backTrade_stateMsg, NSString *backTrade_state) {
        NSLog(@"%@---%@----",backTrade_stateMsg,backTrade_state);
        TDPaymentStatusViewController *vc =[[TDPaymentStatusViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        if ([backTrade_stateMsg isEqualToString:@"支付成功"]) {
            vc.statusType =YES;
            
        } else if ([backTrade_stateMsg containsString:@"支付失败"]){
            vc.statusType =NO;
        }
        
    }];
}




#pragma mark ---通过后台服务器请求接口--
/*
- (void)getPayOrderBackgroundServer
{
    
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString stringWithFormat:@"http://apitest.51negoo.com/%@",@"wx/weixinPay.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"8dbaa0353f6d11e6b99b00163e001341" forKey:@"ucode"];
    [dic setObject:self.orderId forKey:@"order_id"];
    [manager GETDataWithURL:url parameters:dic succeed:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseObject[@"data"];
            if ([dic[@"result_code"] isEqualToString:@"SUCCESS"]) {
                [self wxpay:dic[@"sign"] andPartnerId:dic[@"mch_id"] andprepayId:dic[@"prepay_id"] andnonceStr:dic[@"nonce_str"] andTimeStamp:(UInt32)[dic[@"timestamp"] intValue]];
                NSLog(@"支付数据获取成功----");
            }
            
        }
        else {
            [MBProgressHUD showMessage:@"获取支付信息失败"];
            NSLog(@"支付数据获取成失败----");
        }

    } failure:^(NSError *error) {

        DLog(@"error: %@", error)
    }];

}

- (void)wxpay:(NSString*)sign andPartnerId:(NSString *)partnerID andprepayId:(NSString *)prepayId andnonceStr:(NSString *)nonceStr andTimeStamp:(UInt32)timestamp
{
    PayReq *payRequest = [[PayReq alloc] init];
    payRequest.partnerId = partnerID;
    payRequest.prepayId= prepayId;
    payRequest.package = @"Sign=WXPay";
    payRequest.nonceStr= nonceStr;
    payRequest.timeStamp= timestamp;
    payRequest.sign = sign; //签名
    
    [WXApi sendReq:payRequest];
}
*/

#pragma mark ---Delegate---



#pragma mark --getter--
-(UIButton *)paymentButton
{
    if (!_paymentButton) {
        _paymentButton =[[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50 -64, SCREEN_WIDTH, 50)];
        [_paymentButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_paymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _paymentButton.backgroundColor =GlobalThemeColor;
        [_paymentButton addTarget:self action:@selector(clickMakeSurePay) forControlEvents:UIControlEventTouchUpInside];

    }
    return _paymentButton;
}







@end


