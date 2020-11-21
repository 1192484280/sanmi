//
//  SMMoreDataHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMMoreDataHeaderView.h"

@interface SMMoreDataHeaderView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *moneyLa;

@end
@implementation SMMoreDataHeaderView


- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView addSubview:self.titleLa];
        [_bgView addSubview:self.moneyLa];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.moneyLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLa.mas_right).offset(14);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _bgView;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [UILabel new];
        _titleLa.text = @"今日效果预估";
        _titleLa.font = [UIFont systemFontOfSize:15];
    }
    return _titleLa;
}

- (UILabel *)moneyLa{
    
    if (!_moneyLa) {
        
        _moneyLa = [UILabel new];
        _moneyLa.text = @"¥ 0.00";
        _moneyLa.textColor = ThemColor;
        _moneyLa.font = [UIFont systemFontOfSize:17];
    }
    return _moneyLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 0, 10, 0));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    
    self.titleLa.text = title;
}
@end
