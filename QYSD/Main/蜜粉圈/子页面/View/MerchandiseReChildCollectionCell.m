//
//  MerchandiseReChildCollectionCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MerchandiseReChildCollectionCell.h"

@interface MerchandiseReChildCollectionCell ()

@property (nonatomic, strong) UILabel *priceLa;
@property (nonatomic, strong) UIImageView *im;

@end

@implementation MerchandiseReChildCollectionCell

- (UIImageView *)priceIm{
    
    if (!_priceIm) {
        
        _priceIm = [[UIImageView alloc] init];
        _priceIm.image = [UIImage imageNamed:@"img_tuijianPrice"];
        _priceIm.alpha = 0;
        
        [_priceIm addSubview:self.priceLa];
        [self.priceLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _priceIm;
    
}

- (UILabel *)priceLa{
    
    if (!_priceLa) {
        
        _priceLa = [[UILabel alloc] init];
        _priceLa.textColor = UIColor.whiteColor;
        _priceLa.font = [UIFont systemFontOfSize:12];
        _priceLa.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLa;
}

- (UIImageView *)playIm{
    
    if (!_playIm) {
        
        _playIm = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        _playIm.image = [UIImage imageNamed:@"new_allPlay_44x44_"];
        _playIm.alpha = 0;
    }
    return _playIm;
    
}

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.contentMode =  UIViewContentModeScaleAspectFill;
        _im.clipsToBounds  = YES;

    }
    return _im;
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
    
    [self addSubview:self.im];
    self.im.frame = self.bounds;
    
    [self addSubview:self.playIm];
    self.playIm.center = self.center;
    
    [self addSubview:self.priceIm];
//    [self.priceIm mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(20);
//    }];
}

- (void)setImgUrl:(NSString *)imgUrl{
    
    [self.im sd_setImageWithURL:imgUrl.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
        
}

- (void)setPrice:(NSString *)price{
    
    NSString *str = [NSString stringWithFormat:@"¥ %@",price];
    CGFloat width = [str widthForFont:[UIFont systemFontOfSize:12]] + 10;
    self.priceIm.frame = CGRectMake(self.width - width, self.height - 20, width, 20);
    self.priceLa.text = [NSString stringWithFormat:@"¥ %@",price];
    
}
@end
