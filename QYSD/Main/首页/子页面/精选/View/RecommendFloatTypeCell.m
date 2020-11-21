//
//  RecommendFloatTypeCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendFloatTypeCell.h"

@interface RecommendFloatTypeCell ()

@end

@implementation RecommendFloatTypeCell

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColor.grayColor;
    }
    return _line;
}

- (UILabel *)floatNameLa{
    
    if (!_floatNameLa) {
        
        _floatNameLa = [[UILabel alloc] init];
        _floatNameLa.text = @"平台名称";
        _floatNameLa.textAlignment = NSTextAlignmentCenter;
        _floatNameLa.adjustsFontSizeToFitWidth = YES;
        _floatNameLa.font = [UIFont boldSystemFontOfSize:17];
    }
    return _floatNameLa;
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        _desLa.text = @"平台描述";
        _desLa.textAlignment = NSTextAlignmentCenter;
        _desLa.adjustsFontSizeToFitWidth = YES;
        _desLa.font = [UIFont systemFontOfSize:12];
        _desLa.textColor = UIColor.lightGrayColor;
    }
    return _desLa;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    
    [self addSubview:self.floatNameLa];

    [self addSubview:self.desLa];

    [self addSubview:self.line];
    
    [self.floatNameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.floatNameLa.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(self.width - 10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(0.5);
//        make.height.mas_equalTo(25);
    }];
    
    
}

- (void)setSelectedWithIndex:(NSInteger)index{
    
    self.floatNameLa.textColor = UIColor.orangeColor;

    self.desLa.layer.cornerRadius = 10;
    self.desLa.layer.masksToBounds = YES;
    self.desLa.backgroundColor = UIColor.orangeColor;
    self.desLa.textColor = UIColor.whiteColor;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
