//
//  MyProfitHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyProfitHeaderView.h"
#import "OrderCenterViewController.h"
#import "WKWebViewController.h"
#import "MySecondPartnerViewController.h"
#import "MyProfitMoreDataViewController.h"
#import "FirstWalletViewController.h"

@interface MyProfitHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (nonatomic, strong) UIView *xibView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topheight;

@end

@implementation MyProfitHeaderView

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"MyProfitHeaderView" owner:self options:nil] lastObject];

    }
    return _xibView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
        self.topMargin.constant = STATUS_BAR_HEIGHT;
        self.topheight.constant =   iPhoneX?195:170;
        [self.topView az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    }
    return self;
}

#pragma mark - 查看订单
- (IBAction)onOrderBtn:(UIButton *)sender {
    
    OrderCenterViewController *vc = [[OrderCenterViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回
- (IBAction)onBackBtn:(UIButton *)sender {
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - help
- (IBAction)onHelpBtn:(UIButton *)sender {
    
    WKWebViewController *vc =[[WKWebViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 查看更多有效数据
- (IBAction)onLookMoreDataBtn:(UIButton *)sender {

    MyProfitMoreDataViewController *vc = [[MyProfitMoreDataViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 我的二当家收益明细
- (IBAction)onMySecondPartnerBtn:(UIButton *)sender {
    
    MySecondPartnerViewController *vc = [[MySecondPartnerViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 我的三当家收益明细
- (IBAction)onMyThridPartnerBtn:(UIButton *)sender {
    
    MySecondPartnerViewController *vc = [[MySecondPartnerViewController alloc] init];
    vc.flag = 3;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onGetMoneyBtn:(UIButton *)sender {
    
    FirstWalletViewController *vc = [[FirstWalletViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
@end
