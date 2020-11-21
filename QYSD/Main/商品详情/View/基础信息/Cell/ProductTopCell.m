//
//  ProductTopCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductTopCell.h"
#import "ProductInfoLayout.h"
#import "ProductDetailModel.h"
#import "WKWebViewController.h"
#import "WkWebList.h"
#import "SearchResultViewController.h"
#import "LoginMainViewController.h"

@interface ProductTopCell ()

//券后价格
@property (nonatomic, strong) UILabel *fuhaolLa;
@property (nonatomic, strong) UILabel *priceLa;
@property (nonatomic, strong) UILabel *quanHouLa;
@property (nonatomic, strong) UILabel *saleNumLa;
@property (nonatomic, strong) JTImageButton *searchBtn;

//平台奖励
@property (nonatomic, strong) UIView *rewardBgView;
@property (nonatomic, strong) UIView *rewardBgView2;
@property (nonatomic, strong) UILabel *platformRewardLa;
@property (nonatomic, strong) UILabel *leveLa;
@property (nonatomic, strong) UILabel *leveRewardLa;
@property (nonatomic, strong) JTImageButton *upgradeBtn;

//商品描述
@property (nonatomic, strong) UIImageView *storeLogoIm;
@property (nonatomic, strong) YYLabel *goodsDesLa;

//领券
@property (nonatomic, strong) UIView *quanBgView;
@property (nonatomic, strong) UIView *quanColorView;
@property (nonatomic, strong) UIImageView *fengeIm;
@property (nonatomic, strong) UILabel *quanValueLa;
@property (nonatomic, strong) UILabel *quanTimeLa;
@property (nonatomic, strong) UILabel *rightBuyLa;
@property (nonatomic, strong) UIImageView *rightImg;

//推荐
@property (nonatomic, strong) UIView *recView;
@property (nonatomic, strong) YYLabel *reLa;

//店铺
@property (nonatomic, strong) UIView *storeView;
@property (nonatomic, strong) UIImageView *storeIm2;
@property (nonatomic, strong) UILabel *storeName;
@property (nonatomic, strong) JTImageButton *goStoreBtn;
@property (nonatomic, strong) UILabel *bbDesLa;
@property (nonatomic, strong) UILabel *salerServiceLa;
@property (nonatomic, strong) UILabel *logisticsServiceLa;

//评论
@property (nonatomic, strong) UIView *commentBgView;
@property (nonatomic, strong) UILabel *commentNumLa;
@property (nonatomic, strong) UIImageView *commentUserIm;
@property (nonatomic, strong) UILabel *commentUserName;
@property (nonatomic, strong) YYLabel *commentContent;

@end

@implementation ProductTopCell

#pragma mark - 评论
- (UIView *)commentBgView{
    
    if (!_commentBgView) {
        
        _commentBgView = [[UIView alloc] init];
        
    }
    return _commentBgView;
}
- (UILabel *)commentNumLa{
    
    if (!_commentNumLa) {
        
        _commentNumLa = [[UILabel alloc] init];
        _commentNumLa.font = [UIFont systemFontOfSize:15];
    }
    return _commentNumLa;
}

- (UIImageView *)commentUserIm{
    
    if (!_commentUserIm) {
        
        _commentUserIm = [[UIImageView alloc] init];
        _commentUserIm.layer.cornerRadius = 20;
        _commentUserIm.layer.masksToBounds = YES;
        _commentUserIm.image = [UIImage imageNamed:@"img_smalHeader"];
    }
    return _commentUserIm;
}

- (UILabel *)commentUserName{
    
    if (!_commentUserName) {
        _commentUserName = [[UILabel alloc] init];
        _commentUserName.textColor = UIColor.lightGrayColor;
        _commentUserName.font = [UIFont systemFontOfSize:11];
    }
    return _commentUserName;
}

- (YYLabel *)commentContent{
    
    if (!_commentContent) {
        
        _commentContent = [YYLabel new];
        _commentContent.userInteractionEnabled = YES;
        _commentContent.numberOfLines = 0;
        _commentContent.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _commentContent.displaysAsynchronously = YES;
    }
    return _commentContent;
}

#pragma mark - 店铺
- (UIImageView *)storeIm2{
    
    if (!_storeIm2) {
        
        _storeIm2 = [[UIImageView alloc] init];
    }
    return _storeIm2;
}

- (UILabel *)storeName{
    
    if (!_storeName) {
        
        _storeName = [[UILabel alloc] init];
        _storeName.font = [UIFont systemFontOfSize:13];
    }
    return _storeName;
}

- (JTImageButton *)goStoreBtn{
    
    if (!_goStoreBtn) {
        
        _goStoreBtn = [[JTImageButton alloc] init];
        [_goStoreBtn createTitle:@"点击进入店铺" withIcon:[UIImage imageNamed:@"img_upgrade"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _goStoreBtn.borderWidth = 0.0;
        _goStoreBtn.titleColor = UIColor.blackColor;
        _goStoreBtn.iconSide = JTImageButtonIconSideRight;
        [_goStoreBtn addTarget:self action:@selector(onGoStoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _goStoreBtn;
}

#pragma mark - 点击进入店铺
- (void)onGoStoreBtn:(UIButton *)sender{
    

}

- (UILabel *)bbDesLa{
    
    if (!_bbDesLa) {
        
        _bbDesLa = [[UILabel alloc] init];
        _bbDesLa.textAlignment = NSTextAlignmentLeft;
        _bbDesLa.textColor = UIColor.lightGrayColor;
        _bbDesLa.font = [UIFont systemFontOfSize:13];
        
    }
    return _bbDesLa;
}

- (UILabel *)salerServiceLa{
    
    if (!_salerServiceLa) {
        
        _salerServiceLa = [[UILabel alloc] init];
        _salerServiceLa.textAlignment = NSTextAlignmentCenter;
        _salerServiceLa.textColor = UIColor.lightGrayColor;
        _salerServiceLa.font = [UIFont systemFontOfSize:13];
        
    }
    return _salerServiceLa;
}

- (UILabel *)logisticsServiceLa{
    
    if (!_logisticsServiceLa) {
        
        _logisticsServiceLa = [[UILabel alloc] init];
        _logisticsServiceLa.textAlignment = NSTextAlignmentRight;
        _logisticsServiceLa.textColor = UIColor.lightGrayColor;
        _logisticsServiceLa.font = [UIFont systemFontOfSize:13];
        
    }
    return _logisticsServiceLa;
}

- (UIView *)storeView{
    
    if (!_storeView) {
        
        _storeView = [[UIView alloc] init];
        _storeView.backgroundColor = BaseBackGroundColor;
        
        CGFloat marign = 10;
        CGFloat spading = 14;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = UIColor.whiteColor;
        [_storeView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_storeView).with.insets(UIEdgeInsetsMake(marign, 0, marign, 0));
        }];
        
        [bgView addSubview:self.storeIm2];
        [bgView addSubview:self.storeName];
//        [bgView addSubview:self.goStoreBtn];
        [bgView addSubview:self.bbDesLa];
        [bgView addSubview:self.salerServiceLa];
        [bgView addSubview:self.logisticsServiceLa];
        
        [self.storeIm2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marign);
            make.top.mas_equalTo(spading);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.storeIm2.mas_right).offset(5);
            make.centerY.equalTo(self.storeIm2);
        }];
        
//        [self.goStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-marign);
//            make.centerY.equalTo(self.storeIm2);
//        }];
        
        NSArray *arr = @[self.bbDesLa,self.salerServiceLa,self.logisticsServiceLa];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:14 tailSpacing:14];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.storeIm2.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return _storeView;
}

#pragma mark - 推荐
- (YYLabel *)reLa{
    
    if (!_reLa) {
        
        _reLa = [YYLabel new];
        _reLa.userInteractionEnabled = YES;
        _reLa.numberOfLines = 0;
        _reLa.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _reLa.displaysAsynchronously = YES;
    }
    return _reLa;
}

- (UIView *)recView{
    
    if (!_recView) {
        
        _recView = [[UIView alloc] init];
        
        [_recView addSubview:self.reLa];
        
        [_reLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_recView).width.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    
    }
    return _recView;
}


#pragma mark - 领券
- (UIImageView *)rightImg{
    
    if (!_rightImg) {
        
        _rightImg = [[UIImageView alloc] init];
        //        _rightImg.backgroundColor = UIColor.redColor;
        _rightImg.image = [UIImage imageNamed:@"youhuiquanright"];
    }
    return _rightImg;
}


- (UILabel *)rightBuyLa{
    
    if (!_rightBuyLa) {
        
        _rightBuyLa = [[UILabel alloc] init];
        _rightBuyLa.text = @"立即购买";
        _rightBuyLa.textAlignment = NSTextAlignmentCenter;
        _rightBuyLa.textColor = UIColor.whiteColor;
        _rightBuyLa.font = [UIFont systemFontOfSize:13];
    }
    return _rightBuyLa;
}

- (UILabel *)quanTimeLa{
    
    if (!_quanTimeLa) {
        
        _quanTimeLa = [[UILabel alloc] init];
        _quanTimeLa.textColor = UIColor.whiteColor;
        _quanTimeLa.font = [UIFont boldSystemFontOfSize:12];
    }
    return _quanTimeLa;
}

- (UILabel *)quanValueLa{
    
    if (!_quanValueLa) {
        
        _quanValueLa = [[UILabel alloc] init];
        _quanValueLa.textColor = UIColor.whiteColor;
        _quanValueLa.font = [UIFont boldSystemFontOfSize:30];
    }
    return _quanValueLa;
}

- (UIImageView *)fengeIm{
    if (!_fengeIm) {
        
        _fengeIm = [[UIImageView alloc] init];
        _fengeIm.image = [UIImage imageNamed:@"img_fengeIm"];
    }
    return _fengeIm;
}

- (UIView *)quanColorView{
    
    if (!_quanColorView) {
        
        _quanColorView = [[UIView alloc] init];
        [_quanColorView az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [_quanColorView addSubview:self.fengeIm];
        
        UILabel *la = [[UILabel alloc] init];
        la.text = @"¥";
        la.textColor = UIColor.whiteColor;
        la.font = [UIFont systemFontOfSize:15];
        [_quanColorView addSubview:la];
        
        [_quanColorView addSubview:self.quanValueLa];
        
        UILabel *la2 = [[UILabel alloc] init];
        la2.text = @"优惠券有效期至";
        la2.textColor = UIColor.whiteColor;
        la2.font = [UIFont systemFontOfSize:12];
        [_quanColorView addSubview:la2];
        
        [_quanColorView addSubview:self.quanTimeLa];
        
        [_quanColorView addSubview:self.rightBuyLa];
        
        [self.fengeIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-100);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(15);
        }];
        
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(14);
            make.bottom.equalTo(self.quanValueLa);
        }];
        
        [self.quanValueLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(la.mas_right).offset(5);
            make.centerY.equalTo(self->_quanColorView);
            make.height.mas_equalTo(25);
        }];
        
        [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.quanValueLa.mas_right).offset(5);
            make.top.equalTo(self.quanValueLa);
            make.height.mas_equalTo(12.5);
        }];
        
        [self.quanTimeLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.quanValueLa.mas_right).offset(5);
            make.bottom.equalTo(self.quanValueLa);
            make.height.mas_equalTo(12.5);
        }];
        
        [self.rightBuyLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_quanColorView.mas_right);
            make.top.bottom.mas_equalTo(0);
            make.left.equalTo(self.fengeIm.mas_right);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onCupView)];
        [_quanColorView addGestureRecognizer:tap];
        
    }
    return _quanColorView;
}

- (UIView *)quanBgView{
    
    if (!_quanBgView) {
        
        _quanBgView = [[UIView alloc] init];
        _quanBgView.backgroundColor = BaseBackGroundColor;
        
        [_quanBgView addSubview:self.quanColorView];
        
        [_quanBgView addSubview:self.rightImg];
        
        [self.quanColorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_quanBgView).with.insets(UIEdgeInsetsMake(10, 10, 10, 14));
        }];
        
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(4);
            make.top.bottom.equalTo(self.quanColorView);
            make.left.equalTo(self.quanColorView.mas_right);
        }];
        
    }
    return _quanBgView;
}

#pragma mark - 商品描述
- (YYLabel *)goodsDesLa{
    
    if (!_goodsDesLa) {
        
        _goodsDesLa = [YYLabel new];
        _goodsDesLa.userInteractionEnabled = YES;
        _goodsDesLa.numberOfLines = 0;
        _goodsDesLa.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _goodsDesLa.displaysAsynchronously = YES;
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onDesLa)];
        [_goodsDesLa addGestureRecognizer:longTap];
    }
    return _goodsDesLa;
}

- (void)onDesLa{
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.model.Title;
    [self.viewController.view makeToast:@"标题已复制" duration:1.0 position:CSToastPositionCenter];
}

- (UIImageView *)storeLogoIm{
    
    if (!_storeLogoIm) {
        
        _storeLogoIm = [[UIImageView alloc] init];
        _storeLogoIm.image = [UIImage imageNamed:@"天猫logo"];
    }
    return _storeLogoIm;
}

#pragma mark - 平台奖励
- (JTImageButton *)upgradeBtn{
    
    if (!_upgradeBtn) {
        
        _upgradeBtn = [[JTImageButton alloc] init];
        [_upgradeBtn createTitle:@"立即升级" withIcon:[UIImage imageNamed:@"img_upgrade"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _upgradeBtn.borderWidth = 0.0;
        _upgradeBtn.titleColor = UIColor.blackColor;
        _upgradeBtn.iconSide = JTImageButtonIconSideRight;
        [_upgradeBtn addTarget:self action:@selector(onUpgradeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _upgradeBtn;
}

- (void)onUpgradeBtn:(UIButton *)sender{
    
    [self.viewController.view makeToast:@"点击立即升级" duration:1.0 position:CSToastPositionBottom];
}

- (UILabel *)leveRewardLa{
    
    if (!_leveRewardLa) {
        
        _leveRewardLa = [[UILabel alloc] init];
        _leveRewardLa.text = @"¥ 0.00";
        _leveRewardLa.textColor = SMOrangeColor;
        _leveRewardLa.font = [UIFont systemFontOfSize:12];
        
    }
    return _leveRewardLa;
}

- (UILabel *)leveLa{
    
    if (!_leveLa) {
        
        _leveLa = [[UILabel alloc] init];
        _leveLa.text = @"升级奖励";
        _leveLa.font = [UIFont systemFontOfSize:12];
        
    }
    return _leveLa;
}

- (UILabel *)platformRewardLa{
    
    if (!_platformRewardLa) {
        
        _platformRewardLa = [[UILabel alloc] init];
        _platformRewardLa.text = @"平台奖励 ¥ 0.00";
        _platformRewardLa.textColor = UIColor.whiteColor;
        _platformRewardLa.textAlignment = NSTextAlignmentCenter;
        _platformRewardLa.font = [UIFont systemFontOfSize:12];
        
    }
    return _platformRewardLa;
}

- (UIView *)rewardBgView2{
    
    if (!_rewardBgView2) {
        
        _rewardBgView2 = [[UIView alloc] init];
        _rewardBgView2.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
        [_rewardBgView2 addSubview:self.platformRewardLa];
        [self.platformRewardLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _rewardBgView2;
}

- (UIView *)rewardBgView{
    
    if (!_rewardBgView) {
        
        _rewardBgView = [[UIView alloc] init];
        _rewardBgView.backgroundColor = [UIColor colorWithHexString:@"FDF4D5"];
        
        [_rewardBgView addSubview:self.rewardBgView2];
        
        UIImageView *im = [[UIImageView alloc] init];
        im.image = [UIImage imageNamed:@"img_rewardjiantou"];
        [_rewardBgView addSubview:im];
        
        [_rewardBgView addSubview:self.leveLa];
        [_rewardBgView addSubview:self.leveRewardLa];
        
        [_rewardBgView addSubview:self.upgradeBtn];
        
        [self.rewardBgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(125);
        }];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self->_rewardBgView);
            make.left.equalTo(self->_rewardBgView2.mas_right);
        }];
        
        [self.leveLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(im.mas_right).offset(8);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.leveRewardLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leveLa.mas_right).offset(5);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.upgradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self->_rewardBgView);
            //            make.height.mas_equalTo(22);
        }];
    }
    return _rewardBgView;
}


#pragma mark - 券后价格一行
- (JTImageButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [[JTImageButton alloc] init];
        [_searchBtn createTitle:@"找同款" withIcon:[UIImage imageNamed:@"img_searchSame"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _searchBtn.borderWidth = 0.0;
        _searchBtn.titleColor = UIColor.blackColor;
        _searchBtn.iconSide = JTImageButtonIconSideLeft;
        [_searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _searchBtn;
}

- (void)onSearchBtn:(UIButton *)sender{
    
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = self.model.Title;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UILabel *)saleNumLa{
    
    if (!_saleNumLa) {
        
        _saleNumLa = [[UILabel alloc] init];
        _saleNumLa.textColor = UIColor.lightGrayColor;
        _saleNumLa.font = [UIFont systemFontOfSize:13];
        
    }
    return _saleNumLa;
}

- (UILabel *)quanHouLa{
    
    if (!_quanHouLa) {
        
        _quanHouLa = [[UILabel alloc] init];
        _quanHouLa.text = @"券后";
        _quanHouLa.textColor = UIColor.lightGrayColor;
        _quanHouLa.font = [UIFont systemFontOfSize:13];
        
    }
    return _quanHouLa;
}

- (UILabel *)fuhaolLa{
    
    if (!_fuhaolLa) {
        
        _fuhaolLa = [[UILabel alloc] init];
        _fuhaolLa.text = @"¥";
        _fuhaolLa.textColor = SMOrangeColor;
        _fuhaolLa.font = [UIFont boldSystemFontOfSize:15];
        
    }
    return _fuhaolLa;
}

- (UILabel *)priceLa{
    
    if (!_priceLa) {
        
        _priceLa = [[UILabel alloc] init];
        _priceLa.textColor = SMOrangeColor;
        _priceLa.font = [UIFont boldSystemFontOfSize:25];
        
    }
    return _priceLa;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.fuhaolLa];
        [self addSubview:self.priceLa];
        [self addSubview:self.quanHouLa];
        [self addSubview:self.saleNumLa];
        [self addSubview:self.searchBtn];
        //        [self addSubview:self.rewardBgView];
        [self addSubview:self.storeLogoIm];
        [self addSubview:self.goodsDesLa];
        [self addSubview:self.quanBgView];
        [self addSubview:self.recView];
        [self addSubview:self.storeView];
        
        [self addSubview:self.commentBgView];
        [self addSubview:self.commentNumLa];
        [self addSubview:self.commentUserIm];
        [self addSubview:self.commentUserName];
        [self addSubview:self.commentContent];
    }
    return self;
}

- (void)setLayout:(ProductInfoLayout *)layout{
    
    _model = layout.data;
    self.fuhaolLa.frame = layout.fuhaoRect;
    self.priceLa.frame = layout.priceRect;
    self.quanHouLa.frame = layout.quanhouRect;
    self.saleNumLa.frame = layout.saleNumRect;
    self.searchBtn.frame = layout.searchBtnRect;
    self.goodsDesLa.frame = layout.desRect;
    self.quanBgView.frame = layout.quanBgViewRect;
    self.recView.frame = layout.tuijianBgRect;
    self.storeView.frame = layout.storeBgRect;
    
    self.commentBgView.frame = layout.commentBgRect;
    self.commentNumLa.frame = layout.comontRect;
    self.commentUserIm.frame = layout.comontIconRect;
    self.commentUserName.frame = layout.comontNameRect;
    self.commentContent.frame = layout.comontDesRect;
    
    NSString *price = [NSString stringWithFormat:@"%.2f",[layout.data.ZkFinalPrice floatValue] - [layout.data.CouponAmount floatValue]];
    self.priceLa.text = price;
    
    NSString *xlStr = [NSString stringWithFormat:@"销量%@",layout.data.Volume];
    if ([layout.data.Volume integerValue] >= 10000) {
        
        CGFloat a = [layout.data.Volume integerValue] / 10000.0;
        xlStr = [NSString stringWithFormat:@"销量%.1f万",a];
    }
    NSString *sale = xlStr;
    self.saleNumLa.text = sale;

    UIImage *defaultImg = [UIImage imageNamed:@"天猫logo"];
    if (layout.data.UserType == 0) {
        
        defaultImg = [UIImage imageNamed:@"淘宝logo"];
    } dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:14];
        
        if ([layout.data.Title isValid]) {
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",layout.data.Title] attributes:nil]];
            
            UIImage *image = defaultImg;
            image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text insertAttributedString:attachText atIndex:0];
//            text.yy_kern = @0.5;
            text.yy_lineSpacing = 5;
            text.yy_font = font;
            text.yy_color = FontColor;
        }
    
        NSMutableAttributedString *tuijianDesText = [NSMutableAttributedString new];
        
        if ([layout.data.ItemDescription isValid]) {
            [tuijianDesText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",layout.data.ItemDescription] attributes:nil]];
            
            UIImage *image = [UIImage imageNamed:@"img_godsdetailRec"];
            image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [tuijianDesText insertAttributedString:attachText atIndex:0];
//            tuijianDesText.yy_kern = @0.5;
            tuijianDesText.yy_lineSpacing = 5;
            tuijianDesText.yy_font = font;
            tuijianDesText.yy_color = FontColor;
        }
        
        NSMutableAttributedString *commentText = [NSMutableAttributedString new];
        
        if ([layout.data.commentDes isValid]) {
            [commentText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",layout.data.commentDes] attributes:nil]];
        
//            commentText.yy_kern = @0.5;
            commentText.yy_lineSpacing = 5;
            commentText.yy_font = font;
            commentText.yy_color = FontColor;
        }
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *oldAttribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %.2f",[layout.data.ZkFinalPrice floatValue]] attributes:attribtDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.goodsDesLa.attributedText = text;
            self.reLa.attributedText = tuijianDesText;
            self.commentContent.attributedText = commentText;
            self.quanHouLa.attributedText = oldAttribtStr;
        });
    });
    
    self.quanValueLa.text = layout.data.CouponAmount;
    
    NSString *endTime = [[NSString changeWithTime:layout.data.CouponEndTime] substringToIndex:10];
    if ([layout.data.CouponEndTime containsString:@"-"] || [layout.data.CouponEndTime containsString:@":"] || [layout.data.CouponEndTime containsString:@" "]) {
        
        endTime = layout.data.CouponEndTime;
    }
    self.quanTimeLa.text = endTime;
    self.storeName.text = layout.data.ShopTitle;
    self.storeIm2.image = defaultImg;
    
    self.commentNumLa.text = [NSString stringWithFormat:@"宝贝评论(%@)",layout.data.baobeicomment];
    [self.commentUserIm sd_setImageWithURL:layout.data.commentIcon.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    self.commentUserName.text = layout.data.commentName;
     self.commentContent.text = layout.data.commentDes;
    
    NSString *baobeimiaoshu = [NSString stringWithFormat:@"宝贝描述 %@",layout.data.baobeimiaoshu];
    NSString *maijiafuwu = [NSString stringWithFormat:@"卖家服务 %@",layout.data.maijiafuwu];
    NSString *wuliufuwu = [NSString stringWithFormat:@"卖家服务 %@",layout.data.wuliufuwu];
    
    if (![layout.data.baobeimiaoshu isValid]) {
        
        baobeimiaoshu = [NSString stringWithFormat:@"宝贝描述 %@",[self getRanScore]];
    }
    
    if (![layout.data.maijiafuwu isValid]) {
        
        maijiafuwu = [NSString stringWithFormat:@"卖家服务 %@",[self getRanScore]];
    }
    
    if (![layout.data.wuliufuwu isValid]) {
        
        wuliufuwu = [NSString stringWithFormat:@"卖家服务 %@",[self getRanScore]];
    }
    
    self.bbDesLa.text = baobeimiaoshu;
    self.salerServiceLa.text = maijiafuwu;
    self.logisticsServiceLa.text = wuliufuwu;
    
}

#pragma mark - 立即购买
-(void)onCupView{
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    if (![SMUserGuid isValid] && ![version isEqualToString:@"1.0"]) {
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    NSString *url = self.model.CouponShareUrl;
    if (![self.model.CouponShareUrl containsString:@"taobao:"]) {
        
        url = [NSString stringWithFormat:@"taobao:%@",self.model.CouponShareUrl];
    }
    
    NSURL *Url = [NSURL URLWithString:url];
    
    if (@available(iOS 13.0, *)) {
        
        if (![self.model.CouponShareUrl containsString:@"http"]) {
            
            url = [NSString stringWithFormat:@"http:%@",self.model.CouponShareUrl];
        }
        [WkWebList sharedInstance].url = url;
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        [webVC setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
        
    }else{
        
        if ([[UIApplication sharedApplication] canOpenURL:Url]) {
            
            [[UIApplication sharedApplication] openURL:Url];
            
        } else {
            
            if (![self.model.CouponShareUrl containsString:@"http"]) {
                
                url = [NSString stringWithFormat:@"http:%@",self.model.CouponShareUrl];
            }
            [WkWebList sharedInstance].url = url;
            WKWebViewController *webVC = [[WKWebViewController alloc] init];
            [webVC setHidesBottomBarWhenPushed:YES];
            [self.viewController.navigationController pushViewController:webVC animated:YES];
        }
    }
    
    
}

#pragma mark - 获取随机评分
- (NSString *)getRanScore{
    
    BOOL run = YES;
    float r = 4.8;
    while (run) {
        
        r = (float)(arc4random()%100) / 100 + 4.0;
        
        if (r>=4.6 && r<=5.0) {
            
            run = NO;
        }
    }
    return [NSString stringWithFormat:@"%.1f",r];
}
@end
