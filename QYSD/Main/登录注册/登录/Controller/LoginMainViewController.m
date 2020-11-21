//
//  LoginMainViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "LoginMainViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "SAMKeychainQuery.h"
#import <MFSIdentifier/MFSIdentifier.h>
#import "LoginParameters.h"
#import "LoginStore.h"
#import "WkWebList.h"
#import "WKWebViewController.h"

@interface LoginMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *freeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *xieyiLa;

@end

@implementation LoginMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]] ) {
        
        self.weixinBtn.hidden = YES;
    }else{
        self.freeBtn.hidden = YES;
    }
    
    self.titleLa.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAgreenBtn)];
    [self.titleLa addGestureRecognizer:tap1];
    
    self.xieyiLa.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onXieYiLa)];
    [self.xieyiLa addGestureRecognizer:tap2];

}

#pragma mark - 查看协议
-(void)onXieYiLa{
    
    [WkWebList sharedInstance].url = @"http://shanmi.qytimes.cn/agreement.html";
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    webVC.present = YES;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 同意协议
- (IBAction)onAgreeBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

- (void)onAgreenBtn{
    
    self.agreeBtn.selected = !self.agreeBtn.selected;
}
#pragma mark - 微信登录
- (IBAction)onLoginOfWeChat:(UIButton *)sender {
    
    if (self.agreeBtn.selected == YES) {
        
        return [self showFailMsg:@"请阅读并同意闪蜜注册协议"];
    }
    
    //判断是否已授权
    if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat])
    {
        
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            
            if (state ==SSDKResponseStateSuccess) {
                
                NSLog(@"%@",[user.credential rawData]);
                NSLog(@"%@",user.rawData);
                //拿到用户信息，到自己后台请求登录
                LoginParameters *parameters = [[LoginParameters alloc] init];
                parameters.deviceid = [MFSIdentifier deviceID];
                parameters.city = user.rawData[@"city"];
                parameters.country = user.rawData[@"country"];
                parameters.headimgurl = user.rawData[@"headimgurl"];
                parameters.nickname = user.rawData[@"nickname"];
                parameters.openid = user.rawData[@"openid"];
                parameters.sex = [user.rawData[@"sex"] integerValue];
                parameters.unionid = user.rawData[@"unionid"];
                
                NSArray *privilegeArr = user.rawData[@"privilege"];
                NSMutableString *muStr = [NSMutableString string];
                for (int i = 0; i < privilegeArr.count; i ++) {
                    
                    if (i == 0) {
                        
                        [muStr appendString:privilegeArr[i]];
                    }else{
                        
                        [muStr appendString:[NSString stringWithFormat:@",%@",privilegeArr[i]]];
                    }
                }
                parameters.privilege = muStr;
                [self loginWithParameters:parameters];
                
            }else if (state ==SSDKResponseStateFail){
                
                NSLog(@"--%@",error.description);
                //失败
            }else if (state ==SSDKResponseStateCancel){
                //用户取消授权
            }
        }];
    }
    else
    {
        [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            
            if (state ==SSDKResponseStateSuccess) {
                
                NSLog(@"%@",[user.credential rawData]);
                NSLog(@"%@",user.rawData);
                //拿到用户信息，到自己后台请求登录
                LoginParameters *parameters = [[LoginParameters alloc] init];
                parameters.deviceid = [MFSIdentifier deviceID];
                parameters.city = user.rawData[@"city"];
                parameters.country = user.rawData[@"country"];
                parameters.headimgurl = user.rawData[@"headimgurl"];
                parameters.nickname = user.rawData[@"nickname"];
                parameters.openid = user.rawData[@"openid"];
                parameters.sex = [user.rawData[@"sex"] integerValue];
                parameters.unionid = user.rawData[@"unionid"];
                
                NSArray *privilegeArr = user.rawData[@"privilege"];
                NSMutableString *muStr = [NSMutableString string];
                for (int i = 0; i < privilegeArr.count; i ++) {
                    
                    if (i == 0) {
                        
                        [muStr appendString:privilegeArr[i]];
                    }else{
                        
                        [muStr appendString:[NSString stringWithFormat:@",%@",privilegeArr[i]]];
                    }
                }
                parameters.privilege = muStr;
                [self loginWithParameters:parameters];
                
            }else if (state ==SSDKResponseStateFail){
                
                NSLog(@"--%@",error.description);
                //失败
            }else if (state ==SSDKResponseStateCancel){
                //用户取消授权
            }
        }];
    }
}

#pragma mark - 游客登录
- (IBAction)onLoginOfFreeDom:(UIButton *)sender {
    
    if (self.agreeBtn.selected == YES) {
        
        return [self showFailMsg:@"请阅读并同意闪蜜注册协议"];
    }
    
    LoginParameters *parameters = [[LoginParameters alloc] init];
    parameters.deviceid = [MFSIdentifier deviceID];
    
    [self loginWithParameters:parameters];
}

- (void)loginWithParameters:(LoginParameters *)parameters{

    [SVProgressHUD show];

    MJWeakSelf
    [LoginStore loginWithParamters:parameters Success:^{
        
        //通知我的页面用户已登录，刷新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
             [weakSelf showSuccessMsg:@"登陆成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
            
        });
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [weakSelf showToastWithError:error];
    }];
}

- (IBAction)onCloseBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
