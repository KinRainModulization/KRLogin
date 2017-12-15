//
//  KRTestViewController.m
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "KRTestViewController.h"
#import "KRLoginController.h"
#import <BaseNavigationController.h>

@interface KRTestViewController ()

@end

@implementation KRTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithTitle:@"登录" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(test)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];

}

- (void)test {
    KRLoginController *loginVC = [[KRLoginController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
