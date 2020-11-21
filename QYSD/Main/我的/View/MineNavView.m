//
//  MineNavView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/17.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineNavView.h"
#import "SetViewController.h"
#import "SMNewsViewController.h"

@interface MineNavView ()

@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UILabel *nameLa;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIButton *setBtn;

@end

@implementation MineNavView

- (UIButton *)headerBtn{
    
    if (!_headerBtn) {
        
        _headerBtn = [[UIButton alloc] init];
        _headerBtn.layer.cornerRadius  = 17.5;
        _headerBtn.layer.masksToBounds = YES;
        [_headerBtn setImage:[UIImage imageNamed:@"img_mineHeaderIm"] forState:UIControlStateNormal];
        [_headerBtn addTarget:self action:@selector(onHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}

- (void)onHeaderBtn:(UIButton *)sender{
    
    [self.viewController.view makeToast:@"点击头像" duration:2.0 position:CSToastPositionBottom];
}

- (UILabel *)nameLa{
    
    if (!_nameLa) {
        
        _nameLa = [[UILabel alloc] init];
        _nameLa.text = @"登录/注册";
        _nameLa.font = [UIFont boldSystemFontOfSize:17];
        _nameLa.textColor = UIColor.whiteColor;
    }
    return _nameLa;
}

- (UIButton *)signInBtn{
    
    if (!_signInBtn) {
        
        _signInBtn = [[UIButton alloc] init];
        [_signInBtn setImage:[UIImage imageNamed:@"签到"] forState:UIControlStateNormal];
        [_signInBtn addTarget:self action:@selector(onSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInBtn;
}

- (void)onSignInBtn:(UIButton *)sender{
    
    [self.viewController.view makeToast:@"点击签到" duration:2.0 position:CSToastPositionBottom];
}

- (UIButton *)newsBtn{
    
    if (!_newsBtn) {
        
        _newsBtn = [[UIButton alloc] init];
        [_newsBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
        [_newsBtn addTarget:self action:@selector(onNewsBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newsBtn;
}

- (void)onNewsBtn:(UIButton *)sender{
    
    SMNewsViewController *vc = [[SMNewsViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)setBtn{
    
    if (!_setBtn) {
        
        _setBtn = [[UIButton alloc] init];
        [_setBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(onSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

- (void)onSetBtn:(UIButton *)sender{
    
    SetViewController *vc = [[SetViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [self addSubview:self.headerBtn];
        [self addSubview:self.nameLa];
//        [self addSubview:self.signInBtn];
//        [self addSubview:self.newsBtn];
        [self addSubview:self.setBtn];
        
        CGFloat marign = 10;
        CGFloat space = 14;
        [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.bottom.mas_equalTo(-5);
            make.width.height.mas_equalTo(35);
        }];
        
        [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerBtn.mas_right).offset(marign);
            make.centerY.equalTo(self.headerBtn);
        }];
        
        [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headerBtn);
            make.right.mas_equalTo(-space);
            make.width.height.mas_equalTo(27);
        }];
        
//        [self.newsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.headerBtn);
//            make.right.equalTo(self.setBtn.mas_left).offset(-2);
//            make.width.height.mas_equalTo(27);
//        }];
//
//        [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.headerBtn);
//            make.right.equalTo(self.newsBtn.mas_left).offset(-2);
//            make.width.height.mas_equalTo(27);
//        }];
        
    }
    return self;
}

@end
