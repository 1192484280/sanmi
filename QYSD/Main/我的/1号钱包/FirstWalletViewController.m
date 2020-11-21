//
//  FirstWalletViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "FirstWalletViewController.h"
#import "BangDingAlipayViewController.h"
#import "FirstWalletDetaiViewController.h"

@interface FirstWalletViewController ()

@end

@implementation FirstWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setNavBar];
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"1号钱包"];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_help"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)onRightBtn{
    
    [self goWebView];
}
- (IBAction)onBangDingBtn:(UIButton *)sender {
    
    BangDingAlipayViewController *vc = [[BangDingAlipayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onWalletDetailBtn:(UIButton *)sender {
    
    FirstWalletDetaiViewController *vc = [[FirstWalletDetaiViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
