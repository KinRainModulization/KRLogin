//
//  KRFindPasswordController.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRFindPasswordController.h"
#import "KRFindPasswordView.h"
#import "KRSettingPasswordController.h"

@interface KRFindPasswordController ()

@end

@implementation KRFindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    KRFindPasswordView *findPwdView = [[KRFindPasswordView alloc] initWithFrame:self.view.bounds];
    findPwdView.smsCodeBlock = ^{
        MLog(@"smsCodeBlock");
    };
    findPwdView.nextButtonClickBlock = ^{
        MLog(@"nextButtonClickBlock");
        [self.navigationController pushViewController:[[KRSettingPasswordController alloc] init] animated:YES];
    };
    [self.view addSubview:findPwdView];
}


@end
