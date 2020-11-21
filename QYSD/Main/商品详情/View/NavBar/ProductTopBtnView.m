//
//  ProductTopBtnView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductTopBtnView.h"
#import "PopoverAction.h"
#import "PopoverView.h"
#import "HeaderSearchViewController.h"
#import "ContactCustomerServiceViewController.h"
@interface ProductTopBtnView ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *kefuBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation ProductTopBtnView

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)onBackBtn:(UIButton *)sender{
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)kefuBtn{
    
    if (!_kefuBtn) {
        
        _kefuBtn = [[UIButton alloc] init];
        [_kefuBtn setImage:[UIImage imageNamed:@"icon_kefu"] forState:UIControlStateNormal];
        [_kefuBtn addTarget:self action:@selector(onKefuBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kefuBtn;
}

- (void)onKefuBtn:(UIButton *)sender{
    
    ContactCustomerServiceViewController *VC = [[ContactCustomerServiceViewController alloc] init];
    [self.viewController.navigationController pushViewController:VC animated:YES];
}

- (UIButton *)moreBtn{
    
    if (!_moreBtn) {
        
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(onMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (void)onMoreBtn:(UIButton *)sender{
    
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"   首页  " handler:^(PopoverAction *action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        
        [self.viewController.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"  搜索  " handler:^(PopoverAction *action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        HeaderSearchViewController *vc = [[HeaderSearchViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    //    popoverView.style = PopoverViewStyleDark;
    [popoverView showToView:sender withActions:@[action1,action2]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.kefuBtn];
        [self addSubview:self.moreBtn];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(35);
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self->_backBtn);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        [self.kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreBtn.mas_left).offset(-8);
            make.centerY.equalTo(self->_backBtn);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        
    }
    return self;
}

@end
