//
//  Target_KRLogin.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "Target_KRLogin.h"
#import "KRLoginController.h"

@implementation Target_KRLogin

- (UIViewController *)Action_LoginViewController:(NSDictionary *)params {
    KRLoginController *loginVC = [[KRLoginController alloc] init];
    return loginVC;
}

@end
