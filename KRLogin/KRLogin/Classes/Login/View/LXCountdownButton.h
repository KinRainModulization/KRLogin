//
//  MYCountdownButton.h
//
//  Created by 希 on 16/5/31.
//  Copyright © 2016年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCountdownButton : UIButton
// 验证码倒计时的时长
@property (nonatomic, assign) NSInteger durationOfCountDown;
// 保存倒计时当前时间
@property (nonatomic, assign) NSInteger tempDurationOfCountDown;

@property (nonatomic, assign) BOOL isStart;
@end
