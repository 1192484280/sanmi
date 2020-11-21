//
//  HeaderCollectionViewCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendCollectionViewCell.h"
#import "RecommendCellLayout.h"
#import "RecommendCellModel.h"

@interface RecommendCollectionViewCell ()

@property (nonatomic, strong) UIImageView *im;
//@property (nonatomic, strong) UIImageView *storeLogoIm;
@property (nonatomic, strong) TopLeftLabel *titleLa;
@property (nonatomic, strong) UILabel *oldPriceLa;
@property (nonatomic, strong) UILabel *nowPriceLa;
@property (nonatomic, strong) UILabel *peopleLa;
@property (nonatomic, strong) UILabel *couponLa;
@property (nonatomic, strong) UILabel *rewardLa;

@end

@implementation RecommendCollectionViewCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
    }
    return _im;
}

//- (UIImageView *)storeLogoIm{
//
//    if (!_storeLogoIm) {
//
//        _storeLogoIm = [[UIImageView alloc] init];
//        _storeLogoIm.image = [UIImage imageNamed:@"img_goods"];
//    }
//    return _storeLogoIm;
//}

- (TopLeftLabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[TopLeftLabel alloc] init];
        _titleLa.numberOfLines = 0;
        _titleLa.textAlignment = NSTextAlignmentLeft;
        _titleLa.font = [UIFont systemFontOfSize:13];
    }
    return _titleLa;
}

- (UILabel *)oldPriceLa{
    
    if (!_oldPriceLa) {
        
        _oldPriceLa = [[UILabel alloc] init];
        _oldPriceLa.textAlignment = NSTextAlignmentLeft;
        _oldPriceLa.font = [UIFont systemFontOfSize:11];
        _oldPriceLa.textColor = UIColor.lightGrayColor;
    }
    return _oldPriceLa;
}

- (UILabel *)nowPriceLa{
    
    if (!_nowPriceLa) {
        
        _nowPriceLa = [[UILabel alloc] init];
        _nowPriceLa.textAlignment = NSTextAlignmentLeft;
        _nowPriceLa.font = [UIFont boldSystemFontOfSize:18];
        _nowPriceLa.textColor = SMOrangeColor;
    }
    return _nowPriceLa;
}

- (UILabel *)peopleLa{
    
    if (!_peopleLa) {
        
        _peopleLa = [[UILabel alloc] init];
        _peopleLa.textAlignment = NSTextAlignmentRight;
        _peopleLa.font = [UIFont systemFontOfSize:11];
        _peopleLa.textColor = UIColor.lightGrayColor;
    }
    return _peopleLa;
}

- (UILabel *)couponLa{
    
    if (!_couponLa) {
        
        _couponLa = [[UILabel alloc] init];
        _couponLa.textAlignment = NSTextAlignmentCenter;
        _couponLa.font = [UIFont boldSystemFontOfSize:11];
        _couponLa.textColor = UIColor.whiteColor;
        [_couponLa az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        _couponLa.layer.cornerRadius = 2;
        _couponLa.layer.masksToBounds = YES;
    }
    return _couponLa;
}

- (UILabel *)rewardLa{
    
    if (!_rewardLa) {
        
        _rewardLa = [[UILabel alloc] init];
        _rewardLa.textAlignment = NSTextAlignmentCenter;
        _rewardLa.font = [UIFont boldSystemFontOfSize:11];
        _rewardLa.textColor = SMOrangeColor;
        _rewardLa.layer.cornerRadius = 2;
        _rewardLa.layer.borderWidth = 0.5;
        _rewardLa.layer.borderUIColor = SMOrangeColor;
    }
    return _rewardLa;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        [self addSubview:self.im];
//        [self addSubview:self.storeLogoIm];
        [self addSubview:self.titleLa];
        [self addSubview:self.oldPriceLa];
        [self addSubview:self.nowPriceLa];
        [self addSubview:self.rewardLa];
        [self addSubview:self.peopleLa];
        [self addSubview:self.couponLa];
    }
    return self;
}
- (void)setLayout:(RecommendCellLayout *)layout{
    
    self.im.frame = layout.imgRect;
//    self.storeLogoIm.frame = layout.storeLogoRect;
    self.titleLa.frame = layout.titleRect;
    self.oldPriceLa.frame = layout.oldPriceRect;
    self.nowPriceLa.frame = layout.nowPriceRect;
    self.rewardLa.frame = layout.rewardRect;
    self.peopleLa.frame = layout.peopleRect;
    self.couponLa.frame = layout.couponRect;
    
    RecommendCellModel *model = layout.data;
    
    [self.im sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    NSString *title = [NSString stringWithFormat:@"[%@] %@",model.storeName,model.title];
    self.titleLa.attributedText = [NSString getAttributedWithString:title WithLineSpace:5 kern:1 font:[UIFont systemFontOfSize:13] color:[UIColor blackColor]];
    self.oldPriceLa.text = [NSString stringWithFormat:@"¥ %@",model.oldPrice];
    self.nowPriceLa.text = [NSString stringWithFormat:@"¥ %@",model.nowPrice];
    self.peopleLa.text = [NSString stringWithFormat:@"%@人已抢",model.people];
    self.couponLa.text = [NSString stringWithFormat:@"%@元券",model.coupon];
    self.rewardLa.text = [NSString stringWithFormat:@"平台奖励 ¥ %@",model.reward];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
