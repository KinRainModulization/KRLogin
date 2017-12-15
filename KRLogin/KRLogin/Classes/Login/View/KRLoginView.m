//
//  KRLoginView.m
//  KRLogin
//
//  Created by LX on 2017/12/13.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRLoginView.h"
#import "LXCountdownButton.h"

#define kCountdownTimeKey @"kCountdownTimeKey"

static const NSInteger  kDefaultCountdownTimeInterval = 10;

@interface KRLoginView ()
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *passwordBtn;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *borderTopView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) LXCountdownButton *smsBtn;
@property (nonatomic, strong) UIButton *visibleTextBtn;
@property (nonatomic, strong) UIView *borderBottomView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetPwdBtn;
@property (nonatomic, strong) UILabel *agreementLable;
@property (nonatomic, strong) UIButton *agreementBtn;

@end

@implementation KRLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
        NSInteger countdownInterval = [self getCountdownInterval];
        if (countdownInterval > 0) {
            self.smsBtn.isStart = YES;
            self.smsBtn.tempDurationOfCountDown = countdownInterval;
            [self.smsBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",countdownInterval++] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)prepareUI {
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    
    [self addSubview:contentView];
    [contentView addSubview:self.leftView];
    [contentView addSubview:self.titleLabel];
    [contentView addSubview:self.passwordBtn];
    [contentView addSubview:self.phoneTextField];
    [contentView addSubview:self.borderTopView];
    [contentView addSubview:self.codeTextField];
    [contentView addSubview:self.smsBtn];
    [contentView addSubview:self.visibleTextBtn];
    [contentView addSubview:self.borderBottomView];
    [contentView addSubview:self.promptLabel];
    [contentView addSubview:self.shadowView];
    [_shadowView addSubview:self.loginBtn];
    [contentView addSubview:self.forgetPwdBtn];
    [contentView addSubview:self.agreementLable];
    [contentView addSubview:self.agreementBtn];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.equalTo(self).offset(12);
        make.trailing.equalTo(self).offset(-12);
        make.bottom.equalTo(self).offset(-NAV_BAR_HEIGHT);
    }];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(50);
        make.leading.equalTo(contentView);
        make.width.equalTo(@5);
        make.height.equalTo(@20);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftView);
        make.leading.equalTo(_leftView).offset(10);
    }];
    [_passwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftView);
        make.trailing.equalTo(contentView);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftView.mas_bottom).offset(64);
        make.leading.trailing.equalTo(contentView);
    }];
    [_borderTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTextField.mas_bottom).offset(13);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@0.5);
    }];
    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderTopView.mas_bottom).offset(34);
        make.leading.equalTo(contentView);
        make.trailing.equalTo(contentView).offset(-90);
    }];
    [_smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderTopView.mas_bottom).offset(32);
        make.trailing.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    [_visibleTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderTopView.mas_bottom).offset(34);
        make.trailing.equalTo(contentView);
    }];
    [_borderBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextField.mas_bottom).offset(13);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@0.5);
    }];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderBottomView.mas_bottom).offset(10);
        make.leading.equalTo(contentView);
    }];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_promptLabel.mas_bottom).offset(50);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@50);
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_shadowView);
    }];
    [_forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        make.trailing.equalTo(contentView).offset(-15);
    }];
    [_agreementLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView).offset(-(_agreementLable.width-_agreementBtn.width));
        make.bottom.equalTo(contentView).offset(-20);
    }];
    [_agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_agreementLable.mas_trailing);
        make.centerY.equalTo(_agreementLable);
    }];
}

- (NSInteger)getCountdownInterval {
    NSDate *currentTime = [NSDate date];
    NSDate *lastTime = [PublicTools getDataFromUserDefaultsWithKey:kCountdownTimeKey];
    NSInteger timeInterval = [lastTime timeIntervalSinceDate:currentTime] + kDefaultCountdownTimeInterval;
    return timeInterval;
}

#pragma mark - Action

- (void)textFieldTextChange:(UITextField *)textField {
    BOOL hasVaule = _phoneTextField.text.length && _codeTextField.text.length;
    _loginBtn.backgroundColor = hasVaule ? GLOBAL_COLOR : RGB(240, 240, 240);
    [_loginBtn setTitleColor: hasVaule ? [UIColor whiteColor] : RGB(153, 153, 153) forState:UIControlStateNormal];
    _shadowView.layer.shadowColor = hasVaule ? GLOBAL_COLOR.CGColor : [UIColor whiteColor].CGColor;
    
    BOOL isPhoneNumber = _phoneTextField.text.length >= 11;
    _smsBtn.userInteractionEnabled = isPhoneNumber;
    [_smsBtn setTitleColor:isPhoneNumber ? GLOBAL_COLOR : UIColorFromHex(0x999999) forState:UIControlStateNormal];
    _smsBtn.layer.borderColor = isPhoneNumber ? GLOBAL_COLOR.CGColor : UIColorFromHex(0x999999).CGColor;
}

- (void)passwordButtonClick {
    if ([self.delegate respondsToSelector:@selector(changePasswordLoginMode)]) {
        [self.delegate changePasswordLoginMode];
    };
}

- (void)smsCodeButtonClick:(LXCountdownButton *)button {
    button.isStart = YES;
    [PublicTools setData:[NSDate date] toUserDefaultsKey:kCountdownTimeKey];
}

- (void)loginButtonClick {
    if ([self.delegate respondsToSelector:@selector(loginButtonClick)]) {
        [self.delegate loginButtonClick];
    };
    MLog(@"loginButtonClick");
}

- (void)agreementButtonClick {
    MLog(@"agreementButtonClick");
}

- (void)clearTextButtonClick {
    _phoneTextField.text = @"";
    [self textFieldTextChange:_phoneTextField];
}

- (void)visibleTextButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    self.codeTextField.secureTextEntry = !_codeTextField.secureTextEntry;
    [self.codeTextField becomeFirstResponder];
}

- (void)forgetPasswordButtonClick {
    if ([self.delegate respondsToSelector:@selector(forgetPasswordButtonClick)]) {
        [self.delegate forgetPasswordButtonClick];
    };
    MLog(@"forgetPasswordButtonClick");
}

#pragma mark - Setter/Getter

- (void)setIsPasswordLogin:(BOOL)isPasswordLogin {
    _isPasswordLogin = isPasswordLogin;
    self.titleLabel.text = @"密码登录";
    self.passwordBtn.hidden = YES;
    self.codeTextField.placeholder = @"请输入登录密码";
    self.smsBtn.hidden = YES;
    self.promptLabel.hidden = YES;
    self.visibleTextBtn.hidden = NO;
    self.forgetPwdBtn.hidden = NO;
    [self.codeTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(_contentView).offset(-30);
    }];
    self.codeTextField.secureTextEntry = YES;
}

- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = GLOBAL_COLOR;
        _leftView.layer.cornerRadius = 2.5;
    }
    return _leftView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"手机快捷登录" textColor:[UIColor blackColor] fontSize:18];
    }
    return _titleLabel;
}

- (UIButton *)passwordBtn {
    if (!_passwordBtn) {
        _passwordBtn = [UIButton buttonWithTitle:@"密码登录" fontSize:12 titleColor:GLOBAL_COLOR target:self action:@selector(passwordButtonClick)];
    }
    return _passwordBtn;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [UITextField textFieldWithPlaceholder:@"请输入手机号码" fontSize:14 textColor:RGB(51,51,51) keyboardType:UIKeyboardTypeNumberPad];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 22)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftView.width-8.5, 0, 1, 22)];
        lineView.backgroundColor = GLOBAL_COLOR;
        [leftView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_iphone"]]];
        [leftView addSubview:lineView];
        _phoneTextField.leftView = leftView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addTarget:self action:@selector(clearTextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [rightView setImage:[UIImage imageNamed:@"ic_clear"] forState:UIControlStateNormal];
        [rightView sizeToFit];
        _phoneTextField.rightView = rightView;
        _phoneTextField.rightViewMode = UITextFieldViewModeWhileEditing;
        [_phoneTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [UITextField textFieldWithPlaceholder:@"请输入验证码" fontSize:14 textColor:RGB(51,51,51) keyboardType:UIKeyboardTypeNumberPad];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 22)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftView.width-8.5, 0, 1, 22)];
        lineView.backgroundColor = GLOBAL_COLOR;
        [leftView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_verification"]]];
        [leftView addSubview:lineView];
        _codeTextField.leftView = leftView;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        [_codeTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTextField;
}

- (LXCountdownButton *)smsBtn {
    if (!_smsBtn) {
        _smsBtn =[[LXCountdownButton alloc] initWithFrame:CGRectZero];
        _smsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_smsBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
        _smsBtn.layer.cornerRadius = 12.5;
        _smsBtn.layer.masksToBounds = YES;
        _smsBtn.layer.borderWidth = 1;
        _smsBtn.layer.borderColor = UIColorFromHex(0x999999).CGColor;
        [_smsBtn sizeToFit];
        [_smsBtn addTarget:self action:@selector(smsCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _smsBtn.userInteractionEnabled = NO;
    }
    return _smsBtn;
}

- (UIButton *)visibleTextBtn {
    if (!_visibleTextBtn) {
        _visibleTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_visibleTextBtn addTarget:self action:@selector(visibleTextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_visibleTextBtn setImage:[UIImage imageNamed:@"ped_invisile"] forState:UIControlStateNormal];
        [_visibleTextBtn setImage:[UIImage imageNamed:@"pwd_visible"] forState:UIControlStateSelected];
        _visibleTextBtn.hidden = YES;
    }
    return _visibleTextBtn;
}

- (UIView *)borderTopView {
    if (!_borderTopView) {
        _borderTopView = [[UIView alloc] init];
        _borderTopView.backgroundColor = RGB(245,245,245);
    }
    return _borderTopView;
}

- (UIView *)borderBottomView {
    if (!_borderBottomView) {
        _borderBottomView = [[UIView alloc] init];
        _borderBottomView.backgroundColor = RGB(245,245,245);
    }
    return _borderBottomView;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [UILabel labelWithText:@"未注册的手机号将自动创建帐号" textColor:RGB(153,153,153) fontSize:12];
    }
    return _promptLabel;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 5);
        _shadowView.layer.shadowOpacity = 0.4;
        _shadowView.layer.cornerRadius = 25;
    }
    return _shadowView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithCornerRadius:25 title:@"登录" fontSize:16 titleColor:RGB(153, 153, 153) backgroundColor:RGB(240, 240, 240) target:self action:@selector(loginButtonClick)];
    }
    return _loginBtn;
}

- (UIButton *)forgetPwdBtn {
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [UIButton buttonWithTitle:@"忘记密码" fontSize:12 titleColor:GLOBAL_COLOR target:self action:@selector(forgetPasswordButtonClick)];
        _forgetPwdBtn.hidden = YES;
    }
    return _forgetPwdBtn;
}

- (UILabel *)agreementLable {
    if (!_agreementLable) {
        _agreementLable = [UILabel labelWithText:@"登录则代表您已阅读并同意" textColor:RGB(153, 153, 153) fontSize:12];
    }
    return _agreementLable;
}

- (UIButton *)agreementBtn {
    if (!_agreementBtn) {
        _agreementBtn = [UIButton buttonWithTitle:@"《轻雨用户协议》" fontSize:12 titleColor:GLOBAL_COLOR target:self action:@selector(agreementButtonClick)];
    }
    return _agreementBtn;
}

@end
