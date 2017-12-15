//
//  KRLoginController.m
//  KRLogin
//
//  Created by LX on 2017/12/13.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRLoginController.h"
#import "KRLoginView.h"
#import <KRPublishLibrary/BaseNavigationController.h>
#import "KRFindPasswordController.h"

@interface KRLoginController ()<KRLoginViewDelegate>

@end

@implementation KRLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    KRLoginView *loginView = [[KRLoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    if (!self.isPasswordLogin) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"ic_close" withTarget:self withAction:@selector(back)];
    }
    else {
        loginView.isPasswordLogin = YES;
    }
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - KRLoginViewDelegate

- (void)changePasswordLoginMode {
    KRLoginController *passwordLoginVC = [[KRLoginController alloc] init];
    passwordLoginVC.isPasswordLogin = YES;
    [self.navigationController pushViewController:passwordLoginVC animated:YES];
}

- (void)loginButtonClick {
    // test
//    KRLoginController *loginVC = [[KRLoginController alloc] init];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)forgetPasswordButtonClick {
    [self.navigationController pushViewController:[[KRFindPasswordController alloc] init] animated:YES];
}

@end
