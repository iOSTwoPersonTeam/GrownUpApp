//
//  TDRegisterViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRegisterViewController.h"
#import "TDRegisterView.h"

@interface TDRegisterViewController ()<MZTimerLabelDelegate>

@property(nonatomic, strong) TDRegisterView *registerView; //注册部分View
@property(nonatomic, strong) MZTimerLabel *timer;

@end

@implementation TDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"新用户注册"];
    
    [self.view addSubview:self.registerView];
}



#pragma mark THHP--数据请求

//获取验证码
- (void)getValidationCode:(UIButton*)sender WithPhone:(NSString *)phoneText
{
    
    sender.enabled = NO;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(sender) weakSender = sender;

    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *urlString =[NSString stringWithFormat:@"%@%@",REQUEST_URL,@"common/getMobileValidatecode.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:phoneText forKey:@"mobile"];
    [dic setObject:@"0" forKey:@"opttype"];
    
    [manager POSTDataWithURL:urlString parameters:dic succeed:^(id responseObject) {
        //成功
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            [MBProgressHUD showMessage:@"发送成功，请注意查收短信"];

            weakSelf.timer.timeLabel = sender.titleLabel;
            [weakSelf.timer setCountDownTime:90];
            [weakSelf.timer startWithEndingBlock:^(NSTimeInterval countTime) {
                weakSender.enabled = YES;
                [weakSender setTitle:@"重新发送" forState:UIControlStateNormal];
            }];
        }
        else if ([[responseObject objectForKey:@"code"] isEqualToString:@"302"]) {
            [MBProgressHUD showMessage:@"单日获取次数已超过5次"];
        }
        else {
            [MBProgressHUD showMessage:@"发送失败"];
            DLog(@"返回Code：%@", [responseObject objectForKey:@"code"]);

            weakSender.enabled = YES;
        }
    } failure:^(NSError *error) {
        
        
        [MBProgressHUD showMessage:@"发送失败"];
        
        weakSender.enabled = YES;
    }];
            
}

//注册
- (void)registerUser:(NSString *)userPhone WithVerification:(NSString *)verificationText WIthPassword:(NSString *)passwordText
{

    if (![userPhone validateMobile]) {
        [MBProgressHUD showMessage:@"请填写正确格式的手机号"];
        return;
    }
    
    if (verificationText.length !=6 ) {
        [MBProgressHUD showMessage:@"请填写正确格式的验证码"];
        return;
    }
    
    if (passwordText.length < 6 || passwordText.length > 16) {
        [MBProgressHUD showMessage:@"请填写正确格式的密码"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;

    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *urlString =[NSString stringWithFormat:@"%@%@",REQUEST_URL,@"members/member_register.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:userPhone forKey:@"mobile"];
    [dic setObject:passwordText forKey:@"password"];
    [dic setObject:@"" forKey:@"regip"];
    [manager POSTDataWithURL:urlString parameters:dic succeed:^(id responseObject) {
        //注册成功
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            
            [MBProgressHUD showMessage:@"注册成功,快去登录并完善个人信息吧"];
        }
        else if ([[responseObject objectForKey:@"code"] isEqualToString:@"606"]){
        
            [MBProgressHUD showMessage:@"手机号已存在"];
        }
        else{
        
            [MBProgressHUD showMessage:@"注册失败"];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showMessage:@"注册失败"];
    }];
    
}


#pragma mark MZTimerDelegate

- (NSString *)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    return [NSString stringWithFormat:@"%luS", (unsigned long)time];
}




#pragma mark --getter
//注册view
-(TDRegisterView *)registerView
{
    if (!_registerView) {
        _registerView =[[TDRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _registerView.backgroundColor =[UIColor clearColor];
        __weak typeof(self) unself =self;
        //验证码
        _registerView.verificationBlock = ^(NSString *phoneText,UIButton *sender) {
          
            [unself getValidationCode:sender WithPhone:phoneText];
        };
        //注册
        _registerView.registerBlock = ^(NSString *userText, NSString *verificationText, NSString *passwordText) {
          
            [unself registerUser:userText WithVerification:verificationText WIthPassword:passwordText];
        };
        
    }

    return _registerView;
}

-(MZTimerLabel *)timer
{
    if (!_timer) {
        _timer =[[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeTimer];
        _timer.resetTimerAfterFinish =YES;
        _timer.delegate =self;
        
    }
    
    return _timer;
}









@end









