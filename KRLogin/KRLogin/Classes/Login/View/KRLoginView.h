//
//  KRLoginView.h
//  KRLogin
//
//  Created by LX on 2017/12/13.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KRLoginViewDelegate <NSObject>

- (void)changePasswordLoginMode;

- (void)loginButtonClick;

- (void)forgetPasswordButtonClick;

@end


@interface KRLoginView : UIView

@property (nonatomic, assign) BOOL isPasswordLogin;

@property (nonatomic, weak) id<KRLoginViewDelegate> delegate;
@end
