//
//  ProductHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/21.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductHeaderView.h"
#import "PopoverAction.h"
#import "PopoverView.h"
#import "HeaderViewController.h"
#import "HeaderSearchViewController.h"
#import "ContactCustomerServiceViewController.h"
@interface ProductHeaderView ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *kefuBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation ProductHeaderView

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"img_proBack"] forState:UIControlStateNormal];
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
        [_kefuBtn setImage:[UIImage imageNamed:@"icon_kefu拷贝"] forState:UIControlStateNormal];
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
        [_moreBtn setImage:[UIImage imageNamed:@"more拷贝"] forState:UIControlStateNormal];
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

- (UIButton *)baobeiBtn{
    
    if (!_baobeiBtn) {
        
        _baobeiBtn = [[UIButton alloc] init];
        [_baobeiBtn setTitle:@"宝贝" forState:UIControlStateNormal];
        _baobeiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_baobeiBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
        [_baobeiBtn addTarget:self action:@selector(onBaobeiBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _baobeiBtn;
}

- (void)onBaobeiBtn:(UIButton *)sender{
    
    [sender setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [self.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    if (self.onBaoBeiBtnBlock) {
        
        self.onBaoBeiBtnBlock();
    }
}

- (UIButton *)xiangqingBtn{
    
    if (!_xiangqingBtn) {
        
        _xiangqingBtn = [[UIButton alloc] init];
        [_xiangqingBtn setTitle:@"详情" forState:UIControlStateNormal];
        _xiangqingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_xiangqingBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_xiangqingBtn addTarget:self action:@selector(onXiangqingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xiangqingBtn;
}

- (void)onXiangqingBtn:(UIButton *)sender{
    
    [sender setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [self.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    if (self.onXiangQingBtnBlock) {
        
        self.onXiangQingBtnBlock();
    }
}

- (UIButton *)tuijianBtn{
    
    if (!_tuijianBtn) {
        
        _tuijianBtn = [[UIButton alloc] init];
        [_tuijianBtn setTitle:@"推荐" forState:UIControlStateNormal];
        _tuijianBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_tuijianBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_tuijianBtn addTarget:self action:@selector(onTuijianBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tuijianBtn;
}

- (void)onTuijianBtn:(UIButton *)sender{
    
    [sender setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [self.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    if (self.onTuiJianBtnBlock) {
        
        self.onTuiJianBtnBlock();
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.backBtn];
        [self addSubview:self.baobeiBtn];
        [self addSubview:self.xiangqingBtn];
        [self addSubview:self.tuijianBtn];
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
            make.right.equalTo(self.moreBtn.mas_left);
            make.centerY.equalTo(self->_backBtn);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        [self.xiangqingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self->_backBtn);
            
        }];
        
        [self.baobeiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.xiangqingBtn.mas_left).offset(-25);
            make.centerY.equalTo(self->_backBtn);
            
        }];
        
        [self.tuijianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.xiangqingBtn.mas_right).offset(25);
            make.centerY.equalTo(self->_backBtn);
            
        }];
    }
    return self;
}

@end
