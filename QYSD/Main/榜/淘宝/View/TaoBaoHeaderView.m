//
//  TaoBaoHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TaoBaoHeaderView.h"

@interface TaoBaoHeaderView ()

@property (nonatomic, strong) UIButton *btnOne;
@property (nonatomic, strong) UIButton *btnTwo;

@end

@implementation TaoBaoHeaderView

- (UIButton *)btnOne{
    
    if (!_btnOne) {
        
        _btnOne = [[UIButton alloc] init];
        _btnOne.backgroundColor = BaseBackGroundColor;
        _btnOne.layer.cornerRadius = 14;
        [_btnOne setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnOne setTitle:@"两小时疯抢" forState:UIControlStateNormal];
        _btnOne.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnOne setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btnOne setTitleColor:ThemColor forState:UIControlStateSelected];
        [_btnOne addTarget:self action:@selector(onBtnOne:) forControlEvents:UIControlEventTouchUpInside];
        _btnOne.selected = YES;
        _btnOne.userInteractionEnabled = NO;
    }
    return _btnOne;
}

- (void)onBtnOne:(UIButton *)sender{

    self.btnTwo.selected = NO;
    self.btnTwo.userInteractionEnabled = YES;
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    if (self.btnOneBlock) {
        
        self.btnOneBlock();
    }
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
}

- (UIButton *)btnTwo{
    
    if (!_btnTwo) {
        
        _btnTwo = [[UIButton alloc] init];
        _btnTwo.backgroundColor = BaseBackGroundColor;
        _btnTwo.layer.cornerRadius = 14;
        [_btnTwo setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btnTwo setTitle:@"全天榜单" forState:UIControlStateNormal];
        _btnTwo.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnTwo setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btnTwo setTitleColor:ThemColor forState:UIControlStateSelected];
        [_btnTwo addTarget:self action:@selector(onBtnTwo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTwo;
}

- (void)onBtnTwo:(UIButton *)sender{
    
    self.btnOne.selected = NO;
    self.btnOne.userInteractionEnabled = YES;
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
    if (self.btnTwoBlock) {
        
        self.btnTwoBlock();
    }
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.btnOne];
        [self addSubview:self.btnTwo];
//        [self.btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(14);
//            make.width.mas_equalTo(120);
//            make.height.mas_equalTo(28);
//            make.centerY.equalTo(self);
//        }];
//
//        [self.btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.btnOne.mas_right).offset(28);
//            make.width.mas_equalTo(120);
//            make.height.mas_equalTo(28);
//            make.centerY.equalTo(self);
//        }];
        
        NSArray *tolAry = @[self.btnOne, self.btnTwo];
        
        CGFloat space = (KScreenWidth - 120 * 2 - 20)/2;
        //水平方向宽度固定等间隔
            [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:120 leadSpacing:space tailSpacing:space];
            [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@28);
                make.centerY.equalTo(self);
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


- (void)setBtnOneTitle:(NSString *)btnOneTitle{
    
    [self.btnOne setTitle:btnOneTitle forState:UIControlStateNormal];
}

- (void)setBtnTwoTitle:(NSString *)btnTwoTitle{
    
    [self.btnTwo setTitle:btnTwoTitle forState:UIControlStateNormal];
}
@end
