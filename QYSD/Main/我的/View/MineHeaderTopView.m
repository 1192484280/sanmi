//
//  MineHeaderTopView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/15.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderTopView.h"
#import "SetViewController.h"
#import "SMNewsViewController.h"
#import "IncomeRankingViewController.h"
#import "LoginMainViewController.h"
#import "UserModel.h"
#import "SetViewController.h"

@interface MineHeaderTopView ()

@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, strong) UILabel *nameLa;
@property (nonatomic, strong) UIImageView *leveIm;
@property (nonatomic, strong) UILabel *codeLa1;
@property (nonatomic, strong) UILabel *codeLa;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) JTImageButton *leftBtn;
@property (nonatomic, strong) JTImageButton *rightBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation MineHeaderTopView

- (UIButton *)headerBtn{
    
    if (!_headerBtn) {
        
        _headerBtn = [[UIButton alloc] init];
        _headerBtn.layer.cornerRadius  = 27.5;
        _headerBtn.layer.masksToBounds = YES;
        [_headerBtn setImage:[UIImage imageNamed:@"img_mineHeaderIm"] forState:UIControlStateNormal];
        [_headerBtn addTarget:self action:@selector(onUser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}

- (void)onUser{
    
    if (![SMUserGuid isValid]) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    SetViewController *vc = [[SetViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}

- (UILabel *)nameLa{
    
    if (!_nameLa) {
        
        _nameLa = [[UILabel alloc] init];
        _nameLa.text = @"登录";
        _nameLa.font = [UIFont boldSystemFontOfSize:20];
        _nameLa.textColor = UIColor.whiteColor;
        _nameLa.userInteractionEnabled = YES;
        _nameLa.textAlignment = NSTextAlignmentLeft;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onUser)];
        [_nameLa addGestureRecognizer:tap];
    }
    return _nameLa;
}

- (UIImageView *)leveIm{
    
    if (!_leveIm) {
        
        _leveIm = [[UIImageView alloc] init];
        _leveIm.image = [UIImage imageNamed:@"合伙人"];
    }
    return _leveIm;
}

- (UILabel *)codeLa1{
    
    if (!_codeLa1) {
        
        _codeLa1 = [[UILabel alloc] init];
        _codeLa1.text = @"省钱密令：";
        _codeLa1.textColor = UIColor.whiteColor;
        _codeLa1.font = [UIFont systemFontOfSize:13];
    }
    return _codeLa1;
}

- (UILabel *)codeLa{
    
    if (!_codeLa) {
        
        _codeLa = [[UILabel alloc] init];
        _codeLa.text = @"asdfghjk";
        _codeLa.textColor = UIColor.whiteColor;
        _codeLa.font = [UIFont boldSystemFontOfSize:13];
    }
    return _codeLa;
}

- (JTImageButton *)leftBtn{
    
    if (!_leftBtn) {
        
        _leftBtn = [[JTImageButton alloc] init];
        [_leftBtn createTitle:@"收入排行" withIcon:[UIImage imageNamed:@"img_srph"] font:[UIFont systemFontOfSize:14] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _leftBtn.borderWidth = 0.0;
        _leftBtn.titleColor = UIColor.whiteColor;
        _leftBtn.iconSide = JTImageButtonIconSideLeft;
        _leftBtn.padding = JTImageButtonPaddingNone;
        [_leftBtn addTarget:self action:@selector(onLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (void)onLeftBtn:(UIButton *)sender{
    
    IncomeRankingViewController *vc = [[IncomeRankingViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColor.whiteColor;
    }
     return _line;
}

- (JTImageButton *)rightBtn{
    
    if (!_rightBtn) {
        
        _rightBtn = [[JTImageButton alloc] init];
        [_rightBtn createTitle:@"云发单" withIcon:[UIImage imageNamed:@"img_yfd"] font:[UIFont systemFontOfSize:14] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _rightBtn.borderWidth = 0.0;
        _rightBtn.titleColor = UIColor.whiteColor;
        _rightBtn.iconSide = JTImageButtonIconSideLeft;
        _rightBtn.padding = JTImageButtonPaddingNone;
        [_rightBtn addTarget:self action:@selector(onRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)onRightBtn:(UIButton *)sender{
    
    
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
    
    if (![SMUserGuid isValid]) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    SetViewController *vc = [[SetViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [self addSubview:self.headerBtn];
        [self addSubview:self.nameLa];
//        [self addSubview:self.leveIm];
//        [self addSubview:self.codeLa1];
//        [self addSubview:self.codeLa];
//        [self addSubview:self.signInBtn];
//        [self addSubview:self.newsBtn];
        [self addSubview:self.setBtn];
//        [self addSubview:self.leftBtn];
//        [self addSubview:self.line];
//        [self addSubview:self.rightBtn];
        
        CGFloat marign = 10;
        CGFloat space = 14;
        [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(STATUS_BAR_HEIGHT + space);
            make.width.height.mas_equalTo(55);
        }];
        
        [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerBtn.mas_top);
            make.right.mas_equalTo(-space);
            make.width.height.mas_equalTo(27);
        }];
        
        [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerBtn.mas_right).offset(marign);
            make.centerY.equalTo(self.headerBtn);
            make.right.equalTo(self.setBtn.mas_left).offset(-50);
        }];

//        [self.leveIm mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.headerBtn.mas_right).offset(marign);
//            make.bottom.equalTo(self.headerBtn.mas_bottom);
//            make.height.mas_equalTo(22);
//            make.width.mas_equalTo(65);
//        }];
//
//        [self.codeLa1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.leveIm.mas_right).offset(marign);
//            make.centerY.equalTo(self.leveIm);
//        }];
//
//        [self.codeLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.codeLa1.mas_right);
//            make.centerY.equalTo(self.leveIm);
//        }];

        

//        [self.newsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.headerBtn.mas_top);
//            make.right.equalTo(self.setBtn.mas_left).offset(-2);
//            make.width.height.mas_equalTo(27);
//        }];
//
//        [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.headerBtn.mas_top);
//            make.right.equalTo(self.newsBtn.mas_left).offset(-2);
//            make.width.height.mas_equalTo(27);
//        }];
//
//        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.headerBtn.mas_bottom).offset(space);
//            make.left.equalTo(self.headerBtn.mas_centerX);
//            make.height.mas_equalTo(25);
//        }];

//        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.leftBtn.mas_right).offset(20);
//            make.height.mas_equalTo(15);
//            make.centerY.equalTo(self.leftBtn);
//            make.width.mas_equalTo(1);
//        }];

//        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.headerBtn.mas_bottom).offset(space);
//            make.left.equalTo(self.line.mas_right).offset(20);
//            make.height.mas_equalTo(25);
//        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"LoginOutSuccess" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadData{
    
    self.nameLa.text = @"登录";
    [self.headerBtn setImage:[UIImage imageNamed:@"img_mineHeaderIm"] forState:UIControlStateNormal];
}

- (void)setModel:(UserModel *)model{
    
    self.nameLa.text = model.Nickname;
    [self.headerBtn sd_setImageWithURL:model.HeadImgUrl.mj_url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder_2"]];
}
@end
