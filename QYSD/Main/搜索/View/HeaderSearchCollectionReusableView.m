//
//  HeaderSearchCollectionReusableView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchCollectionReusableView.h"

@interface HeaderSearchCollectionReusableView ()

@property (nonatomic, strong) UILabel *la;

@end

@implementation HeaderSearchCollectionReusableView

- (UIButton *)cleanBtn{
    
    if (!_cleanBtn) {
        
        _cleanBtn = [[UIButton alloc] init];
        _cleanBtn.hidden = YES;
        [_cleanBtn setImage:[UIImage imageNamed:@"img_laji"] forState:UIControlStateNormal];
        [_cleanBtn addTarget:self action:@selector(onCleanBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanBtn;
}
- (void)onCleanBtn:(UIButton *)sender{
    
    if (self.cleanBlock) {
        
        self.cleanBlock();
    }
}

- (UILabel *)la{
    
    if (!_la) {
        
        _la = [[UILabel alloc] init];
        _la.text = @"--";
        _la.textColor = FontColor;
        _la.font = [UIFont systemFontOfSize:13];
    }
    return _la;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.la];
        [self addSubview:self.cleanBtn];
        
        [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    
    self.la.text = title;
}
@end
