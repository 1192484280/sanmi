//
//  BaseViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpTool.h"
#import "WKWebViewController.h"

@interface BaseViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>


@end

@implementation BaseViewController

- (LOTAnimationView *)lottieAnimation{
    
    if (!_lottieAnimation) {
        
        _lottieAnimation = [LOTAnimationView animationNamed:@"lottieAnim_2"];
        _lottieAnimation.loopAnimation = YES;
        _lottieAnimation.hidden = YES;
        [self.view addSubview:_lottieAnimation];
        
        [_lottieAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(65);
            make.center.equalTo(self.view);
        }];
        
    }
    return _lottieAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = BaseBackGroundColor;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 带返回的navBar
- (void)setNavBarWithTitle:(NSString *)title
{
    self.title = title;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 展示成功信息
- (void)showSuccessMsg:(NSString *)msg{
    
    [self.view makeToast:msg duration:2.0 position:CSToastPositionCenter];
    
}

#pragma mark - 展示错误信息string
- (void)showFailMsg:(NSString *)msg{
    
    [self.view makeToast:msg duration:2.0 position:CSToastPositionBottom];
    
}

#pragma mark - 展示错误信息error
- (void)showToastWithError:(NSError *)error{
    
    [self.view makeToast:[HttpTool handleError:error] duration:2.0 position:CSToastPositionBottom];
    
}

#pragma mark - 跳转webView
-(void)goWebView{
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"无数据"];
}

//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    return [UIImage imageNamed:@"img_godsdetailRec"];
//}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:14],
                                 NSForegroundColorAttributeName: UIColor.lightGrayColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 如果不实现此方法的话,无数据时下拉刷新不可用
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


#pragma mark - push
- (void)pushTargetVCWithClassString:(NSString *)classString{

    Class viewControllerClass = NSClassFromString(classString);
    if (viewControllerClass) {
        UIViewController *targetVC = [[viewControllerClass alloc]init];
        
        if (targetVC) {
            [targetVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:targetVC animated:true];
        }
    }
}

#pragma mark - 展示lottie动画
-(void)showLottie{
    
    self.lottieAnimation.hidden = NO;
    [self.lottieAnimation play];
}

#pragma mark - 隐藏lottile动画
- (void)hidenLottie{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lottieAnimation.alpha = 0;
    } completion:^(BOOL finished) {
        [self.lottieAnimation stop];
        self.lottieAnimation.hidden = YES;
        
    }];

}
@end
