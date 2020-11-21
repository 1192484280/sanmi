//
//  SetHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SetHeaderView.h"
#import "ChangeNickNameViewController.h"
#import "ChangePhoneViewController.h"
#import "CacheManager.h"
#import "AboutSMViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <ShareSDK/ShareSDK.h>

@interface SetHeaderView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerIm;
@property (weak, nonatomic) IBOutlet UILabel *nameLa;

@property (nonatomic, strong) UIView *xibView;
@property (weak, nonatomic) IBOutlet UILabel *cacheLa;
@property (weak, nonatomic) IBOutlet UISwitch *notiPush;

@end

@implementation SetHeaderView

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"SetHeaderView" owner:self options:nil] lastObject];
    }
    return _xibView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
        
        dispatch_queue_t quent = dispatch_queue_create("com.quent", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(quent, ^{
            
            NSString *str = [CacheManager getCachesSize];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.cacheLa.text = str;
            });
            
        });
        
        _headerIm.contentMode =  UIViewContentModeScaleAspectFill;
        _headerIm.clipsToBounds  = YES;

        [_headerIm sd_setImageWithURL:[NSURL URLWithString:SMUserHeadImgUrl] placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder_2"]];
        _nameLa.text = SMUserNickname;
        
        [self ifOpenNoti];
        
    }
    return self;
}

#pragma mark - 判断是否打开通知
- (void)ifOpenNoti{
    
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                
                NSLog(@"未选择---没有选择允许或者不允许，按不允许处理");
                
                self.notiPush.on = NO;
            }else if (settings.authorizationStatus == UNAuthorizationStatusDenied){
                
                NSLog(@"未授权--不允许推送");
                self.notiPush.on = NO;
                
            }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                
                NSLog(@"已授权--允许推送");
                self.notiPush.on = YES;
            }}];
    } else {
        // Fallback on earlier versions
    }
}
#pragma mark - 修改头像
- (IBAction)changeIm:(UIButton *)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.viewController presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 修改昵称
- (IBAction)niceNameBtn:(id)sender {
    
    ChangeNickNameViewController *vc = [[ChangeNickNameViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 手机号
- (IBAction)changePhoneBtn:(UIButton *)sender {
    
    ChangePhoneViewController *vc = [[ChangePhoneViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 消息通知
- (IBAction)onPushSwitch:(UISwitch *)sender {
        
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
        
        NSURL *url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        
        [[UIApplication sharedApplication] openURL:url];
        
    }
    
}

#pragma mark - 关于闪蜜
- (IBAction)onAboutAPP:(UIButton *)sender {
    
    AboutSMViewController *vc = [[AboutSMViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 清理缓存
- (IBAction)onCleanCacheBtn:(UIButton *)sender {
    
    [CacheManager removeCache];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self->_cacheLa.text = @"0.0B";
    });
}

#pragma mark - 退出登录
- (IBAction)onLoginOutBtn:(UIButton *)sender {
    
    MJWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您正在退出当前账号" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_name"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_Im"];
        //通知我的页面用户已登录，刷新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginOutSuccess" object:nil];
        [weakSelf.viewController.navigationController popViewControllerAnimated:YES];
        
        //如果微信登录已授权，取消授权
        if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]){
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat result:^(NSError *error) {
                if (!error) {
                    NSLog(@"取消成功");
                }
                else
                {
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ac1];
    [alert addAction:ac2];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    MJWeakSelf
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *selectedImage=[info objectForKey:UIImagePickerControllerOriginalImage];
        weakSelf.headerIm.image = selectedImage;
    }];
    
}


@end
