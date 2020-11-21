//
//  TopViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TopViewController.h"
#import "TopHeaderView.h"
#import "TaoBaoViewController.h"
#import "PinDuoDuoViewController.h"

@interface TopViewController ()

@property (nonatomic, strong) TopHeaderView *headerView;
@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UIView *view2;

@end

@implementation TopViewController

- (TopHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[TopHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, KScreenWidth, iPhoneX_Top);
        
        MJWeakSelf
        _headerView.taoBaoBtnClickBlock = ^{
            
            __strong TopViewController *strongSelf = weakSelf;
            [strongSelf.view bringSubviewToFront:strongSelf.view1];
        };
        
        _headerView.pinDuoDuoBtnClickBlock = ^{
            
            __strong TopViewController *strongSelf = weakSelf;
            [strongSelf.view bringSubviewToFront:strongSelf.view2];
        };
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.headerView];
    
    TaoBaoViewController *vc1 = [[TaoBaoViewController alloc] init];
    [self addChildViewController:vc1];
    
    PinDuoDuoViewController *vc2 = [[PinDuoDuoViewController alloc] init];
    [self addChildViewController:vc2];
    
    self.view1 = vc1.view;
    self.view2 = vc2.view;
    
    [self.view addSubview:vc2.view];
    [self.view addSubview:vc1.view];
    
    vc1.view.frame = CGRectMake(0, iPhoneX_Top, kScreenWidth, KScreenHeight - iPhoneX_Top);
    vc2.view.frame = CGRectMake(0, iPhoneX_Top, kScreenWidth, KScreenHeight - iPhoneX_Top);
    
    
}


@end
