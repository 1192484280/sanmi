//
//  PopCopyTKLView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/10/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PopCopyTKLView.h"

@interface PopCopyTKLView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *im;

@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UILabel *contentLa;

@property (nonatomic, copy) NSString *theCopyText;

@end

@implementation PopCopyTKLView

- (UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"领券购买" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        _searchBtn.layer.cornerRadius = 17.5;
        _searchBtn.layer.masksToBounds = YES;
    }
    return _searchBtn;
}

#pragma mark - 点击搜索
- (void)onSearchBtn:(UIButton *)sender{
    
    if (self.searchBlock) {
        
        self.searchBlock(self.theCopyText);
    }
}

- (UIView *)bottomBgView{
    
    if (!_bottomBgView) {
        
        _bottomBgView = [[UIView alloc] init];
        _bottomBgView.backgroundColor = UIColor.whiteColor;
//        _bottomBgView.layer.cornerRadius = 10;
        
        [_bottomBgView addSubview:self.searchBtn];
        [_bottomBgView addSubview:self.contentLa];
        
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(35);
        }];
        
        [self.contentLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.bottom.equalTo(self.searchBtn.mas_top).offset(-15);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(10);
        }];
    }
    return _bottomBgView;
}

- (UILabel *)contentLa{
    
    if (!_contentLa) {
        
        _contentLa = [[UILabel alloc] init];
        _contentLa.text = self.theCopyText;
        _contentLa.textColor = FontColor;
        _contentLa.font = [UIFont systemFontOfSize:13];
        _contentLa.backgroundColor = UIColor.whiteColor;
        _contentLa.numberOfLines = 0;
    }
    return _contentLa;
}

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
//        _im.layer.cor
        _im.contentMode =  UIViewContentModeScaleAspectFill;
        _im.clipsToBounds  = YES;
        _im.image = [UIImage imageNamed:@"img_sdPlaceHoder"];
        NSString *img = [[NSUserDefaults standardUserDefaults] objectForKey:@"TKLIMG"];
        [_im sd_setImageWithURL:img.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"TKLIMG"];
    }
    return _im;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"popCopyClose"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(onCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)onCloseBtn:(UIButton *)sender{
    
    if (self.closeBlock) {
        
        self.closeBlock();
    }
}
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
    
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
        
        [_bgView addSubview:self.im];
        
        [_bgView addSubview:self.bottomBgView];
        
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(KScreenWidth * 0.7);
        }];
        
        [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.im.mas_bottom).offset(-10);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _bgView;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _theCopyText = title;
        
         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.bgView];
        [self addSubview:self.closeBtn];
        
        CGFloat width = KScreenWidth * 0.7;
        CGFloat height = width + [title heightForFont:[UIFont systemFontOfSize:13] width:width] + 55 + 25;
        if (height > KScreenHeight * 0.8) {

            height = KScreenHeight * 0.8;
        }
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.center.equalTo(self);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bgView.mas_bottom).offset(15);
            make.width.height.mas_equalTo(30);
        }];
    }
    return self;
}

@end
