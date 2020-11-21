//
//  QYBaseNavigationViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "QYBaseNavigationViewController.h"

@interface QYBaseNavigationViewController ()

@end

@implementation QYBaseNavigationViewController

/**
 设置导航栏样式
 */
+ (void)load {
    
    NSArray *array = [NSArray arrayWithObjects:[self class], nil]; //iOS9.0后使用
    if (@available(iOS 9.0, *)) {
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:array];
        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        attribute[NSForegroundColorAttributeName] = [UIColor blackColor];
        attribute[NSFontAttributeName] = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        navBar.titleTextAttributes = attribute;
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        
        [navBar setShadowImage:nil];
        navBar.translucent = NO;
//        UIImage *backgroundImage = [UIImage imageWithColor:ThemColor];
//        [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//        [navBar setShadowImage:[UIImage new]];
        [navBar setTintColor:[UIColor blackColor]];
    } else {
        // Fallback on earlier versions
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

-(UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.visibleViewController;
    
}

@end
