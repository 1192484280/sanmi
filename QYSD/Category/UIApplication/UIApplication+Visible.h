//
//  UIApplication+Visible.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/10.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Visible)

- (UIWindow *)mainWindow ;

- (UIViewController *)visibleViewController ;

- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc ;

- (UINavigationController *)visibleNavigationController ;

@end

