//
//  MineHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/15.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineHeaderApplyView.h"
#import "MineHeaderWalletView.h"
#import "MineHeaderSliderView.h"
#import "MineHeaderDataView.h"
#import "MineHeaderDetailedView.h"
#import "MineHeaderToolView.h"
@interface MineHeaderView ()

@property (nonatomic, strong) MineHeaderApplyView *applyView;
@property (nonatomic, strong) MineHeaderWalletView *walletView;
@property (nonatomic, strong) MineHeaderSliderView *sliderView;
@property (nonatomic, strong) MineHeaderDataView *dataView;
@property (nonatomic, strong) MineHeaderDetailedView *detailedView;
@property (nonatomic, strong) MineHeaderToolView *toolView;
@end

@implementation MineHeaderView

- (MineHeaderDetailedView *)detailedView{
    
    if (!_detailedView) {
        
        _detailedView = [[MineHeaderDetailedView alloc] init];
        _detailedView.layer.cornerRadius = 10;
        _detailedView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        _detailedView.layer.shadowOpacity = 0.1f;
        _detailedView.layer.shadowRadius = 0.5f;
        _detailedView.layer.shadowOffset = CGSizeMake(1,1);

    }
    return _detailedView;
}

- (MineHeaderToolView *)toolView{
    
    if (!_toolView) {
        
        _toolView = [[MineHeaderToolView alloc] init];
        _toolView.layer.cornerRadius = 10;
        _toolView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolView.layer.shadowOpacity = 0.2f;
        _toolView.layer.shadowRadius = 4.f;
        _toolView.layer.shadowOffset = CGSizeMake(1,1);
    }
    return _toolView;
}

- (MineHeaderDataView *)dataView{
    
    if (!_dataView) {
        
        _dataView = [[MineHeaderDataView alloc] init];
    }
    return _dataView;
}

- (MineHeaderSliderView *)sliderView{
    
    if (!_sliderView) {
        
        _sliderView = [[MineHeaderSliderView alloc] init];
    }
    return _sliderView;
}

- (MineHeaderWalletView *)walletView{
    
    if (!_walletView) {
        
        _walletView = [[MineHeaderWalletView alloc] init];
    }
    return _walletView;
}

- (MineHeaderApplyView *)applyView{
    
    if (!_applyView) {
        
        _applyView = [[MineHeaderApplyView alloc] init];
    }
    return _applyView;
}

- (MineHeaderTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[MineHeaderTopView alloc] init];
    }
    return _topView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.topView];
        [self addSubview:self.detailedView];
        [self addSubview:self.toolView];
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(STATUS_BAR_HEIGHT + 130);
        }];
        
        CGFloat itemW = (KScreenWidth - 50) / 2;
        CGFloat itemH = itemW * 0.4;
        CGFloat detail_h = itemH + 30 + 20 + 14;
        [self.detailedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(detail_h);
            make.top.equalTo(self.topView.mas_bottom).offset(-25);
        }];
        
        [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(130);
            make.top.equalTo(self.detailedView.mas_bottom).offset(10);
        }];
        
//        [self addSubview:self.topView];
//        [self addSubview:self.applyView];
//        [self addSubview:self.walletView];
//        [self addSubview:self.sliderView];
//        [self addSubview:self.dataView];
//        [self addSubview:self.detailedView];
//        [self addSubview:self.toolView];
//
//        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.mas_equalTo(0);
//            make.height.mas_equalTo(STATUS_BAR_HEIGHT + 130);
//        }];
//
//        [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(90);
//            make.top.equalTo(self.topView.mas_bottom).offset(-15);
//        }];
//
//        [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(135);
//            make.top.equalTo(self.applyView.mas_bottom).offset(10);
//        }];
//
//        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(70);
//            make.top.equalTo(self.walletView.mas_bottom).offset(10);
//        }];
//
//        [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(140);
//            make.top.equalTo(self.sliderView.mas_bottom).offset(10);
//        }];
//
//        [self.detailedView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(120);
//            make.top.equalTo(self.dataView.mas_bottom).offset(10);
//        }];
//
//        [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.right.mas_equalTo(-10);
//            make.height.mas_equalTo(268);
//            make.top.equalTo(self.detailedView.mas_bottom).offset(10);
//        }];
    }
    return self;
}

@end
