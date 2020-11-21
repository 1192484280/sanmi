//
//  BaseNavView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "IncomeRankingNavView.h"

@interface IncomeRankingNavView ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLa;
@end

@implementation IncomeRankingNavView

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"img_proBackwhite"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)onBackBtn:(UIButton *)sender{
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"收入排行";
        _titleLa.textColor = UIColor.whiteColor;
    }
    return _titleLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLa];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(35);
        }];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self->_backBtn);
            
        }];
        
    }
    return self;
}

@end

