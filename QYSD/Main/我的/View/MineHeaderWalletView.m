//
//  MineHeaderWalletView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/15.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderWalletView.h"
#import "WKWebViewController.h"

@interface MineHeaderWalletView ()

@property (nonatomic, strong) JTImageButton *titleBtn;
@property (nonatomic, strong) JTImageButton *oneWallectBtn;
@property (nonatomic, strong) JTImageButton *twoWallectBtn;
@property (nonatomic, strong) UILabel *balanceLa;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *hadTiXianLa;
@property (nonatomic, strong) UILabel *hadTiXianNumLa;

@property (nonatomic, strong) UILabel *hadSaveLa;
@property (nonatomic, strong) JTImageButton *hadSaveMoneyBtn;

@end

@implementation MineHeaderWalletView

- (JTImageButton *)hadSaveMoneyBtn{
    
    if (!_hadSaveMoneyBtn) {
        
        _hadSaveMoneyBtn = [[JTImageButton alloc] init];
        [_hadSaveMoneyBtn createTitle:@"¥ 0.00" withIcon:[UIImage imageNamed:@"img_minehadsaveIm"] font:[UIFont fontWithName:@"ArialMT"size:15] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _hadSaveMoneyBtn.borderWidth = 0.0;
        _hadSaveMoneyBtn.titleColor = UIColor.darkGrayColor;
        _hadSaveMoneyBtn.iconSide = JTImageButtonIconSideRight;
        _hadSaveMoneyBtn.padding = JTImageButtonPaddingMedium;
        [_hadSaveMoneyBtn addTarget:self action:@selector(onHadSaveMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hadSaveMoneyBtn;
}

- (void)onHadSaveMoneyBtn:(UIButton *)sender{
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (UILabel *)hadSaveLa{
    
    if (!_hadSaveLa) {
        _hadSaveLa = [[UILabel alloc] init];
        _hadSaveLa.attributedText = [NSString getAttributedWithString:@"累计省钱" WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
        
    }
    return _hadSaveLa;
}

- (UILabel *)hadTiXianNumLa{
    
    if (!_hadTiXianNumLa) {
        _hadTiXianNumLa = [[UILabel alloc] init];
        _hadTiXianNumLa.font = [UIFont fontWithName:@"ArialMT"size:15];
        _hadSaveLa.textColor = UIColor.darkGrayColor;
    }
    return _hadTiXianNumLa;
}

- (UILabel *)hadTiXianLa{
    
    if (!_hadTiXianLa) {
        _hadTiXianLa = [[UILabel alloc] init];
        _hadTiXianLa.attributedText = [NSString getAttributedWithString:@"累计提现" WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
       
    }
    return _hadTiXianLa;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = BaseBackGroundColor;
    }
    return _line;
}

- (UILabel *)balanceLa{
    
    if (!_balanceLa) {
        
        _balanceLa = [[UILabel alloc] init];
        _balanceLa.attributedText  = [NSString getAttributedWithString:@"0.00" WithLineSpace:0 kern:0 font:[UIFont boldSystemFontOfSize:25] color:FontColor];
    }
    return _balanceLa;
}

- (JTImageButton *)oneWallectBtn{
    
    if (!_oneWallectBtn) {
        
        _oneWallectBtn = [[JTImageButton alloc] init];
        [_oneWallectBtn createTitle:@"1号钱包" withIcon:nil font:[UIFont systemFontOfSize:14] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _oneWallectBtn.borderColor = [UIColor colorWithHexString:@"FA6400"];
        _oneWallectBtn.titleColor = [UIColor colorWithHexString:@"FA6400"];
        _oneWallectBtn.cornerRadius = 5;
        [_oneWallectBtn addTarget:self action:@selector(onOneWallectBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _oneWallectBtn;
}

- (void)onOneWallectBtn:(UIButton *)sender{
    
    [self.viewController.view makeToast:@"点击1号钱包" duration:1.0 position:CSToastPositionBottom];
}

- (JTImageButton *)twoWallectBtn{
    
    if (!_twoWallectBtn) {
        
        _twoWallectBtn = [[JTImageButton alloc] init];
        [_twoWallectBtn createTitle:@"2号钱包" withIcon:nil font:[UIFont systemFontOfSize:14] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _twoWallectBtn.borderColor = [UIColor colorWithHexString:@"32C5FF"];
        _twoWallectBtn.titleColor = [UIColor colorWithHexString:@"32C5FF"];
        _twoWallectBtn.cornerRadius = 5;
        [_twoWallectBtn addTarget:self action:@selector(onTwoWallectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoWallectBtn;
}

- (void)onTwoWallectBtn:(UIButton *)sender{
    
    [self.viewController.view makeToast:@"点击2号钱包" duration:1.0 position:CSToastPositionBottom];
}

- (JTImageButton *)titleBtn{
    
    if (!_titleBtn) {
        
        _titleBtn = [[JTImageButton alloc] init];
        [_titleBtn createTitle:@"钱包余额" withIcon:[UIImage imageNamed:@"img_mineWenHao"] font:[UIFont systemFontOfSize:14] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
         _titleBtn.borderWidth = 0.0;
          _titleBtn.titleColor = FontColor;
          _titleBtn.iconSide = JTImageButtonIconSideRight;
         _titleBtn.padding = JTImageButtonPaddingMedium;
        [_titleBtn addTarget:self action:@selector(onTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}

- (void)onTitleBtn:(UIButton *)sender{
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 5;
    
        CGFloat margin = 10.0f;
        CGFloat space = 14.0f;
        
        [self addSubview:self.titleBtn];
        [self addSubview:self.twoWallectBtn];
        [self addSubview:self.oneWallectBtn];
        [self addSubview:self.balanceLa];
        [self addSubview:self.line];
        [self addSubview:self.hadTiXianLa];
        [self addSubview:self.hadTiXianNumLa];
        [self addSubview:self.hadSaveLa];
        [self addSubview:self.hadSaveMoneyBtn];
        
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(space);
            make.height.mas_equalTo(22);
        }];
        
//        [self.twoWallectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-space);
//            make.centerY.equalTo(self.titleBtn);
//            make.width.mas_equalTo(75);
//            make.height.mas_equalTo(22);
//        }];
//
//        [self.oneWallectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.twoWallectBtn.mas_left).offset(-margin);
//            make.centerY.equalTo(self.titleBtn);
//            make.width.mas_equalTo(75);
//            make.height.mas_equalTo(22);
//        }];
        
        [self.balanceLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleBtn);
            make.top.equalTo(self.titleBtn.mas_bottom).offset(5);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(self.balanceLa.mas_bottom).offset(margin);
        }];
        
        [self.hadTiXianLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleBtn);
            make.top.equalTo(self.line.mas_bottom).offset(space);
        }];
        
        [self.hadTiXianNumLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hadTiXianLa.mas_right).offset(margin);
            make.centerY.equalTo(self.hadTiXianLa);
        }];
        
        [self.hadSaveLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.hadTiXianLa);
        }];
        
        [self.hadSaveMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hadSaveLa.mas_right).offset(margin);
            make.centerY.equalTo(self.hadTiXianLa);
        }];
    }
    return self;
}


@end
