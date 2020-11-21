//
//  PopCopyView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PopCopyView.h"

@interface PopCopyView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *im;

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *desLa;
@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UILabel *contentLa;

@property (nonatomic, copy) NSString *theCopyText;

@end

@implementation PopCopyView

- (UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"搜天猫/淘宝" forState:UIControlStateNormal];
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
        _bottomBgView.layer.cornerRadius = 10;
        
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

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"为您搜索闪蜜优惠券";
        _titleLa.textColor = UIColor.whiteColor;
        _titleLa.font = [UIFont boldSystemFontOfSize:20];
        _titleLa.adjustsFontSizeToFitWidth = YES;
        _titleLa.textAlignment = NSTextAlignmentCenter;
        _titleLa.layer.shadowColor = [UIColor blackColor].CGColor;
        _titleLa.layer.shadowOpacity = 0.2f;
        _titleLa.layer.shadowRadius = 4.f;
        _titleLa.layer.shadowOffset = CGSizeMake(1,1);

    }
    return _titleLa;
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        _desLa.text = @"您是否要搜索以下产品";
        _desLa.textColor = UIColor.whiteColor;
        _desLa.font = [UIFont boldSystemFontOfSize:15];
        _desLa.adjustsFontSizeToFitWidth = YES;
        _desLa.textAlignment = NSTextAlignmentCenter;
        _desLa.layer.shadowColor = [UIColor blackColor].CGColor;
        _desLa.layer.shadowOpacity = 0.2f;
        _desLa.layer.shadowRadius = 4.f;
        _desLa.layer.shadowOffset = CGSizeMake(1,1);
    }
    return _desLa;
}


- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"popCopyTopIm"];
        
        [_im addSubview:self.titleLa];
        [_im addSubview:self.desLa];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(15);
        }];
        
        [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.equalTo(self.titleLa.mas_bottom).mas_equalTo(5);
        }];
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
    
        [_bgView addSubview:self.im];
        
        [_bgView insertSubview:self.bottomBgView belowSubview:self.im];
        
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(100);
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
        CGFloat height = 95 + [title heightForFont:[UIFont systemFontOfSize:13] width:width] + 65 + 45;
        if (height > 250) {
            
            height = 250;
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
