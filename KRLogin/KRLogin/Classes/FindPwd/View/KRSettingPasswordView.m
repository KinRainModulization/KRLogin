//
//  KRSettingPasswordView.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSettingPasswordView.h"

@interface KRSettingPasswordView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *borderBottomView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation KRSettingPasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    
    [self addSubview:contentView];
    [contentView addSubview:self.passwordTextField];
    [contentView addSubview:self.borderBottomView];
    [contentView addSubview:self.shadowView];
    [_shadowView addSubview:self.finishBtn];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.equalTo(self).offset(12);
        make.trailing.equalTo(self).offset(-12);
        make.bottom.equalTo(self).offset(-NAV_BAR_HEIGHT);
    }];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(50);
        make.leading.trailing.equalTo(contentView);
    }];
    [_borderBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).offset(13);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@0.5);
    }];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderBottomView.mas_bottom).offset(56);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@50);
    }];
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_shadowView);
    }];
}

#pragma mark - Action

- (void)finishButtonClick {
    self.settingPasswordBlock();
}

- (void)clearTextButtonClick {
    _passwordTextField.text = @"";
}

- (void)textFieldTextChange:(UITextField *)textField {
    BOOL hasVaule = _passwordTextField.text.length >= 6;
    _finishBtn.backgroundColor = hasVaule ? GLOBAL_COLOR : RGB(240, 240, 240);
    [_finishBtn setTitleColor: hasVaule ? [UIColor whiteColor] : RGB(153, 153, 153) forState:UIControlStateNormal];
    _shadowView.layer.shadowColor = hasVaule ? GLOBAL_COLOR.CGColor : [UIColor whiteColor].CGColor;
}

#pragma mark - Setter/Geeter
- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [UITextField textFieldWithPlaceholder:@"新密码（至少6位）" fontSize:14 textColor:RGB(51,51,51) keyboardType:UIKeyboardTypeNumberPad];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 22)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftView.width-8.5, 0, 1, 22)];
        lineView.backgroundColor = GLOBAL_COLOR;
        [leftView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_password"]]];
        [leftView addSubview:lineView];
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightView addTarget:self action:@selector(clearTextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [rightView setImage:[UIImage imageNamed:@"ic_clear"] forState:UIControlStateNormal];
        [rightView sizeToFit];
        _passwordTextField.rightView = rightView;
        _passwordTextField.rightViewMode = UITextFieldViewModeWhileEditing;
        [_passwordTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}

- (UIView *)borderBottomView {
    if (!_borderBottomView) {
        _borderBottomView = [[UIView alloc] init];
        _borderBottomView.backgroundColor = RGB(245,245,245);
    }
    return _borderBottomView;
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

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithCornerRadius:25 title:@"完成" fontSize:16 titleColor:RGB(153, 153, 153) backgroundColor:RGB(240, 240, 240) target:self action:@selector(finishButtonClick)];
    }
    return _finishBtn;
}

@end
