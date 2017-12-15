//
//  KRFindPasswordView.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRFindPasswordView.h"
#import "LXCountdownButton.h"

#define kCountdownTimeKey @"kCountdownTimeKey"

static const NSInteger  kDefaultCountdownTimeInterval = 10;

@interface KRFindPasswordView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *borderTopView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) LXCountdownButton *smsBtn;
@property (nonatomic, strong) UIView *borderBottomView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation KRFindPasswordView

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

- (NSInteger)getCountdownInterval {
    NSDate *currentTime = [NSDate date];
    NSDate *lastTime = [PublicTools getDataFromUserDefaultsWithKey:kCountdownTimeKey];
    NSInteger timeInterval = [lastTime timeIntervalSinceDate:currentTime] + kDefaultCountdownTimeInterval;
    return timeInterval;
}

- (void)prepareUI {
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    
    [self addSubview:contentView];
    [contentView addSubview:self.phoneTextField];
    [contentView addSubview:self.borderTopView];
    [contentView addSubview:self.codeTextField];
    [contentView addSubview:self.smsBtn];
    [contentView addSubview:self.borderBottomView];
    [contentView addSubview:self.shadowView];
    [_shadowView addSubview:self.nextBtn];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.equalTo(self).offset(12);
        make.trailing.equalTo(self).offset(-12);
        make.bottom.equalTo(self).offset(-NAV_BAR_HEIGHT);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(50);
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
    [_borderBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeTextField.mas_bottom).offset(13);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@0.5);
    }];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_borderBottomView.mas_bottom).offset(56);
        make.leading.trailing.equalTo(contentView);
        make.height.equalTo(@50);
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_shadowView);
    }];
}

#pragma mark - Action

- (void)smsCodeButtonClick:(LXCountdownButton *)button {
    button.isStart = YES;
    [PublicTools setData:[NSDate date] toUserDefaultsKey:kCountdownTimeKey];
    self.smsCodeBlock();
}

- (void)nextButtonClick {
    self.nextButtonClickBlock();
}

- (void)clearTextButtonClick {
    _phoneTextField.text = @"";
}

- (void)textFieldTextChange:(UITextField *)textField {
    BOOL hasVaule = _phoneTextField.text.length && _codeTextField.text.length;
    _nextBtn.backgroundColor = hasVaule ? GLOBAL_COLOR : RGB(240, 240, 240);
    [_nextBtn setTitleColor: hasVaule ? [UIColor whiteColor] : RGB(153, 153, 153) forState:UIControlStateNormal];
    _shadowView.layer.shadowColor = hasVaule ? GLOBAL_COLOR.CGColor : [UIColor whiteColor].CGColor;
}

#pragma mark - Setter/Geeter
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
        [_smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _smsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_smsBtn setTitleColor:GLOBAL_COLOR forState:UIControlStateNormal];
        _smsBtn.layer.cornerRadius = 12.5;
        _smsBtn.layer.masksToBounds = YES;
        _smsBtn.layer.borderWidth = 1;
        _smsBtn.layer.borderColor = GLOBAL_COLOR.CGColor;
        [_smsBtn sizeToFit];
        [_smsBtn addTarget:self action:@selector(smsCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsBtn;
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

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithCornerRadius:25 title:@"下一步" fontSize:16 titleColor:RGB(153, 153, 153) backgroundColor:RGB(240, 240, 240) target:self action:@selector(nextButtonClick)];
    }
    return _nextBtn;
}

@end
