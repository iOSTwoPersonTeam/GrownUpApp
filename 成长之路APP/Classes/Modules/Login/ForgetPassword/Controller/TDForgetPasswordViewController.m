//
//  TDForgetPasswordViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDForgetPasswordViewController.h"
#import "TDForgetPasswordView.h"


@interface TDForgetPasswordViewController ()<MZTimerLabelDelegate>

@property(nonatomic, strong) TDForgetPasswordView *forgetPasswordView; //忘记密码部分View
@property(nonatomic, strong) MZTimerLabel *timer; //定时器

@property(nonatomic, assign) long validationCode; //验证码

@end

@implementation TDForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"忘记密码"];
    
    [self.view addSubview:self.forgetPasswordView];
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
            
          _validationCode = [[[responseObject objectForKey:@"data"] objectForKey:@"CODE"] longLongValue];
            
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
            
            weakSelf.timer.timeLabel = sender.titleLabel;
            [weakSelf.timer setCountDownTime:90];
            [weakSelf.timer startWithEndingBlock:^(NSTimeInterval countTime) {
                weakSender.enabled = YES;
                [weakSender setTitle:@"重新发送" forState:UIControlStateNormal];
            }];
            
            [MBProgressHUD showMessage:@"发送失败"];
            DLog(@"返回Code：%@", [responseObject objectForKey:@"code"]);
            
            weakSender.enabled = YES;
        }
    } failure:^(NSError *error) {
        
        
        [MBProgressHUD showMessage:@"发送失败"];
        
        weakSender.enabled = YES;
    }];
    
}

//忘记密码
- (void)forgetPassWordUser:(NSString *)userPhone WithVerification:(NSString *)verificationText WIthPassword:(NSString *)passwordText
{

    if (_validationCode <= 0 || [verificationText longLongValue] != _validationCode) {
        [MBProgressHUD showMessage:@"验证码错误"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *urlString =[NSString stringWithFormat:@"%@%@",REQUEST_URL,@"members/forgetPassword.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject:userPhone forKey:@"mobile"];
    [dic setObject:passwordText forKey:@"password"];
    [dic setObject:@"" forKey:@"regip"];
    [manager POSTDataWithURL:urlString parameters:dic succeed:^(id responseObject) {
        //注册成功
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"200"]) {
            
            [MBProgressHUD showMessage:@"修改成功,请登录"];
        }
        else if ([[responseObject objectForKey:@"code"] isEqualToString:@"605"]){
            
            [MBProgressHUD showMessage:@"手机号尚未注册"];
        }
        else if ([[responseObject objectForKey:@"code"] isEqualToString:@"600"]) {
            [MBProgressHUD showMessage:@"用户已被禁用"];
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

-(TDForgetPasswordView *)forgetPasswordView
{
    if (!_forgetPasswordView) {
        _forgetPasswordView =[[TDForgetPasswordView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _forgetPasswordView.backgroundColor =[UIColor clearColor];
        __weak typeof(self) unself =self;
        _forgetPasswordView.verificationBlock = ^(NSString *phoneText, UIButton *sender) {
            
            [unself getValidationCode:sender WithPhone:phoneText];
        };
        _forgetPasswordView.makeSureBlock = ^(NSString *userText, NSString *verificationText, NSString *passwordText) {
            
            [unself forgetPassWordUser:userText WithVerification:verificationText WIthPassword:passwordText];
        };
    }
    
    return _forgetPasswordView;
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




