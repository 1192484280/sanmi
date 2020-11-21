//
//  ProductCollectionReusableView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductCollectionReusableView.h"

@interface ProductCollectionReusableView ()

@property (nonatomic, strong) UILabel *titleLa;

@end

@implementation ProductCollectionReusableView

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont boldSystemFontOfSize:15];
        _titleLa.text = @"闪蜜推荐";
    }
    return _titleLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.titleLa];
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
