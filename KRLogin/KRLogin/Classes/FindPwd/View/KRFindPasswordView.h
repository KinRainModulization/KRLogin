//
//  KRFindPasswordView.h
//  KRLogin
//
//  Created by LX on 2017/12/15.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRFindPasswordView : UIView

@property (nonatomic, copy) void (^smsCodeBlock)();
@property (nonatomic, copy) void (^nextButtonClickBlock)();

@end
