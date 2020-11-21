//
//  BaseViewController.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTAnimationView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) LOTAnimationView *lottieAnimation;

/**
 带返回的navBar

 @param title 标题
 */
- (void)setNavBarWithTitle:(NSString *)title;
- (void)back;

/**
 * 展示成功信息
 */
- (void)showSuccessMsg:(NSString *)msg;

/**
 * 展示错误信息string
 */
- (void)showFailMsg:(NSString *)msg;

/**
 * 展示错误信息error
 */
- (void)showToastWithError:(NSError *)error;

/**
 *跳转webView
 */
-(void)goWebView;

#pragma mark - push
- (void)pushTargetVCWithClassString:(NSString *)classString;


#pragma mark - 展示lottie动画
-(void)showLottie;

#pragma mark - 隐藏lottile动画
- (void)hidenLottie;
@end
