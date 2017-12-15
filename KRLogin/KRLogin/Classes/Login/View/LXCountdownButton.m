//
//  MYCountdownButton.m
//
//  Created by 希 on 16/5/31.
//  Copyright © 2016年 xi. All rights reserved.
//

#import "LXCountdownButton.h"

#define kCountDownTimeInterval 10

@interface LXCountdownButton ()

// 保存倒计时按钮的非倒计时状态的title
@property (nonatomic, copy) NSString *originalTitle;

@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation LXCountdownButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    // 设置默认的倒计时时长
    self.durationOfCountDown = kCountDownTimeInterval;
    // 设置button默认文本
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

#pragma mark - Action
/**
 *  开启定时器,开始倒计时
 */
- (void)startCountDown{
    // 创建定时器
    self.countDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    // 将定时器添加到当前的RunLoop中（自动开启定时器）
    [[NSRunLoop currentRunLoop]addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}
/**
 *  定时器方法
 */
- (void)updateCountDown{
    if (self.tempDurationOfCountDown == 0) {
        // 恢复成原始值
        [self setTitle:self.originalTitle forState:UIControlStateNormal];
        [self setTitleColor:GLOBAL_COLOR forState:UIControlStateNormal];
        self.layer.borderColor = GLOBAL_COLOR.CGColor;
        self.userInteractionEnabled = YES;
        self.tempDurationOfCountDown = self.durationOfCountDown;
        // 移除定时器
        [self.countDownTimer invalidate];
    }else{
        [self setTitle:[NSString stringWithFormat:@"%zd秒后重发",self.tempDurationOfCountDown--] forState:UIControlStateNormal];
    }
}

#pragma mark - Setter/Getter

- (void)setIsStart:(BOOL)isStart{
    _isStart = isStart;
    [self startCountDown];
    self.userInteractionEnabled = NO;
    [self setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
    self.layer.borderColor = UIColorFromHex(0x999999).CGColor;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    // 倒计时过程中title的改变不更新originalTitle
    if (self.tempDurationOfCountDown == self.durationOfCountDown) {
        self.originalTitle = @"获取验证码";
    }
}

- (void)setDurationOfCountDown:(NSInteger)durationOfCountDown{
    _durationOfCountDown = durationOfCountDown;
    // 赋值
    self.tempDurationOfCountDown = durationOfCountDown;
}

- (void)dealloc{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}
@end
