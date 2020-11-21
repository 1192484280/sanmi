//
//  TopHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TopHeaderView.h"

@interface TopHeaderView ()

@property (nonatomic, strong) UIButton *btnOne;
@property (nonatomic, strong) UIButton *btnTwo;

@end

@implementation TopHeaderView

- (UIButton *)btnOne{
    
    if (!_btnOne) {
        
        _btnOne = [[UIButton alloc] init];
        [_btnOne setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnOne setTitle:@"淘宝" forState:UIControlStateNormal];
        _btnOne.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnOne setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btnOne setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_btnOne addTarget:self action:@selector(onBtnOne:) forControlEvents:UIControlEventTouchUpInside];
        _btnOne.selected = YES;
        _btnOne.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _btnOne;
}

- (void)onBtnOne:(UIButton *)sender{
    
    self.btnTwo.selected = NO;
    self.btnTwo.userInteractionEnabled = YES;
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    self.btnTwo.titleLabel.font = [UIFont systemFontOfSize:15];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    if (self.taoBaoBtnClickBlock) {
        
        self.taoBaoBtnClickBlock();
    }
}

- (UIButton *)btnTwo{
    
    if (!_btnTwo) {
        
        _btnTwo = [[UIButton alloc] init];
        [_btnTwo setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnTwo setTitle:@"拼多多" forState:UIControlStateNormal];
        _btnTwo.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnTwo setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btnTwo setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_btnTwo addTarget:self action:@selector(onBtnTwo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTwo;
}

- (void)onBtnTwo:(UIButton *)sender{
    
    self.btnOne.selected = NO;
    self.btnOne.userInteractionEnabled = YES;
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    self.btnOne.titleLabel.font = [UIFont systemFontOfSize:15];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    if (self.pinDuoDuoBtnClickBlock) {
        
        self.pinDuoDuoBtnClickBlock();
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.btnOne];
        [self addSubview:self.btnTwo];
        [self.btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(14);
        }];
        
        [self.btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5);
            make.left.equalTo(self.btnOne.mas_right).offset(20);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BaseBackGroundColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

@end
