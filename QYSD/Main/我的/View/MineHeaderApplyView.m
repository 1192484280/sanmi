//
//  MineHeaderApplyView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/15.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderApplyView.h"
#import "WKWebViewController.h"

@interface MineHeaderApplyView ()

@property (nonatomic, strong) UIImageView *bgIm;
@property (nonatomic, strong) UIImageView *logoIm;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UIButton *applyBtn;
@property (nonatomic, strong) UILabel *desLa;

@end

@implementation MineHeaderApplyView

- (UIImageView *)bgIm{
    
    if (!_bgIm) {
        
        _bgIm = [[UIImageView alloc] init];
        _bgIm.image = [UIImage imageNamed:@"img_applyBgImg"];
    }
    return _bgIm;
}

- (UIImageView *)logoIm{
    
    if (!_logoIm) {
        
        _logoIm = [[UIImageView alloc] init];
        _logoIm.image = [UIImage imageNamed:@"团长"];
    }
    return _logoIm;
}

- (UILabel *)titleLa{
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text  = @"晋升团长";
        _titleLa.font = [UIFont boldSystemFontOfSize:18];
        _titleLa.textColor = [UIColor colorWithHexString:@"F5DF9D"];
    }
    return _titleLa;
}

- (UIButton *)applyBtn{
    
    if (!_applyBtn) {
        
        _applyBtn = [[UIButton alloc] init];
        [_applyBtn setImage:[UIImage imageNamed:@"img_Mine_apply"] forState:UIControlStateNormal];
        [_applyBtn addTarget:self action:@selector(onApplyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}

- (void)onApplyBtn:(UIButton *)sender{
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        _desLa.text  = @"平台奖励+团队奖励";
        _desLa.textColor = [UIColor colorWithHexString:@"F5DF9D"];
    }
    return _desLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.bgIm];
        [self addSubview:self.logoIm];
        [self addSubview:self.titleLa];
        [self addSubview:self.applyBtn];
        [self addSubview:self.desLa];
        
        [self.bgIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [self.logoIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(14);
            make.width.height.mas_equalTo(30);
        }];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoIm.mas_right).offset(10);
            make.centerY.equalTo(self.logoIm);
        }];
        
        [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-14);
            make.centerY.equalTo(self.logoIm);
            make.height.mas_equalTo(20);
            make.height.mas_equalTo(75);
        }];
        
        [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-14);
            make.bottom.equalTo(self).offset(-14);
        }];
        
    }
    return self;
}

@end
