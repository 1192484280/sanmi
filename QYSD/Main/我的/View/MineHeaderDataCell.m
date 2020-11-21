//
//  MineHeaderDataCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderDataCell.h"

@interface MineHeaderDataCell ()

@property (nonatomic, strong) UIImageView *im;

@end

@implementation MineHeaderDataCell

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont systemFontOfSize:12];
        _titleLa.text  = @"--";
        _titleLa.textColor = UIColor.grayColor;
    }
    return _titleLa;
}

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"img_mineSMWenHao"];
    }
    return _im;
}


- (UILabel *)numLa{
    
    if (!_numLa) {
        
        _numLa = [[UILabel alloc] init];
        _numLa.font = [UIFont fontWithName:@"ArialMT"size:17];
        _numLa.text  = @"0.00";
    }
    return _numLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLa];
        [self addSubview:self.im];
        [self addSubview:self.numLa];
        
        CGFloat margin = 10.0f;
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(- 5);
            make.top.mas_equalTo(15);
        }];
        
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLa.mas_right).offset(3);
            make.centerY.equalTo(self.titleLa);
        }];
        
        [self.numLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLa.mas_bottom).offset(margin);
        }];
    }
    return self;
}

@end
