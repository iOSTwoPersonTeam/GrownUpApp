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
#import "TDPaymentHeaderView.h"
#import "TDPaymentTableViewCell.h"

@interface TDPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIButton *paymentButton;
@property(nonatomic, strong)TDPaymentHeaderView *paymentHeaderView;
@property(nonatomic, strong)NSArray *imageArray; //图片
@property(nonatomic, strong)NSArray *titleArray; //标题
@property(nonatomic, strong)NSIndexPath *lastPath; //最后一个选中的row

@end

@implementation TDPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"支付订单";
    
    CGRect frame =self.tableView.frame;
    frame.size.height -=50+44;
    self.tableView.frame =frame;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView addSubview:self.paymentHeaderView];
    [self.view addSubview:self.paymentButton];
    
    //获取订单ID的接口(请求后台获取数据对接第三方支付时候必须要有订单ID
    [self getOrderDate];
}

#pragma mark --Private--
//确认支付点击事件
-(void)clickMakeSurePay
{
    NSLog(@"确认支付-----");
    
    /*
     * 注意这里在进行支付时候,
     * 1.微信采用的是直接对接微信服务器请求的方法(当然微信也可以对接后台请求数据)
     * 2.支付宝则是直接请去后台接口的方法
     */
    
    NSString *title = self.titleArray[_lastPath.section][_lastPath.row];
    if ([title containsString:@"微信支付"]) {
        
        DLog(@"微信支付-----");
        [self getPayOrderWeichatServer]; //微信直接请求微信服务器
//        [self getPayOrderbackgroundServer]; //微信支付调用后台接口获取数据
        
    } else if ([title containsString:@"支付宝支付"]){
        
        [self getpayOrderAliPayDate];  //支付宝支付调用后台接口获取数据
        DLog(@"支付宝支付-----");
    } else if ([title containsString:@"银联支付"]){
        
        DLog(@"银联支付-----");
    }
}


#pragma makr ---微信支付-直接请求微信服务器获取数据--
//微信支付接口
-(void)getPayOrderWeichatServer
{
    //微信支付
    NSString *xmlstr =[[TDWXPayManager sharedManager] get_payParametersSetTradeTitle:@"李宁跑鞋" total_fee:@"0.01"];
    [[TDWXPayManager sharedManager] get_requestType:wxPay withXml:xmlstr backResp:^(BaseResp *backResp) {
        
        NSLog(@"%@----",backResp);
    } backCode:^(NSString *backCode) {
        NSLog(@"%@---",backCode);
        if ([backCode isEqualToString:@"支付成功"]) {
            [self getWeiChatPayStatusDate];
        }
        
    } return_ErrorCode:^(NSString *return_msg, NSString *err_code, NSString *err_code_des) {
        
        NSLog(@"%@---%@----%@",return_msg,err_code,err_code_des);
        
    } backTrade_stateMsg:^(NSString *backTrade_stateMsg, NSString *backTrade_state){
        
    }];

}
//微信支付结果查询接口-
-(void)getWeiChatPayStatusDate
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

#pragma mark --获取订单ID的接口(请求后台获取数据对接第三方支付时候必须要有订单ID)---
-(void)getOrderDate
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString localizedStringWithFormat:@"http://apitest.51negoo.com/%@",@"shop/saveOrder.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"8dbaa0353f6d11e6b99b00163e001341" forKey:@"ucode"];
    [dic setObject:@"哈哈" forKey:@"name"];
    [dic setObject:@"15712884066" forKey:@"telephone"];
    [dic setObject:@"" forKey:@"remark"];
    [dic setObject:@"1608" forKey:@"sendclubsid"];
    [dic setObject:@"2254" forKey:@"receiveuserid"];
    [dic setObject:@"17" forKey:@"shopid"];
    [dic setObject:@"1" forKey:@"itemnum"];
    [dic setObject:@"北京" forKey:@"address"];
    [dic setObject:@"263dba8c391d11e7b37b00163e068794" forKey:@"saleucode"];
    [dic setObject:@"2" forKey:@"fromapp"];
    //调用请求方法  POST请求
    [manager POSTDataWithURL:url parameters:dic succeed:^(id responseObject) {
        NSLog(@"成功------%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            
            _orderId = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"ORDERID"]];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败------%@",error);
        
    }];
}

#pragma mark ---微信支付--请求后台接口获取数据
-(void)getPayOrderbackgroundServer
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString localizedStringWithFormat:@"http://apitest.51negoo.com/%@",@"wx/weixinPay.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"8dbaa0353f6d11e6b99b00163e001341" forKey:@"ucode"];
    [dic setObject:_orderId forKey:@"order_id"];
    //调用请求方法  POST请求
    [manager POSTDataWithURL:url parameters:dic succeed:^(id responseObject) {
        NSLog(@"成功------%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseObject[@"data"];

            if ([dic[@"return_code"] isEqualToString:@"SUCCESS"]) {
                
                //先获取微信支付参数
                //...
                TDUnifyPayManager *manager = [TDUnifyPayManager sharedManager];
                [manager wechatPayWithAppId:dic[@"appid"] partnerId:dic[@"mch_id"] prepayId:dic[@"prepay_id"] package:@"Sign=WXPay" nonceStr:dic[@"nonce_str"] timeStamp:dic[@"timestamp"] sign:dic[@"sign"] respBlock:^(NSInteger resultCode, NSString *resultMsg) {
                    //处理支付结果
                    switch (resultCode) {
                        case 0:
                            NSLog(@"微信1支付成功-----");
                            break;
                        case -1:
                            NSLog(@"微信支付失败-----");
                            break;
                        case -2:
                            NSLog(@"微信支付取消-----");
                            break;
                        default:
                            break;
                    }
                    
                }];

            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败------%@",error);
        
    }];
    
}

#pragma mark ---支付宝支付直接调用接口---------------
-(void)getpayOrderAliPayDate
{
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString localizedStringWithFormat:@"http://apitest.51negoo.com/%@",@"ali/zfbPay.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:@"8dbaa0353f6d11e6b99b00163e001341" forKey:@"ucode"];
    [dic setObject:_orderId forKey:@"order_id"];
    //调用请求方法  POST请求
    [manager POSTDataWithURL:url parameters:dic succeed:^(id responseObject) {
        NSLog(@"成功------%@",responseObject);
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseObject[@"data"];
            
            //先获取支付宝支付参数
            //...
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"tidoo";
            TDUnifyPayManager *manager = [TDUnifyPayManager sharedManager];
            [manager aliPayOrder:dic[@"body"] scheme:appScheme respBlock:^(NSInteger respCode, NSString *respMsg) {
                
                //处理支付结果
                switch (respCode) {
                    case 0:
                        NSLog(@"支付宝1支付成功----");
                        break;
                    case -1:
                        NSLog(@"支付宝1支付失败-----");
                        break;
                    case -2:
                        NSLog(@"支付宝1支付取消-----");
                        break;
                    default:
                        break;
                }
                
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败------%@",error);
        
    }];

}



#pragma mark ---银联支付----




#pragma mark ---Delegate---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.titleArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    TDPaymentTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[TDPaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    [cell setTitle:self.titleArray[indexPath.section][indexPath.row] withImageShow:self.imageArray[indexPath.section][indexPath.row]];
    NSInteger row = [indexPath row];
    NSInteger oldRow = [_lastPath row];
    if (row == oldRow && _lastPath!=nil) {
        cell.selectImageView.highlighted =YES;
    }else{
        cell.selectImageView.highlighted =NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //这里最好不要声明int类型的，个人建议
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = (self .lastPath !=nil) ?[self .lastPath row]:-1;
    if (newRow != oldRow || indexPath.section !=self.lastPath.section) {
        TDPaymentTableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.selectImageView.highlighted =YES;
        TDPaymentTableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath];
        oldCell.selectImageView.highlighted =NO;
        self .lastPath = indexPath;
    }
}


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

-(TDPaymentHeaderView *)paymentHeaderView
{
    if (!_paymentHeaderView) {
        _paymentHeaderView =[[TDPaymentHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3 +10)];
        _paymentHeaderView.backgroundColor =[UIColor whiteColor];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_paymentHeaderView.frame))];
        self.tableView.tableHeaderView =_paymentHeaderView;
    }
    return _paymentHeaderView;
}

-(NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray =@[@[@"微信支付"],
                       @[@"支付宝支付",@"银联支付"]];
    }
    return _imageArray;
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray =@[@[@"微信支付"],
                       @[@"支付宝支付",@"银联支付(暂不支持)"]];
    }
    return _titleArray;
}


@end





