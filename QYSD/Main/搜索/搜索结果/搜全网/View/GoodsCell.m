//
//  GoodsCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "GoodsCell.h"
#import "GoodsCellLayout.h"
#import "GoodsModel.h"

@interface GoodsCell ()

@property (nonatomic, strong) UIImageView *im;
@property (nonatomic, strong) UIImageView *storeLogoIm;
@property (nonatomic, strong) UILabel *storeNameLa;
@property (nonatomic, strong) YYLabel *titleLa;
@property (nonatomic, strong) YYLabel *topTitleLa;
@property (nonatomic, strong) UILabel *oldPriceLa;
@property (nonatomic, strong) UILabel *nowPriceLa;
@property (nonatomic, strong) UILabel *peopleLa;

@property (nonatomic, strong) UILabel *rewardLa;

@property (nonatomic, strong) UIView *couponView;
@property (nonatomic, strong) UIImageView *couponIm;
@property (nonatomic, strong) UILabel *couponLa;

@end

@implementation GoodsCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
    }
    return _im;
}

- (UIImageView *)storeLogoIm{

    if (!_storeLogoIm) {

        _storeLogoIm = [[UIImageView alloc] init];
    }
    return _storeLogoIm;
}

- (UILabel *)storeNameLa{
    
    if (!_storeNameLa) {
        
        _storeNameLa = [[UILabel alloc] init];
        _storeNameLa.textAlignment = NSTextAlignmentRight;
        _storeNameLa.font = [UIFont systemFontOfSize:12];
        _storeNameLa.textColor = UIColor.lightGrayColor;
    }
    return _storeNameLa;
}

- (YYLabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [YYLabel new];
        _titleLa.userInteractionEnabled = YES;
        _titleLa.numberOfLines = 2;
        _titleLa.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _titleLa.displaysAsynchronously = YES;
        _titleLa.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLa;
}

- (YYLabel *)topTitleLa{
    
    if (!_topTitleLa) {
        
        _topTitleLa = [YYLabel new];
        _topTitleLa.numberOfLines = 1;
        _topTitleLa.displaysAsynchronously = YES;
        _topTitleLa.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _topTitleLa;
}

- (UILabel *)oldPriceLa{
    
    if (!_oldPriceLa) {
        
        _oldPriceLa = [[UILabel alloc] init];
        _oldPriceLa.textAlignment = NSTextAlignmentLeft;
        _oldPriceLa.font = [UIFont systemFontOfSize:13];
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
        _peopleLa.font = [UIFont systemFontOfSize:13];
        _peopleLa.textColor = UIColor.lightGrayColor;
    }
    return _peopleLa;
}

- (UIView *)couponView{
    
    if (!_couponView) {
        
        _couponView = [[UIView alloc] init];
        _couponView.layer.cornerRadius = 2;
        _couponView.layer.masksToBounds = YES;
        _couponView.layer.borderWidth = 0.5;
        _couponView.layer.borderUIColor = SMOrangeColor;
        
        [_couponView addSubview:self.couponIm];
        [_couponView addSubview:self.couponLa];
        
        [self.couponIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(23);
        }];
        
        [self.couponLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.left.equalTo(self.couponIm.mas_right);
        }];
        
    }
    return _couponView;
}

- (UIImageView *)couponIm{
    
    if (!_couponIm) {
        
        _couponIm = [[UIImageView alloc] init];
        _couponIm.image = [UIImage imageNamed:@"quanIm"];
    }
    return _couponIm;
}
- (UILabel *)couponLa{
    
    if (!_couponLa) {
        
        _couponLa = [[UILabel alloc] init];
        _couponLa.textAlignment = NSTextAlignmentCenter;
        _couponLa.font = [UIFont boldSystemFontOfSize:11];
        _couponLa.textColor = SMOrangeColor;
//        [_couponLa az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FC7100"],[UIColor colorWithHexString:@"FC2F00"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
//        _couponLa.layer.cornerRadius = 2;
//        _couponLa.layer.masksToBounds = YES;
    }
    return _couponLa;
}

- (UILabel *)rewardLa{
    
    if (!_rewardLa) {
        
        _rewardLa = [[UILabel alloc] init];
        _rewardLa.textAlignment = NSTextAlignmentCenter;
        _rewardLa.font = [UIFont systemFontOfSize:11];
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
        [self addSubview:self.storeLogoIm];
        [self addSubview:self.storeNameLa];
        [self addSubview:self.titleLa];
        [self addSubview:self.topTitleLa];
        [self addSubview:self.oldPriceLa];
        [self addSubview:self.nowPriceLa];
        [self addSubview:self.rewardLa];
        [self addSubview:self.peopleLa];
        [self addSubview:self.couponView];
    }
    return self;
}
- (void)setLayout:(GoodsCellLayout *)layout{
    
    self.im.frame = layout.imgRect;
    self.storeNameLa.frame = layout.storeNameRect;
    self.titleLa.frame = layout.titleRect;
    self.oldPriceLa.frame = layout.oldPriceRect;
    self.nowPriceLa.frame = layout.nowPriceRect;
//    self.rewardLa.frame = layout.rewardRect;
    self.peopleLa.frame = layout.peopleRect;
    self.couponView.frame = layout.couponRect;
    
    GoodsModel *model = layout.data;
    [self.im sd_setImageWithURL:model.PictUrl.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    
    dispatch_queue_t quent = dispatch_queue_create("com.quent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(quent, ^{
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:13];
        
        if ([layout.data.Title isValid]) {
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",layout.data.Title] attributes:nil]];
            
            UIImage *image = [UIImage imageNamed:@"天猫logo"];
            if (layout.data.UserType == 0) {
                
                image = [UIImage imageNamed:@"淘宝logo"];
            }else if (layout.data.UserType == 1){
                
                image = [UIImage imageNamed:@"天猫logo"];
            }
            
            image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text insertAttributedString:attachText atIndex:0];
//            text.yy_kern = @0.5;
            text.yy_lineSpacing = 2;
            text.yy_font = font;
            text.yy_color = FontColor;
            
        }
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *oldAttribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %.2f",[model.ZkFinalPrice floatValue]] attributes:attribtDic];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.titleLa.attributedText = text;
            self.oldPriceLa.attributedText = oldAttribtStr;
        });
        
    });
    
    self.storeNameLa.text = layout.data.ShopTitle;
    
    self.nowPriceLa.text = [NSString stringWithFormat:@"¥ %.2f",[model.ZkFinalPrice floatValue] - [model.CouponAmount floatValue]];
    self.peopleLa.text = [NSString stringWithFormat:@"%@人已抢",model.Volume];
    self.couponLa.text = [NSString stringWithFormat:@"%@元",model.CouponAmount];
//    self.rewardLa.text = [NSString stringWithFormat:@"平台奖励 ¥ %.2f",[model.PlatFormBonus floatValue]];
    
    if ([model.CouponAmount isEqualToString:@"0"]) {
        
        self.couponView.alpha = 0;
    }else{
        
        self.couponView.alpha = 1;
    }
    
}

- (void)setLayout:(GoodsCellLayout *)layout andListflag:(NSInteger)listflag{
    
    self.im.frame = layout.imgRect;
    self.storeNameLa.frame = layout.storeNameRect;
    self.titleLa.frame = layout.titleRect;
    self.oldPriceLa.frame = layout.oldPriceRect;
    self.nowPriceLa.frame = layout.nowPriceRect;
    //    self.rewardLa.frame = layout.rewardRect;
    self.peopleLa.frame = layout.peopleRect;
    self.couponView.frame = layout.couponRect;
    self.topTitleLa.frame = layout.topTitleRect;
    
    GoodsModel *model = layout.data;
    [self.im sd_setImageWithURL:model.PictUrl.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    
    dispatch_queue_t quent = dispatch_queue_create("com.quent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(quent, ^{
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:13];
        
        if ([layout.data.Title isValid]) {
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",layout.data.Title] attributes:nil]];
            
            UIImage *image = [UIImage imageNamed:@"天猫logo"];
            if (layout.data.UserType == 0) {
                
                image = [UIImage imageNamed:@"淘宝logo"];
            }else if (layout.data.UserType == 1){
                
                image = [UIImage imageNamed:@"天猫logo"];
            }
            
            image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text insertAttributedString:attachText atIndex:0];
            //            text.yy_kern = @0.5;
            text.yy_lineSpacing = 2;
            text.yy_font = font;
            text.yy_color = FontColor;
            
        }
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *oldAttribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %.2f",[model.ZkFinalPrice floatValue]] attributes:attribtDic];
        
        NSMutableAttributedString *topText = [NSMutableAttributedString new];
        if ([layout.data.Volume isValid]) {
            
            if (listflag == 1) {
                
                NSString *topStr = [NSString stringWithFormat:@"近两小时成交 %@ 件",layout.data.Volume];
                [topText appendAttributedString:[[NSAttributedString alloc] initWithString:topStr attributes:nil]];
                topText.yy_font = [UIFont systemFontOfSize:14];
                NSRange range = NSMakeRange(6, layout.data.Volume.length + 2);
                [topText yy_setColor:SMOrangeColor range:range];
                [topText yy_setFont:[UIFont boldSystemFontOfSize:18] range:range];
                
            }else{
                
                NSString *topStr = [NSString stringWithFormat:@"24小时成交 %@ 件",layout.data.Volume];
                [topText appendAttributedString:[[NSAttributedString alloc] initWithString:topStr attributes:nil]];
                topText.yy_font = [UIFont systemFontOfSize:14];
                NSRange range = NSMakeRange(6, layout.data.Volume.length + 2);
                [topText yy_setColor:SMOrangeColor range:range];
                [topText yy_setFont:[UIFont boldSystemFontOfSize:18] range:range];
            }
            
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.titleLa.attributedText = text;
            self.oldPriceLa.attributedText = oldAttribtStr;
            self.topTitleLa.attributedText = topText;
        });
        
    });
    
    self.storeNameLa.text = layout.data.ShopTitle;
    
    self.nowPriceLa.text = [NSString stringWithFormat:@"¥ %.2f",[model.ZkFinalPrice floatValue] - [model.CouponAmount floatValue]];
    self.peopleLa.text = [NSString stringWithFormat:@"%@人已抢",model.Volume];
    self.couponLa.text = [NSString stringWithFormat:@"%@元",model.CouponAmount];
    //    self.rewardLa.text = [NSString stringWithFormat:@"平台奖励 ¥ %.2f",[model.PlatFormBonus floatValue]];
    
    if ([model.CouponAmount isEqualToString:@"0"]) {
        
        self.couponView.alpha = 0;
    }else{
        
        self.couponView.alpha = 1;
    }
    
}
@end
