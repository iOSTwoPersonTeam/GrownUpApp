//
//  TDRegisterView.m
//  成长之路APP
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRegisterView.h"
#import "LRTextField.h"
#import <MZTimerLabel/MZTimerLabel.h>

@interface TDRegisterView ()<MZTimerLabelDelegate>

@property(nonatomic, weak) UIImageView *userImageView; //用户图标
@property(nonatomic, weak) LRTextField *userTextField; //用户手机号
@property(nonatomic, weak) UIImageView *verificationImageView; //验证码图标
@property(nonatomic, weak) LRTextField *verificationTextField; //验证码输入框
@property(nonatomic, weak) UIButton *verificationCodeButton; //获取验证码按钮
@property(nonatomic, weak) UIImageView *passwordImageView; //密码图标
@property(nonatomic, weak) LRTextField *passwordtextField; //密码输入框
@property(nonatomic, weak) UIButton *registerButton; //注册按钮
@property(nonatomic, weak) UILabel *lineLabelOne; //实线1
@property(nonatomic, weak) UILabel *lineLabelTwo; //实线2
@property(nonatomic, weak) UILabel *lineLabelThree; //实线3
@property(nonatomic, weak) MZTimerLabel *timer; //计时器


@end

@implementation TDRegisterView

-(instancetype)init
{
    self =[super init];
    if (self) {
        
        [self configSubViews];
    }

    return self;
}

#pragma mark ---UI的添加--
- (void)configSubViews {
    
    [self userImageView];
    [self userTextField];
    [self verificationImageView];
    [self verificationTextField];
    [self verificationCodeButton];
    [self passwordImageView];
    [self passwordtextField];
    [self registerButton];
    [self lineLabelOne];
    [self lineLabelTwo];
    [self lineLabelThree];
    [self timer];

}


-(void)layoutSubviews
{
    [super  layoutSubviews];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@80);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(10);
        make.top.equalTo(self.userImageView.mas_top);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@20);
    }];
    
    [self.lineLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTextField.mas_left);
        make.top.equalTo(self.userTextField.mas_bottom).offset(10);
        make.width.equalTo(self.userTextField.mas_width);
        make.height.equalTo(@1);
    }];

    [self.verificationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.lineLabelOne.mas_bottom).offset(20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [self.verificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTextField.mas_left);
        make.top.equalTo(self.verificationImageView.mas_top);
        make.width.equalTo(self.userTextField.mas_width);
        make.height.equalTo(@20);
    }];

    [self.verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.verificationTextField.mas_right);
        make.top.equalTo(self.verificationTextField.mas_top);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
    
    [self.lineLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verificationTextField.mas_left);
        make.top.equalTo(self.verificationTextField.mas_bottom).offset(10);
        make.width.equalTo(self.verificationTextField.mas_width);
        make.height.equalTo(@1);
    }];
    
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.lineLabelTwo.mas_bottom).offset(20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [self.passwordtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordImageView.mas_right).offset(10);
        make.top.equalTo(self.passwordImageView.mas_top);
        make.width.equalTo(self.userTextField.mas_width);
        make.height.equalTo(@20);
    }];

    [self.lineLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordtextField.mas_left);
        make.top.equalTo(self.passwordtextField.mas_bottom).offset(10);
        make.width.equalTo(self.passwordtextField.mas_width);
        make.height.equalTo(@1);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.lineLabelThree.mas_bottom).offset(40);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@40);
    }];

}


#pragma mark -
#pragma mark MZTimerDelegate

- (NSString *)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    return [NSString stringWithFormat:@"%luS", (unsigned long)time];
}



#pragma mark ---private

//验证码按钮点击事件
-(void)clickSendCode:(UIButton *)sender
{
//    self.timer.timeLabel = sender.titleLabel;
//    [self.timer setCountDownTime:90];
//    __weak typeof(sender) weekSender =sender;
//    [self.timer startWithEndingBlock:^(NSTimeInterval countTime) {
//        weekSender.enabled = YES;
//        [weekSender setTitle:@"重新发送" forState:UIControlStateNormal];
//    }];
    
    if (![_userTextField.rawText validateMobile]) {
        [MBProgressHUD showMessage:@"请填写正确格式的手机号"];
        return;
    }
    
    if (self.verificationBlock) {
        self.verificationBlock(_userTextField.rawText ,sender);
    }

}

//注册按钮
-(void)clickRegister
{
    [_userTextField resignFirstResponder];
    [_verificationTextField resignFirstResponder];
    [_passwordtextField resignFirstResponder];
    if (self.registerBlock) {
        
        self.registerBlock(_userTextField.rawText, _verificationTextField.rawText, _passwordtextField.rawText);
    }
    

}



#pragma mark ---getter

-(UIImageView *)userImageView
{
    if (!_userImageView) {
        UIImageView *userImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机号"]];
        userImageView.backgroundColor =[UIColor clearColor];
        [self addSubview:userImageView];
        _userImageView =userImageView;
    }
    return _userImageView;
}

-(LRTextField *)userTextField
{
    if (!_userTextField) {
        LRTextField *userTextField =[[LRTextField alloc] init];
        userTextField.style =LRTextFieldStylePhone;
        userTextField.returnKeyType = UIReturnKeyDone;
        userTextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        userTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        userTextField.borderStyle = UITextBorderStyleNone;
        [userTextField setFont:[UIFont systemFontOfSize:16]];
        userTextField.textColor = [UIColor lightGrayColor];
        userTextField.floatingLabelHeight =15;
        [self addSubview:userTextField];
        _userTextField =userTextField;
    }

    return _userTextField;
}


-(UIImageView *)verificationImageView
{
    if (!_verificationImageView) {
        UIImageView *verificationImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证"]];
        verificationImageView.backgroundColor =[UIColor clearColor];
        [self addSubview:verificationImageView];
        _verificationImageView =verificationImageView;
    }
    return _verificationImageView;
}

-(LRTextField *)verificationTextField
{
    if (!_verificationTextField) {
        LRTextField *verificationTextField =[[LRTextField alloc] init];
        verificationTextField.style =LRTextFieldStyleNone;
        verificationTextField.returnKeyType = UIReturnKeyDone;
        verificationTextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        verificationTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        verificationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        verificationTextField.borderStyle = UITextBorderStyleNone;
        [_verificationTextField setFont:[UIFont systemFontOfSize:16]];
        verificationTextField.textColor = [UIColor lightGrayColor];
        verificationTextField.floatingLabelHeight =15;
        [self addSubview:verificationTextField];
        _verificationTextField =verificationTextField;
        verificationTextField.placeholder =@"请输入验证码";
        
    }
    return _verificationTextField;
}

-(UIButton *)verificationCodeButton
{
    if (!_verificationCodeButton) {
        
        UIButton *verificationCodeButton =[[UIButton alloc] init];
        [verificationCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [verificationCodeButton setTitleColor:GlobalThemeColor forState:UIControlStateNormal];
        verificationCodeButton.titleLabel.font =[UIFont systemFontOfSize:15];
        verificationCodeButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [verificationCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [verificationCodeButton addTarget:self action:@selector(clickSendCode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:verificationCodeButton];
        _verificationCodeButton =verificationCodeButton;
    }
    return _verificationCodeButton;
}


-(UIImageView *)passwordImageView
{
    if (!_passwordImageView) {
       UIImageView *passwordImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
        passwordImageView.backgroundColor=[UIColor clearColor];
        [self addSubview:passwordImageView];
        _passwordImageView =passwordImageView;
    }
  
    return _passwordImageView;
}

-(LRTextField *)passwordtextField
{
    if (!_passwordtextField) {
        
       LRTextField *passwordtextField =[[LRTextField alloc] init];
        passwordtextField.style =LRTextFieldStylePassword;
        passwordtextField.returnKeyType = UIReturnKeyDone;
        passwordtextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        passwordtextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        passwordtextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        passwordtextField.borderStyle = UITextBorderStyleNone;
        [passwordtextField setFont:[UIFont systemFontOfSize:16]];
        passwordtextField.textColor = [UIColor lightGrayColor];
        passwordtextField.floatingLabelHeight =15;
        [self addSubview:passwordtextField];
        _passwordtextField =passwordtextField;
        passwordtextField.placeholder =@"请输入密码";
    }
    return _passwordtextField;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        
       UIButton *registerButton =[[UIButton alloc] init];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        registerButton.titleLabel.font =[UIFont systemFontOfSize:20];
        registerButton.backgroundColor =GlobalThemeColor;
        registerButton.layer.masksToBounds =YES;
        registerButton.layer.cornerRadius =3.0;
        [registerButton addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registerButton];
        _registerButton =registerButton;
    }

    return _registerButton;
}

-(UILabel *)lineLabelOne
{
    if (!_lineLabelOne) {
       UILabel *lineLabelOne =[[UILabel alloc] init];
        lineLabelOne.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:lineLabelOne];
        _lineLabelOne =lineLabelOne;
    }
    return _lineLabelOne;
}

-(UILabel *)lineLabelTwo
{
    if (!_lineLabelTwo) {
       UILabel *lineLabelTwo =[[UILabel alloc] init];
        lineLabelTwo.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:lineLabelTwo];
        _lineLabelTwo =lineLabelTwo;
    }
    return _lineLabelTwo;
}

-(UILabel *)lineLabelThree
{
    if (!_lineLabelThree) {
        UILabel *lineLabelThree =[[UILabel alloc] init];
        lineLabelThree.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:lineLabelThree];
        _lineLabelThree =lineLabelThree;
    }
    return _lineLabelThree;
}

-(MZTimerLabel *)timer
{
    if (!_timer) {
       MZTimerLabel *timer =[[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeTimer];
        timer.resetTimerAfterFinish =YES;
        timer.delegate =self;
        _timer =timer;
    }
  
    return _timer;
}



@end








