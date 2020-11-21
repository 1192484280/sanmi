//
//  RecomendFourYouCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecomendFourYouCell.h"

@interface RecomendFourYouCell ()

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation RecomendFourYouCell

- (UIView *)line1{
    
    if (!_line1) {
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = RightColor;
    }
    return _line1;
}

- (UIView *)line2{
    
    if (!_line2) {
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = RightColor;
    }
    return _line2;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa =[[UILabel alloc] init];
        _titleLa.text = @"为你精选";
        _titleLa.font = [UIFont boldSystemFontOfSize:15];
    }
    return _titleLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLa];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(45);
            make.right.equalTo(self.titleLa.mas_left).offset(-20);
            make.height.mas_equalTo(0.5);
            make.centerY.equalTo(self);
        }];
        
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-45);
            make.left.equalTo(self.titleLa.mas_right).offset(20);
            make.height.mas_equalTo(0.5);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}


@end
