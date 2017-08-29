//
//  TDPhoneLoginView.m
//  成长之路APP
//
//  Created by mac on 2017/8/9.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDPhoneLoginView.h"
#import "LRTextField.h"

@interface TDPhoneLoginView ()

@property(nonatomic, weak) UIImageView *userImageView; //用户图标
@property(nonatomic, weak) LRTextField *userTextField; //手机号输入框
@property(nonatomic, weak) UILabel *linelabelOne; //实线1
@property(nonatomic, weak) UILabel *lineLabelTwo; //实线2
@property(nonatomic, weak) UIImageView *passwordImageView; //密码图标
@property(nonatomic, weak) LRTextField *passwordtextField; //密码输入框

@property(nonatomic, weak) UIButton *loginButton; //登录按钮
@property(nonatomic, weak) UIButton *registButton; //注册按钮
@property(nonatomic, weak) UIButton *forgetPasswordButton; //忘记密码按钮

@end

@implementation TDPhoneLoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
         
        [self configSubViews];
    }
    return self;
}

#pragma mark ---UI的添加--
- (void)configSubViews {
    
    [self userImageView];
    [self userTextField];
    [self linelabelOne];
    [self lineLabelTwo];
    [self passwordImageView];
    [self passwordtextField];
    [self loginButton];
    [self registButton];
    [self forgetPasswordButton];
}


-(void)layoutSubviews
{
   [super layoutSubviews];

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
    
    [self.linelabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.userTextField.mas_bottom).offset(10);
        make.right.equalTo(self.userTextField.mas_right);
        make.height.equalTo(@1);
    }];
    
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_left);
        make.top.equalTo(self.linelabelOne.mas_bottom).offset(20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [self.passwordtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTextField.mas_left);
        make.top.equalTo(self.passwordImageView.mas_top);
        make.width.equalTo(self.userTextField.mas_width);
        make.height.equalTo(@20);
    }];
    
    [self.lineLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordImageView.mas_left);
        make.top.equalTo(self.passwordtextField.mas_bottom).offset(10);
        make.right.equalTo(self.passwordtextField.mas_right);
        make.height.equalTo(@1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.lineLabelTwo.mas_bottom).offset(40);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@40);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginButton.mas_left);
        make.top.equalTo(self.loginButton.mas_bottom).offset(15);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
    }];
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginButton.mas_right);
        make.top.equalTo(self.registButton.mas_top);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    
}




#pragma mark ---private

//点击登录按钮
-(void)clickLogin
{
    [_userTextField resignFirstResponder];
    [_passwordtextField resignFirstResponder];
    
    if (self.loginBlock) {
        self.loginBlock(_userTextField.rawText, _passwordtextField.rawText);
    }

}


//注册点击事件
-(void)clickRegist
{
    if (self.registerBlock) {
        self.registerBlock();
    }

}

//忘记密码点击事件
-(void)clickForgetPassword
{
    if (self.forgetPassword) {
        
        self.forgetPassword();
    }

}







#pragma mark --getter

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
        [self addSubview:userTextField];
        _userTextField =userTextField;
        userTextField.floatingLabelHeight =15;
        //效验手机号是否合理
        [userTextField setValidationBlock:^NSDictionary *(LRTextField *textField, NSString *text) {
            
            if ([text validateMobile]) {
                return @{VALIDATION_INDICATOR_YES : @""};
            }
            return @{VALIDATION_INDICATOR_NO : @"手机号格式不正确"};
        }];
        
    }
    return _userTextField;
}

-(UILabel *)linelabelOne
{
    if (!_linelabelOne) {
        
        UILabel *linelabelOne =[[UILabel alloc] init];
        linelabelOne.backgroundColor =[UIColor lightGrayColor];
        [self addSubview:linelabelOne];
        _linelabelOne =linelabelOne;
    }
    return _linelabelOne;
}

-(UIImageView *)passwordImageView
{
    if (!_passwordImageView) {
        
        UIImageView *passwordImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
        passwordImageView.backgroundColor =[UIColor clearColor];
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
        passwordtextField.placeholder =@"请输入密码";
        passwordtextField.floatingLabelHeight =15;
        [self addSubview:passwordtextField];
        _passwordtextField =passwordtextField;
        //检查密码位数
        [passwordtextField setValidationBlock:^NSDictionary *(LRTextField *textField, NSString *text) {
            
            if (text.length < 6) {
                return @{VALIDATION_INDICATOR_NO : @"密码少于6位"};
            }
            else if (text.length > 16) {
                return @{VALIDATION_INDICATOR_NO : @"密码多于16位"};
            }
            
            return @{VALIDATION_INDICATOR_YES : @""};
        }];
        
    }
    return _passwordtextField;
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

-(UIButton *)loginButton
{
    if (!_loginButton) {
        
        UIButton *loginButton =[[UIButton alloc] init];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font =[UIFont systemFontOfSize:20];
        loginButton.backgroundColor =GlobalThemeColor;
        loginButton.layer.masksToBounds =YES;
        loginButton.layer.cornerRadius =3.0;
        [self addSubview:loginButton];
        _loginButton =loginButton;
        [loginButton addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}

-(UIButton *)registButton
{
    if (!_registButton) {
        
        UIButton *registButton =[[UIButton alloc] init];
        [registButton setTitle:@"手机号注册" forState:UIControlStateNormal];
        [registButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [registButton setTitleColor:GlobalThemeColor forState:UIControlStateHighlighted];
        registButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        registButton.titleLabel.font =GlobalFontSizeSecond;
        registButton.backgroundColor =[UIColor clearColor];
        [registButton addTarget:self action:@selector(clickRegist) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registButton];
        _registButton =registButton;
    }
    return _registButton;
}

-(UIButton *)forgetPasswordButton
{
    if (!_forgetPasswordButton) {
        
       UIButton *forgetPasswordButton =[[UIButton alloc] init];
        [forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [forgetPasswordButton setTitleColor:GlobalThemeColor forState:UIControlStateHighlighted];
        forgetPasswordButton.titleLabel.font =GlobalFontSizeSecond;
        forgetPasswordButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        forgetPasswordButton.backgroundColor =[UIColor clearColor];
        [forgetPasswordButton addTarget:self action:@selector(clickForgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forgetPasswordButton];
        _forgetPasswordButton =forgetPasswordButton;
        
    }
    return _forgetPasswordButton;
}





@end




