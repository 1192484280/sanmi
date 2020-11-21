//
//  ProductBottomBar.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductBottomBar.h"
#import "PromotionDetailViewController.h"
#import "ProductDetailModel.h"
#import "WkWebList.h"
#import "WKWebViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LoginMainViewController.h"
#import "CollectorStore.h"

@interface ProductBottomBar ()

@property (nonatomic, strong) UIView *xibView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *la1;

@end

@implementation ProductBottomBar

- (UIView *)xibView{
    
    if (!_xibView) {
        
        ClassName
        _xibView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return _xibView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
        
        NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
        
        if ([version isEqualToString:@"1.0"]) {
            
            self.leftMargin.constant = -30;
            self.la1.alpha = 0;
            self.btn1.alpha = 0;
        }else{
            
            self.leftMargin.constant = 25;
            self.la1.alpha = 1;
            self.btn1.alpha = 1;
        }
    }
    return self;
}

#pragma mark - 点击首页
- (IBAction)onHomeBtn:(UIButton *)sender {
    [self.viewController.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 点击收藏
- (IBAction)onCollectionBtn:(UIButton *)sender {
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    
    if ([version isEqualToString:@"1.0"]) {
        
        return;
    }
    
    if (![SMUserGuid isValid] ) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    [self addScaleAnimationOnView:sender];
    
    if (sender.selected) {
        
        
        [self addCollectorWithUserguid:SMUserGuid itemid:self.model.ItemId isstore:@"0" sucessStr:@"取消收藏"];
        
    }else{
        
        [self addCollectorWithUserguid:SMUserGuid itemid:self.model.ItemId isstore:@"1" sucessStr:@"收藏成功"];
        
    }
}

- (void)addCollectorWithUserguid:(NSString *)userId itemid:(NSString *)itemid isstore:(NSString *)isstore sucessStr:(NSString *)successStr{
    
    self.collectorBtn.enabled = NO;
    
    MJWeakSelf
    [CollectorStore addCollectorWithUserguid:userId identity:SMIdentity itemid:itemid title:self.model.Title Success:^{
        
        [weakSelf.viewController.view makeToast:successStr duration:1.0 position:CSToastPositionCenter];
        weakSelf.collectorBtn.selected = !weakSelf.collectorBtn.selected;
        
        self.collectorBtn.enabled = YES;
        
    } Failure:^(NSError *error) {
        
        [weakSelf.viewController.view makeToast:[HttpTool handleError:error] duration:1.0 position:CSToastPositionCenter];
        
        self.collectorBtn.enabled = YES;
    }];
}
#pragma mark - 点击我要分享
- (IBAction)onShareBtn:(UIButton *)sender {
    
    NSString *url = self.model.CouponShareUrl;
    if (![self.model.CouponShareUrl containsString:@"http"]) {
        
        url = [NSString stringWithFormat:@"http:%@",self.model.CouponShareUrl];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\n领券购买，请复制到浏览器打开",self.model.ItemDescription]
                                images:[UIImage imageNamed:@"smlogo"]
                                   url:[NSURL URLWithString:url]
                                 title:self.model.Title
                                  type:SSDKContentTypeAuto];
    [ShareSDK showShareActionSheet:nil
                       customItems:nil
                       shareParams:params
                sheetConfiguration:nil
                    onStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error,
                                     BOOL end)
     {
         
         switch (state) {
                 
             case SSDKResponseStateSuccess:
                 NSLog(@"成功");//成功
                 break;
             case SSDKResponseStateFail:
             {
                 NSLog(@"--%@",error.description);
                 //失败
                 break;
             }
             case SSDKResponseStateCancel:
                 break;
             default:
                 break;
         }
     }];
}

#pragma mark - 点击立即购买
- (IBAction)onBuyOfSelfBtn:(UIButton *)sender {
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    if (![SMUserGuid isValid] && ![version isEqualToString:@"1.0"]) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    NSString *url = self.model.CouponShareUrl;
    if (![self.model.CouponShareUrl containsString:@"taobao:"]) {
        
        url = [NSString stringWithFormat:@"taobao:%@",self.model.CouponShareUrl];
    }
    
    NSURL *Url = [NSURL URLWithString:url];
    if ([[UIApplication sharedApplication] canOpenURL:Url]) {
        
        [[UIApplication sharedApplication] openURL:Url];
        
    } else {
        
        if (![self.model.CouponShareUrl containsString:@"http"]) {
            
            url = [NSString stringWithFormat:@"http:%@",self.model.CouponShareUrl];
        }
        [WkWebList sharedInstance].url = url;
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        [webVC setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
    
}

- (void)addScaleAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

- (void)setProductModel:(ProductDetailModel *)data{
    
    _model = data;
}
@end
