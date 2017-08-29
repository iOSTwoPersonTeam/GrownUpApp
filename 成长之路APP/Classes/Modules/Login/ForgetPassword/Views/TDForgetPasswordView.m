//
//  TDForgetPasswordView.m
//  成长之路APP
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDForgetPasswordView.h"
#import "LRTextField.h"

@interface TDForgetPasswordView ()
@property(nonatomic, strong) UIImageView *userImageView; //用户图标
@property(nonatomic, strong) LRTextField *userTextField; //用户手机号
@property(nonatomic, strong) UIImageView *verificationImageView; //验证码图标
@property(nonatomic, strong) LRTextField *verificationTextField; //验证码输入框
@property(nonatomic, strong) UIButton *verificationCodeButton; //获取验证码按钮
@property(nonatomic, strong) UIImageView *passwordImageView; //密码图标
@property(nonatomic, strong) LRTextField *passwordtextField; //密码输入框

@property(nonatomic, strong) UIImageView *rePasswordImageView; //再次密码图标
@property(nonatomic, strong) LRTextField *rePasswordtextField; //再次密码输入框
@property(nonatomic, strong) UIButton *registerButton; //注册按钮
@property(nonatomic, strong) UILabel *lineLabelOne; //实线1
@property(nonatomic, strong) UILabel *lineLabelTwo; //实线2
@property(nonatomic, strong) UILabel *lineLabelThree; //实线3
@property(nonatomic, strong) UILabel *lineLabelFour; //实线4

@end

@implementation TDForgetPasswordView

-(instancetype)init
{
    self =[super init];
    
    return self;
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
    
    [self.rePasswordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.lineLabelThree.mas_bottom).offset(20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.rePasswordtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rePasswordImageView.mas_right).offset(10);
        make.top.equalTo(self.rePasswordImageView.mas_top);
        make.width.equalTo(self.userTextField.mas_width);
        make.height.equalTo(@20);
    }];
    
    [self.lineLabelFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rePasswordtextField.mas_left);
        make.top.equalTo(self.rePasswordtextField.mas_bottom).offset(10);
        make.width.equalTo(self.rePasswordtextField.mas_width);
        make.height.equalTo(@1);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.lineLabelFour.mas_bottom).offset(60);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@40);
    }];
    
}

#pragma mark --private

//验证码按钮点击事件
-(void)clickSendCode:(UIButton *)sender
{
    if (![_userTextField.rawText validateMobile]) {
        [MBProgressHUD showMessage:@"请填写正确格式的手机号"];
        return;
    }

    if (self.verificationBlock) {
        self.verificationBlock(_userTextField.rawText, sender);
    }
}

//确认按钮
-(void)clickMakeSure
{
    [_userTextField resignFirstResponder];
    [_verificationTextField resignFirstResponder];
    [_passwordtextField resignFirstResponder];
    [_rePasswordtextField resignFirstResponder];
    
    if (![_userTextField.rawText validateMobile]) {
        [MBProgressHUD showMessage:@"请填写正确格式的手机号"];
        return;
    }
    if (_verificationTextField.rawText.length !=6 ) {
        [MBProgressHUD showMessage:@"请填写正确格式的验证码"];
        return;
    }
    if (_passwordtextField.rawText.length < 6 || _passwordtextField.rawText.length > 16) {
        [MBProgressHUD showMessage:@"请填写正确格式的密码"];
        return;
    }
    
    if (_passwordtextField.rawText.length && _rePasswordtextField.rawText.length && ![_passwordtextField.rawText isEqualToString:_rePasswordtextField.rawText]) {
        [MBProgressHUD showMessage:@"两次输入的密码不一致"];
        return;
    }
    
    if (self.makeSureBlock) {
        
        self.makeSureBlock(_userTextField.rawText, _verificationTextField.rawText, _verificationTextField.rawText);
    }
    
}



#pragma mark --getter

-(UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手机号"]];
        _userImageView.backgroundColor =[UIColor clearColor];
        [self addSubview:_userImageView];
    }
    return _userImageView;
}

-(LRTextField *)userTextField
{
    if (!_userTextField) {
        _userTextField =[[LRTextField alloc] init];
        _userTextField.style =LRTextFieldStylePhone;
        _userTextField.returnKeyType = UIReturnKeyDone;
        _userTextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        _userTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        _userTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        _userTextField.borderStyle = UITextBorderStyleNone;
        [_userTextField setFont:[UIFont systemFontOfSize:16]];
        _userTextField.textColor = [UIColor lightGrayColor];
        _userTextField.floatingLabelHeight =15;
        [self addSubview:_userTextField];
    }
    
    return _userTextField;
}


-(UIImageView *)verificationImageView
{
    if (!_verificationImageView) {
        _verificationImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"验证"]];
        _verificationImageView.backgroundColor =[UIColor clearColor];
        [self addSubview:_verificationImageView];
    }
    return _verificationImageView;
}

-(LRTextField *)verificationTextField
{
    if (!_verificationTextField) {
        _verificationTextField =[[LRTextField alloc] init];
        _verificationTextField.style =LRTextFieldStylePhone;
        _verificationTextField.returnKeyType = UIReturnKeyDone;
        _verificationTextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        _verificationTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        _verificationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        _verificationTextField.borderStyle = UITextBorderStyleNone;
        [_verificationTextField setFont:[UIFont systemFontOfSize:16]];
        _verificationTextField.textColor = [UIColor lightGrayColor];
        _verificationTextField.floatingLabelHeight =15;
        [self addSubview:_verificationTextField];
        _verificationTextField.placeholder =@"请输入验证码";
    }
    return _verificationTextField;
}

-(UIButton *)verificationCodeButton
{
    if (!_verificationCodeButton) {
        
        _verificationCodeButton =[[UIButton alloc] init];
        [_verificationCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificationCodeButton setTitleColor:GlobalThemeColor forState:UIControlStateNormal];
        _verificationCodeButton.titleLabel.font =[UIFont systemFontOfSize:15];
        _verificationCodeButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [_verificationCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_verificationCodeButton addTarget:self action:@selector(clickSendCode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_verificationCodeButton];
    }
    return _verificationCodeButton;
}

-(UIImageView *)passwordImageView
{
    if (!_passwordImageView) {
        _passwordImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
        _passwordImageView.backgroundColor=[UIColor clearColor];
        [self addSubview:_passwordImageView];
    }
    
    return _passwordImageView;
}

-(LRTextField *)passwordtextField
{
    if (!_passwordtextField) {
        
        _passwordtextField =[[LRTextField alloc] init];
        _passwordtextField.style =LRTextFieldStylePassword;
        _passwordtextField.returnKeyType = UIReturnKeyDone;
        _passwordtextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        _passwordtextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        _passwordtextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        _passwordtextField.borderStyle = UITextBorderStyleNone;
        [_passwordtextField setFont:[UIFont systemFontOfSize:16]];
        _passwordtextField.textColor = [UIColor lightGrayColor];
        _passwordtextField.floatingLabelHeight =15;
        [self addSubview:_passwordtextField];
        _passwordtextField.placeholder =@"请输入密码";
    }
    return _passwordtextField;
}

-(UIImageView *)rePasswordImageView
{
    if (!_rePasswordImageView) {
        _rePasswordImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
        _rePasswordImageView.backgroundColor=[UIColor clearColor];
        [self addSubview:_rePasswordImageView];
    }
    
    return _rePasswordImageView;
}

-(LRTextField *)rePasswordtextField
{
    if (!_rePasswordtextField) {
        
        _rePasswordtextField =[[LRTextField alloc] init];
        _rePasswordtextField.style =LRTextFieldStylePassword;
        _rePasswordtextField.returnKeyType = UIReturnKeyDone;
        _rePasswordtextField.autocorrectionType = UITextAutocorrectionTypeNo;//禁用自动纠正
        _rePasswordtextField.clearButtonMode  = UITextFieldViewModeWhileEditing;//编辑时清除
        _rePasswordtextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//消除自动大小写
        _rePasswordtextField.borderStyle = UITextBorderStyleNone;
        [_rePasswordtextField setFont:[UIFont systemFontOfSize:16]];
        _rePasswordtextField.textColor = [UIColor lightGrayColor];
        _rePasswordtextField.floatingLabelHeight =15;
        [self addSubview:_rePasswordtextField];
        _rePasswordtextField.placeholder =@"请再次输入密码";
    }
    return _rePasswordtextField;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        
        _registerButton =[[UIButton alloc] init];
        [_registerButton setTitle:@"确定" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font =[UIFont systemFontOfSize:20];
        _registerButton.backgroundColor =GlobalThemeColor;
        _registerButton.layer.masksToBounds =YES;
        _registerButton.layer.cornerRadius =3.0;
        [_registerButton addTarget:self action:@selector(clickMakeSure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerButton];
    }
    
    return _registerButton;
}


-(UILabel *)lineLabelOne
{
    if (!_lineLabelOne) {
        _lineLabelOne =[[UILabel alloc] init];
        _lineLabelOne.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLabelOne];
    }
    return _lineLabelOne;
}

-(UILabel *)lineLabelTwo
{
    if (!_lineLabelTwo) {
        _lineLabelTwo =[[UILabel alloc] init];
        _lineLabelTwo.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLabelTwo];
    }
    return _lineLabelTwo;
}

-(UILabel *)lineLabelThree
{
    if (!_lineLabelThree) {
        _lineLabelThree =[[UILabel alloc] init];
        _lineLabelThree.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLabelThree];
    }
    return _lineLabelThree;
}

-(UILabel *)lineLabelFour
{
    if (!_lineLabelFour) {
        _lineLabelFour =[[UILabel alloc] init];
        _lineLabelFour.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:_lineLabelFour];
    }
    return _lineLabelFour;
}









@end








