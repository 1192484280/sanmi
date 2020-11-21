//
//  ProductNewsCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductNewsCell.h"

@interface ProductNewsCell ()

@property (nonatomic, strong) UIImageView *im;
@property (nonatomic, strong) UILabel *la;

@end

@implementation ProductNewsCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"img_mineWenHao"];
    }
    return _im;
}

- (UILabel *)la{
    if (!_la) {
        
        _la = [[UILabel alloc] init];
        _la.text = @"张*三   五分钟前领券购买了该商品";
        _la.textColor = UIColor.whiteColor;
        _la.font = [UIFont systemFontOfSize:10];
    }
    return _la;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.im];
        [self addSubview:self.la];
        
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        
        [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.im.mas_right).offset(8);
            make.top.bottom.right.mas_equalTo(0);
        }];
    }
    return self;
}

@end
