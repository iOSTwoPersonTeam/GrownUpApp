//
//  TDLoginViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDLoginViewController.h"
#import "TDPhoneLoginView.h"
#import "TDRegisterViewController.h"
#import "TDForgetPasswordViewController.h"
#import "LRTextField.h"
#import "TDRegisterView.h"
#import "TDThirdPartyLoginView.h"

@interface TDLoginViewController ()

@property(nonatomic, strong) TDPhoneLoginView *phoneLoginView; //手机登录注册部分View
@property(nonatomic, strong) TDThirdPartyLoginView *thirdPartyLoginView; //第三方登录部分View

@end

@implementation TDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.titleView =[UINavigationItem titleViewForTitle:@"登录"];
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem rightBarButtonItemWithImage:[UIImage imageNamed:@"分享"] highlighted:[UIImage imageNamed:@"分享"] target:self selector:@selector(clickShare)];
    
    [self.view addSubview:self.phoneLoginView];
    [self.view addSubview:self.thirdPartyLoginView];

}


#pragma mark HTTP --登录接口数据请求
- (void)getlogInDataWithUserText:(NSString *)userText  WithPasswordText:(NSString *)passwordtext
{
    if (![userText validateMobile]) {
        [MBProgressHUD showMessage:@"请填写正确格式的手机号"];
        return;
    }
    if (passwordtext.length < 6 || passwordtext.length > 16) {
        [MBProgressHUD showMessage:@"请填写正确格式的密码"];
        return;
    }
    
    //保存用户数据  用户数据本地存储
    [TDUserInfo saveUserInfo:@{@"USERNAME" :userText ,@"UCODE" :userText ,@"PASSWORD" :passwordtext}];
    if (self.loginSuccessHandler) {
        self.loginSuccessHandler();
    }
    [self rigisterAndLoginEaseChatwithUserName:[TDUserInfo getUser].UCODE withPassword:@"123456"];
    
    return;
    
    //接口请求用户数据暂时不用************
    __weak typeof(self) weakSelf = self;
    //初始化单例类
    TDBaseRequestApI *manager =[TDBaseRequestApI shareManager];
    //链接
    NSString *url =[NSString localizedStringWithFormat:@"%@%@",REQUEST_URL,@"members/memberLogin.do"];
    //参数
    NSMutableDictionary *dic =[manager appWithDicRequestSecurity];
    [dic setObject: userText forKey:@"username"];
    [dic setObject: passwordtext forKey:@"password"];
    //调用请求方法  POST请求
    [manager POSTDataWithURL:url parameters:dic succeed:^(id data) {
            NSLog(@"成功------%@",data);
            //登录成功
            if ([[data objectForKey:@"code"] isEqualToString:@"200"]) {
                
                [MBProgressHUD showMessage:@"成功!"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[data objectForKey:@"data"]];
                [dic setObject:[dic objectForKey:@"merchant_id"] forKey:@"merchantid"];
                //保存用户数据
                [TDUserInfo saveUserInfo:dic];
                
                if (weakSelf.loginSuccessHandler) {
                    weakSelf.loginSuccessHandler();
                }
                
            }
            else if ([[data objectForKey:@"code"] isEqualToString:@"608"]) {
                [MBProgressHUD showMessage:@"用户名密码不匹配"];
            }
            else if ([[data objectForKey:@"code"] isEqualToString:@"600"]) {
                [MBProgressHUD showMessage:@"用户已被禁用"];
            }
            else {
                [MBProgressHUD showMessage:@"登录失败"];
            }

        } failure:^(NSError *error) {
            NSLog(@"失败------%@",error);
            [MBProgressHUD showMessage:@"登录失败"];
        }];
}


#pragma mark ---private
//第三方分享点击事件
-(void)clickShare
{
    DLog(@"分享---");
    [[TDShareSDKTool shareManager] shareCustomUIWithContentURL:@"http://www.jianshu.com/p/e92afbf1ce79" andcontentTitle:@"标题" contentDescription:@"详情" contentImage:@"http://img5.imgtn.bdimg.com/it/u=4267222417,1017407570&fm=200&gp=0.jpg" success:^(NSDictionary *userData) {
        
        DLog(@"分享成功----%@",userData);
        
    } failure:^(NSError *error) {
        
        DLog(@"分享失败---%@",error);
    }];
}

//第三方登录方法
-(void)getUserInfoThirdLoginWithType:(SSDKPlatformType )platformType
{
    /*
     SSDKPlatformTypeWechat
     SSDKPlatformTypeQQ
     SSDKPlatformTypeSinaWeibo
     */
    __weak typeof(self)  weakSelf =self;
    [[TDShareSDKTool shareManager] getUserInfoThirdLoginWithType:platformType success:^(SSDKUser *user) {
        
        [MBProgressHUD showMessage:@"登录成功"];
        NSLog(@"uid=%@",user.uid);
        NSLog(@"%@",user.credential);
        NSLog(@"token=%@",user.credential.token);
        NSLog(@"昵称-----=%@",user.nickname);
        NSLog(@"头像----%@",user.icon);
        
        //保存用户数据
        [TDUserInfo saveUserInfo:@{@"USERNAME" :user.nickname ,@"ICON" :user.icon ,@"UCODE" :user.uid}];
        
        NSLog(@"%@------%@----",[TDUserInfo getUser].USERNAME,[TDUserInfo getUser].ICON);
        
        if (weakSelf.loginSuccessHandler) {
            weakSelf.loginSuccessHandler();
        }
        
        [weakSelf rigisterAndLoginEaseChatwithUserName:[TDUserInfo getUser].UCODE withPassword:@"123456"];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

//环信的登录注册方法
-(void)rigisterAndLoginEaseChatwithUserName:(NSString *)userName  withPassword:(NSString *)password
{
    __weak typeof([TDEaseChatManager shareManager])  weekeaseManager =[TDEaseChatManager shareManager];
    //注册环信
    [[TDEaseChatManager shareManager] setRegisterEaseChatWithUsername:userName password:password Succeed:^{
        //登录环信
        [weekeaseManager setLogInEaseChatWithUsername:userName password:password Succeed:^{
            NSLog(@"登录环信成功----");
            
        } Error:^(EMError *aError) {
            
            NSLog(@"登录环信失败---%@",aError);
        }];
        
    } Error:^(EMError *aError) {
        
        NSLog(@"注册环信失败--%@",aError);
        //登录环信
        [weekeaseManager setLogInEaseChatWithUsername:userName password:password Succeed:^{
            NSLog(@"登录环信成功----");
            
        } Error:^(EMError *aError) {
            
            NSLog(@"登录环信失败---%@",aError);
        }];
    }];
    
}

#pragma mark --getter
//手机号登录部分
-(TDPhoneLoginView *)phoneLoginView
{
    if (!_phoneLoginView) {
        _phoneLoginView =[[TDPhoneLoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
          __weak typeof(self) unself = self;
        _phoneLoginView.loginBlock = ^(NSString *userText, NSString *passwordtext) {
            //登录
            [unself getlogInDataWithUserText:userText  WithPasswordText:passwordtext];
        };
        _phoneLoginView.registerBlock = ^{
            //注册页面
            TDRegisterViewController *registerVC =[[TDRegisterViewController alloc] init];
            [unself.navigationController pushViewController:registerVC animated:YES];
        };
        _phoneLoginView.forgetPassword = ^{
            //忘记密码页面
            TDForgetPasswordViewController *forgetPasswordVC =[[TDForgetPasswordViewController alloc] init];
            [unself.navigationController pushViewController:forgetPasswordVC animated:YES];
        };
    }
    return _phoneLoginView;
}

//第三方登录部分
-(TDThirdPartyLoginView *)thirdPartyLoginView
{
    if (!_thirdPartyLoginView) {
        _thirdPartyLoginView =[[TDThirdPartyLoginView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneLoginView.frame), SCREEN_WIDTH, SCREEN_HEIGHT -CGRectGetHeight(self.phoneLoginView.frame))];
        _thirdPartyLoginView.backgroundColor =[UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        _thirdPartyLoginView.clickweixinBlock = ^{
            
            DLog(@"微信-----");
            [weakSelf getUserInfoThirdLoginWithType:SSDKPlatformTypeWechat];
        };
        _thirdPartyLoginView.clickQQBlock = ^{
            
            DLog(@"QQ------");
        [weakSelf getUserInfoThirdLoginWithType:SSDKPlatformTypeQQ];

        };
        _thirdPartyLoginView.clickweiboBlock = ^{
            
            DLog(@"微博----");
          [weakSelf getUserInfoThirdLoginWithType:SSDKPlatformTypeSinaWeibo];
        };
        
    }
    return _thirdPartyLoginView;
}


@end













