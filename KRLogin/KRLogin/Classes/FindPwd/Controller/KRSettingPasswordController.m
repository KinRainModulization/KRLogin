//
//  KRSettingPasswordController.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRSettingPasswordController.h"
#import "KRSettingPasswordView.h"

@interface KRSettingPasswordController ()

@end

@implementation KRSettingPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    KRSettingPasswordView *settingPwdView = [[KRSettingPasswordView alloc] initWithFrame:self.view.bounds];
    settingPwdView.settingPasswordBlock = ^{
        MLog(@"settingPasswordBlock");
    };
    self.view = settingPwdView;
}

@end
