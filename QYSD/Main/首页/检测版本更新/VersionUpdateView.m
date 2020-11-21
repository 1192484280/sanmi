//
//  VersionUpdateView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "VersionUpdateView.h"

#define APPID @"1480822497"

@interface VersionUpdateView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *im;

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UILabel *contentLa;

@property (nonatomic, copy) NSAttributedString *theCopyText;

@end

@implementation VersionUpdateView

- (UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        _searchBtn.layer.cornerRadius = 15;
        _searchBtn.layer.masksToBounds = YES;
    }
    return _searchBtn;
}

#pragma mark - 点击搜索
- (void)onSearchBtn:(UIButton *)sender{
    
     NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APPID];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
    if (self.closeBlock) {
        
        self.closeBlock();
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
        _contentLa.numberOfLines = 0;
//        _contentLa.showsVerticalScrollIndicator = NO;
//        NSMutableAttributedString *text = [NSMutableAttributedString new];
//        UIFont *font = [UIFont systemFontOfSize:13];
//        [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.theCopyText] attributes:nil]];
//
//        text.yy_lineSpacing = 5;
//        text.yy_color = UIColor.darkGrayColor;
//        //        text.yy_kern = @0.5;
//        text.yy_font = font;
        _contentLa.attributedText = self.theCopyText;
//        _contentLa.editable = NO;
//        _contentLa.textColor = UIColor.blackColor;
//        _contentLa.font = [UIFont boldSystemFontOfSize:13];
//        _contentLa.backgroundColor = UIColor.whiteColor;
//        _contentLa.numberOfLines = 0;
    }
    return _contentLa;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"发现新版本";
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


- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"popCopyTopIm"];
        
        [_im addSubview:self.titleLa];
//        [_im addSubview:self.desLa];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self->_im);
        }];
        
//        [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.top.equalTo(self.titleLa.mas_bottom).mas_equalTo(5);
//        }];
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

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSAttributedString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _theCopyText = title;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.bgView];
        [self addSubview:self.closeBtn];
        
        CGFloat min_w = KScreenWidth * 0.7;

        CGFloat min_h =  [NSString getAttHeightWithStr:title min_w:min_w];
        
//        CGFloat width = KScreenWidth * 0.6;
        CGFloat height = 100 + min_h + 20 + 50;
        if (height > KScreenHeight * 0.65) {
            
            height = KScreenHeight * 0.65;
        }
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(min_w);
            make.height.mas_equalTo(height);
            make.center.equalTo(self);
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bgView.mas_bottom).offset(20);
            make.width.height.mas_equalTo(30);
        }];
    }
    return self;
}

@end
