//
//  AppDelegate.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "QYBaseTabBarViewController.h"
#import "IQKeyboardManager.h"
#import <ShareSDK/ShareSDK.h>
#import "PopCopyView.h"
#import "SearchResultViewController.h"
#import "UIApplication+Visible.h"
#import "YYFPSLabel.h"
#import "DHGuidePageHUD.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//极光统计
#import "JANALYTICSService.h"
#import "PopCopyTKLView.h"
#import <WebKit/WebKit.h>
#import "LoginMainViewController.h"
#import "ProductDetailStore.h"
#import "WkWebList.h"
#import "WKWebViewController.h"
#import "ProductDetailModel.h"

#define JPushAppKey @"9ce05fe55275b5260d49db6a"

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    NSString *_copyText;
    NSString *_openTaboBaoUrl;
}
@property (nonatomic, strong) PopCopyView *popCopyView;
@property (nonatomic, strong) PopCopyTKLView *popCopyTKLView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:1.0];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    QYBaseTabBarViewController *tabVC = [[QYBaseTabBarViewController alloc] init];
    self.window.rootViewController = tabVC;
    
    [self.window makeKeyAndVisible];
    
    //makeKeyAndVisible之后添加引导页
    [self addGuidView];
    
    //开启键盘自动管理
    [self keyBoardManager];
    
    //配置shareSdk
    [self setShareSdk];
    
//     [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    //初始化APNs
    [self setAPNs];
    
    //初始化JPush
    [self setJPushWithOptions:launchOptions];
    
    //初始化极光统计
    [self setJiGuangTongji];
    
    [self deleteWebCache];
    
    return YES;
}

//allWebsiteDataTypes清除所有Web缓存
- (void)deleteWebCache {

    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];

    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];

    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}

#pragma mark - 初始化极光统计
-(void)setJiGuangTongji{
    
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    
    config.appKey = JPushAppKey;
    
    config.channel = @"App Store";
    
    [JANALYTICSService setupWithConfig:config];
}

#pragma mark - 初始化APNs
- (void)setAPNs{
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

#pragma mark - 初始化JPush
- (void)setJPushWithOptions:(NSDictionary *)launchOptions{

    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:@"App Store" apsForProduction:0 advertisingIdentifier:nil];

}

#pragma mark - 添加引导页
- (void)addGuidView{
    
    // 使用NSUserDefaults判断程序是否第一次启动(其他方法也可以)
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 在这里写初始化图片数组和DHGuidePageHUD库引导页的代码

        // 静态引导图片数组初始化
        NSArray *imageNameArray = @[@"first_open_01",@"first_open_02",@"first_open_03"];
        // 创建并添加引导页
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.frame imageNameArray:imageNameArray buttonIsHidden:NO];
        guidePage.slideInto = YES;
        [self.window addSubview:guidePage];

    }
}

#pragma mark - 初始化ShareSDK
- (void)setShareSdk{
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
//        [platformsRegister setupQQWithAppId:@"100371282" appkey:@"aed9b0303e3ed1e27bae87c33761161d"];
        
        //微信
//        [platformsRegister setupWeChatWithAppId:@"wxf0925919b96bb85f" appSecret:@"1153982ca01b08d3b4c20d63dd203075"];
        
        [platformsRegister setupWeChatWithAppId:@"wx4868b35061f87885" appSecret:nil];
    }];
}
#pragma mark - 设置IQKeyboardManager
- (void)keyBoardManager{
    
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    DLog(@"当应用程序将要进入非活动状态.在此期间，应用程序不接收消息或事件，比如来电话了.");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    DLog(@"当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可");
    [application setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    DLog(@"当程序从后台将要重新回到前台时候调用");
    
    // 清空Push显示的个数
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    DLog(@"当应用程序进入活动状态执行");
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstDidBecomeActive"]) {

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        if (![pasteboard.string isValid]) return;
        
        _copyText = pasteboard.string;
        
        pasteboard.string = @"";
        
        [self popView:_copyText];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstDidBecomeActive"];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    DLog(@"当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值");
    [self deleteWebCache];
}

//请求委托打开一个 URL资源
//- (BOOL) application:(UIApplication *) application handleOpenURL:(NSURL *)url{
//    
//    [JANALYTICSService handleUrl:url];
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([JANALYTICSService handleUrl:url]) {
//        return YES;
//    }
//    return NO;
//}

//当内存低告警时
//- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{}
//
////当应用程序即将终止时调用，可以在applicationDidEnterBackground中保存数据
//-(void)applicationSignificantTimeChange:(UIApplication *)application{}
//
////当一个运行着的应用程序收到一个远程的通知发送到此方法 7.0之前
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{}
//
////当一个运行着的应用程序收到一个远程的通知 发送此方法 7.0之后
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{}
//
////当一个应用程序成功的注册一个推送服务（APS） 发送此方法
//-(void) application :(UIApplication *) application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken{}
//
////当 APS无法成功的完成向程序进程推送时 发送此方法
//-(void) application :(UIApplication *) application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error{}
//
////当一个运行着的应用程序收到一个本地的通知 发送此方法
//-(void) application :(UIApplication *) application didReceiveLocalNotification:(UILocalNotification *)notification{}

#pragma mark - 弹出粘贴板
- (void)popView:(NSString *)text{
    
    NSArray *subviews = [[UIApplication sharedApplication].keyWindow subviews];
    
    if ([subviews count] == 0) return;
    
    BOOL ifHave = NO;
    for (UIView *subview in subviews) {
        
        if ([subview.class isEqual:[PopCopyView class]] || [subview.class isEqual:[PopCopyTKLView class]]) {
            
            ifHave = YES;
        }
    }
    
    if (ifHave) return;
    
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    
    NSArray *arr = [text componentsSeparatedByString:@"￥"];
    if ([text containsString:@"￥"] && [text containsString:@"and"]) {
        
        NSArray *arr = [text componentsSeparatedByString:@"and"];
        [self getTaoBaoUrlWithItemId:arr[1] andTitle:arr.lastObject];
        
    }else{
        
        [topWindow addSubview:self.popCopyView];
        [self.popCopyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    
    
}

- (PopCopyView *)popCopyView{
    
    if (!_popCopyView) {
        
        _popCopyView = [[PopCopyView alloc] initWithFrame:CGRectZero withTitle:_copyText];
        _popCopyView.tag = 1236;
        
        MJWeakSelf
        _popCopyView.closeBlock = ^{
            
            weakSelf.popCopyView = nil;
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1236] removeFromSuperview];
            
        };
        
        _popCopyView.searchBlock = ^(NSString *text) {
            
            MJStrongSelf
            weakSelf.popCopyView = nil;
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1236] removeFromSuperview];
            
            SearchResultViewController *vc = [[SearchResultViewController alloc] init];
            vc.keyWord = strongSelf->_copyText;
            UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
            [vc setHidesBottomBarWhenPushed:YES];
            [nav pushViewController:vc animated:YES];
           
        };
    }
    return _popCopyView;
}

- (PopCopyTKLView *)popCopyTKLView{
    
    if (!_popCopyTKLView) {
        
        NSArray *arr = [_copyText componentsSeparatedByString:@"and"];
        
        _popCopyTKLView = [[PopCopyTKLView alloc] initWithFrame:CGRectZero withTitle:arr.firstObject];
        _popCopyTKLView.tag = 1237;
        
        MJWeakSelf
        _popCopyTKLView.closeBlock = ^{
            
            weakSelf.popCopyTKLView = nil;
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1237] removeFromSuperview];
            
        };
        
        _popCopyTKLView.searchBlock = ^(NSString *text) {
            
            MJStrongSelf
            weakSelf.popCopyTKLView = nil;
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1237] removeFromSuperview];
            
            [strongSelf openTaoBaoWithurl:strongSelf->_openTaboBaoUrl];
           
        };
    }
    return _popCopyTKLView;
}

#pragma mark 获取商品淘宝链接
- (void)getTaoBaoUrlWithItemId:(NSString *)itemId andTitle:(NSString *)title{
    
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    
    _copyText = title;
    
    MJWeakSelf    
    [ProductDetailStore getProductDetailWithIdentity:IDENTITY itmeid:itemId title:title Success:^(ProductDetailModel *detailModel) {
        
        [topWindow addSubview:weakSelf.popCopyTKLView];
        [weakSelf.popCopyTKLView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self->_openTaboBaoUrl = detailModel.CouponShareUrl;

    } Failure:^(NSError *error) {
    }];
    
}

//#pragma mark - 立即购买
-(void)openTaoBaoWithurl:(NSString *)couponShareUrl{
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    if (![SMUserGuid isValid] && ![version isEqualToString:@"1.0"]) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
        [nav presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    NSString *url = couponShareUrl;
    if (![couponShareUrl containsString:@"taobao:"]) {
        
        url = [NSString stringWithFormat:@"taobao:%@",couponShareUrl];
    }
    
    NSURL *Url = [NSURL URLWithString:url];
    
    if (@available(iOS 13.0, *)) {
        
        if (![couponShareUrl containsString:@"http"]) {
            
            url = [NSString stringWithFormat:@"http:%@",couponShareUrl];
        }
        [WkWebList sharedInstance].url = url;
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        [webVC setHidesBottomBarWhenPushed:YES];
        UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
        [nav pushViewController:webVC animated:YES];
        
    }else{
        
        if ([[UIApplication sharedApplication] canOpenURL:Url]) {
            
            [[UIApplication sharedApplication] openURL:Url];
            
        } else {
            
            if (![couponShareUrl containsString:@"http"]) {
                
                url = [NSString stringWithFormat:@"http:%@",couponShareUrl];
            }
            [WkWebList sharedInstance].url = url;
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            [webVC setHidesBottomBarWhenPushed:YES];
            UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
            [nav pushViewController:webVC animated:YES];
        }
    }
    
    
}


#pragma mark - 推送相关回调
#pragma mark - 注册 APNs 成功并上报 DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - 实现注册 APNs 失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"极光推送注册失败 Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
#pragma mark - 添加处理 APNs 通知回调方法
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        NSDictionary * userInfo = notification.request.content.userInfo;
        NSString *title = userInfo[@"aps"][@"alert"][@"body"];
        SearchResultViewController *vc = [[SearchResultViewController alloc] init];
        vc.keyWord = title;
        UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
        [vc setHidesBottomBarWhenPushed:YES];
        [nav pushViewController:vc animated:YES];
        
    }else{
        //从通知设置界面进入应用
        NSDictionary * userInfo = notification.request.content.userInfo;
        NSString *title = userInfo[@"aps"][@"alert"][@"body"];
        SearchResultViewController *vc = [[SearchResultViewController alloc] init];
        vc.keyWord = title;
        UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
        [vc setHidesBottomBarWhenPushed:YES];
        [nav pushViewController:vc animated:YES];
        
    }
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    
    NSString *title = userInfo[@"aps"][@"alert"][@"body"];
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = title;
    UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
    [vc setHidesBottomBarWhenPushed:YES];
    [nav pushViewController:vc animated:YES];
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
    NSString *title = userInfo[@"aps"][@"alert"][@"body"];
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = title;
    UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
    [vc setHidesBottomBarWhenPushed:YES];
    [nav pushViewController:vc animated:YES];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSString *title = userInfo[@"aps"][@"alert"][@"body"];
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = title;
    UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
    [vc setHidesBottomBarWhenPushed:YES];
    [nav pushViewController:vc animated:YES];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSString *title = userInfo[@"aps"][@"alert"][@"body"];
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = title;
    UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
    [vc setHidesBottomBarWhenPushed:YES];
    [nav pushViewController:vc animated:YES];
    
}

@end
