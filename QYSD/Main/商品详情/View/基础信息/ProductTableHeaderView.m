//
//  ProductTableHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductTableHeaderView.h"
#import "SDCycleScrollView.h"
#import "ProductNewsListView.h"
#import "SearchResultViewController.h"
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
#import "ProductDetailModel.h"

@interface ProductTableHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, copy) NSArray *imgArr;
//商品图片轮播
@property (nonatomic, strong) SDCycleScrollView *imgSDView;
//滚动播报
//@property (nonatomic, strong) ProductNewsListView *newsListView;
//当前图片index
@property (nonatomic, strong) UILabel *indexLa;

////券后价格
//@property (nonatomic, strong) UILabel *fuhaolLa;
//@property (nonatomic, strong) UILabel *priceLa;
//@property (nonatomic, strong) UILabel *quanHouLa;
//@property (nonatomic, strong) UILabel *saleNumLa;
//@property (nonatomic, strong) JTImageButton *searchBtn;
//
////平台奖励
//@property (nonatomic, strong) UIView *rewardBgView;
//@property (nonatomic, strong) UIView *rewardBgView2;
//@property (nonatomic, strong) UILabel *platformRewardLa;
//@property (nonatomic, strong) UILabel *leveLa;
//@property (nonatomic, strong) UILabel *leveRewardLa;
//@property (nonatomic, strong) JTImageButton *upgradeBtn;
//
////商品描述
//@property (nonatomic, strong) UIImageView *storeLogoIm;
//@property (nonatomic, strong) UILabel *goodsDesLa;
//
////领券
//@property (nonatomic, strong) UIView *quanBgView;
//@property (nonatomic, strong) UIView *quanColorView;
//@property (nonatomic, strong) UIImageView *fengeIm;
//@property (nonatomic, strong) UILabel *quanValueLa;
//@property (nonatomic, strong) UILabel *quanTimeLa;
//@property (nonatomic, strong) UIButton *rightBuyBtn;
//@property (nonatomic, strong) UIImageView *rightImg;
//
////推荐
//@property (nonatomic, strong) UIView *recView;
//@property (nonatomic, strong) UILabel *reLa;
//
////店铺
//@property (nonatomic, strong) UIView *storeView;
//@property (nonatomic, strong) UIImageView *storeIm2;
//@property (nonatomic, strong) UILabel *storeName;
//@property (nonatomic, strong) JTImageButton *goStoreBtn;
//@property (nonatomic, strong) UILabel *bbDesLa;
//@property (nonatomic, strong) UILabel *salerServiceLa;
//@property (nonatomic, strong) UILabel *logisticsServiceLa;
//
////评论
//@property (nonatomic, strong) UILabel *commentNumLa;
//@property (nonatomic, strong) UIImageView *commentUserIm;
//@property (nonatomic, strong) UILabel *commentUserName;
//@property (nonatomic, strong) UILabel *commentContent;

@end

@implementation ProductTableHeaderView

//#pragma mark - 评论
//- (UILabel *)commentNumLa{
//    
//    if (!_commentNumLa) {
//        
//        _commentNumLa = [[UILabel alloc] init];
//        _commentNumLa.text = @"宝贝评论(1)";
//    }
//    return _commentNumLa;
//}
//
//- (UIImageView *)commentUserIm{
//    
//    if (!_commentUserIm) {
//        
//        _commentUserIm = [[UIImageView alloc] init];
//        _commentUserIm.layer.cornerRadius = 20;
//        _commentUserIm.layer.masksToBounds = YES;
//        _commentUserIm.image = [UIImage imageNamed:@"img_smalHeader"];
//    }
//    return _commentUserIm;
//}
//
//- (UILabel *)commentUserName{
//    
//    if (!_commentUserName) {
//        _commentUserName = [[UILabel alloc] init];
//        _commentUserName.text = @"张*好";
//        _commentUserName.textColor = UIColor.lightGrayColor;
//        _commentUserName.font = [UIFont systemFontOfSize:15];
//    }
//    return _commentUserName;
//}
//
//- (UILabel *)commentContent{
//    
//    if (!_commentContent) {
//        _commentContent = [[UILabel alloc] init];
//        _commentContent.numberOfLines = 0;
//        NSString *str = @"￼ 物流超乎想象的快，中午下单，下午就到了，包装完美，今天就迫不及待的试用了一下，真的很好用，nice！";
//        
//        _commentContent.attributedText = [NSString getAttributedWithString:str WithLineSpace:2 kern:2 font:[UIFont systemFontOfSize:14] color:[UIColor blackColor]];
//    }
//    return _commentContent;
//}
//
//#pragma mark - 店铺
//- (UIImageView *)storeIm2{
//    
//    if (!_storeIm2) {
//        
//        _storeIm2 = [[UIImageView alloc] init];
//    }
//    return _storeIm2;
//}
//
//- (UILabel *)storeName{
//    
//    if (!_storeName) {
//        
//        _storeName = [[UILabel alloc] init];
//        _storeName.attributedText = [NSString getAttributedWithString:@"店铺名称" WithLineSpace:0 kern:2 font:[UIFont systemFontOfSize:17] color:UIColor.blackColor];
//        _storeName.font = [UIFont systemFontOfSize:16];
//    }
//    return _storeName;
//}
//
//- (JTImageButton *)goStoreBtn{
//    
//    if (!_goStoreBtn) {
//        
//        _goStoreBtn = [[JTImageButton alloc] init];
//        [_goStoreBtn createTitle:@"点击进入店铺" withIcon:[UIImage imageNamed:@"img_upgrade"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
//        _goStoreBtn.borderWidth = 0.0;
//        _goStoreBtn.titleColor = UIColor.blackColor;
//        _goStoreBtn.iconSide = JTImageButtonIconSideRight;
//        [_goStoreBtn addTarget:self action:@selector(onGoStoreBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _goStoreBtn;
//}
//
//- (void)onGoStoreBtn:(UIButton *)sender{
//    
//    [self.viewController.view makeToast:@"点击进入店铺" duration:1.0 position:CSToastPositionBottom];
//}
//
//- (UILabel *)bbDesLa{
//    
//    if (!_bbDesLa) {
//        
//        _bbDesLa = [[UILabel alloc] init];
//        _bbDesLa.text = @"宝贝描述 0.0";
//        _bbDesLa.textAlignment = NSTextAlignmentLeft;
//        _bbDesLa.textColor = UIColor.lightGrayColor;
//        _bbDesLa.font = [UIFont systemFontOfSize:13];
//        
//    }
//    return _bbDesLa;
//}
//
//- (UILabel *)salerServiceLa{
//    
//    if (!_salerServiceLa) {
//        
//        _salerServiceLa = [[UILabel alloc] init];
//        _salerServiceLa.text = @"卖家服务 0.0";
//        _salerServiceLa.textAlignment = NSTextAlignmentCenter;
//        _salerServiceLa.textColor = UIColor.lightGrayColor;
//        _salerServiceLa.font = [UIFont systemFontOfSize:13];
//        
//    }
//    return _salerServiceLa;
//}
//
//- (UILabel *)logisticsServiceLa{
//    
//    if (!_logisticsServiceLa) {
//        
//        _logisticsServiceLa = [[UILabel alloc] init];
//        _logisticsServiceLa.text = @"物流服务 0.0";
//        _logisticsServiceLa.textAlignment = NSTextAlignmentRight;
//        _logisticsServiceLa.textColor = UIColor.lightGrayColor;
//        _logisticsServiceLa.font = [UIFont systemFontOfSize:13];
//        
//    }
//    return _logisticsServiceLa;
//}
//
//- (UIView *)storeView{
//    
//    if (!_storeView) {
//        
//        _storeView = [[UIView alloc] init];
//        _storeView.backgroundColor = BaseBackGroundColor;
//        
//        CGFloat marign = 10;
//        CGFloat spading = 14;
//        
//        UIView *bgView = [[UIView alloc] init];
//        bgView.backgroundColor = UIColor.whiteColor;
//        [_storeView addSubview:bgView];
//        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self->_storeView).with.insets(UIEdgeInsetsMake(marign, 0, marign, 0));
//        }];
//        
//        [bgView addSubview:self.storeIm2];
//        [bgView addSubview:self.storeName];
//        [bgView addSubview:self.goStoreBtn];
//        [bgView addSubview:self.bbDesLa];
//        [bgView addSubview:self.salerServiceLa];
//        [bgView addSubview:self.logisticsServiceLa];
//        
//        [self.storeIm2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(marign);
//            make.top.mas_equalTo(spading);
//            make.width.mas_equalTo(30);
//            make.height.mas_equalTo(15);
//        }];
//        
//        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.storeIm2.mas_right).offset(5);
//            make.centerY.equalTo(self.storeIm2);
//        }];
//        
//        [self.goStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-marign);
//            make.centerY.equalTo(self.storeIm2);
//        }];
//        
//        NSArray *arr = @[self.bbDesLa,self.salerServiceLa,self.logisticsServiceLa];
//        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:14 tailSpacing:14];
//        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.storeIm2.mas_bottom);
//            make.bottom.mas_equalTo(0);
//        }];
//
//    }
//    return _storeView;
//}
//
//#pragma mark - 推荐
//- (UILabel *)reLa{
//    
//    if (!_reLa) {
//        _reLa = [[UILabel alloc] init];
//        _reLa.numberOfLines = 0;
//        NSString *str = @"￼     纯棉纱布浴巾，多层柔软透气纱布，亲肤更舒适，超强吸水，不起球，越洗手感越蓬松柔软，给宝宝最好的呵护！【赠运费险】";
//        
//        _reLa.attributedText = [NSString getAttributedWithString:str WithLineSpace:2 kern:2 font:[UIFont systemFontOfSize:14] color:[UIColor blackColor]];
//    }
//    return _reLa;
//}
//
//- (UIView *)recView{
//    
//    if (!_recView) {
//        
//        _recView = [[UIView alloc] init];
//        
//        UIImageView  *im = [[UIImageView alloc] init];
//        im.image = [UIImage imageNamed:@"img_godsdetailRec"];
//        [_recView addSubview:im];
//        
//        [_recView addSubview:self.reLa];
//        [_recView addSubview:im];
//    
//        [_reLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self->_recView).width.insets(UIEdgeInsetsMake(0, 10, 0, 10));
//        }];
//        
//        [im mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(2);
//            make.width.mas_equalTo(32);
//            make.height.mas_equalTo(18);
//        }];
//        
//    }
//    return _recView;
//}
//
//
//#pragma mark - 领券
//- (UIImageView *)rightImg{
//    
//    if (!_rightImg) {
//        
//        _rightImg = [[UIImageView alloc] init];
////        _rightImg.backgroundColor = UIColor.redColor;
//        _rightImg.image = [UIImage imageNamed:@"youhuiquanright"];
//    }
//    return _rightImg;
//}
//
//
//- (UIButton *)rightBuyBtn{
//    
//    if (!_rightBuyBtn) {
//        
//        _rightBuyBtn = [[UIButton alloc] init];
//        [_rightBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
//        [_rightBuyBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        _rightBuyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _rightBuyBtn;
//}
//
//- (UILabel *)quanTimeLa{
//    
//    if (!_quanTimeLa) {
//        
//        _quanTimeLa = [[UILabel alloc] init];
//        _quanTimeLa.text = @"2019-09-09";
//        _quanTimeLa.textColor = UIColor.whiteColor;
//        _quanTimeLa.font = [UIFont boldSystemFontOfSize:12];
//    }
//    return _quanTimeLa;
//}
//
//- (UILabel *)quanValueLa{
//    
//    if (!_quanValueLa) {
//        
//        _quanValueLa = [[UILabel alloc] init];
//        _quanValueLa.text = @"0";
//        _quanValueLa.textColor = UIColor.whiteColor;
//        _quanValueLa.font = [UIFont boldSystemFontOfSize:30];
//    }
//    return _quanValueLa;
//}
//
//- (UIImageView *)fengeIm{
//    if (!_fengeIm) {
//        
//        _fengeIm = [[UIImageView alloc] init];
//        _fengeIm.image = [UIImage imageNamed:@"img_fengeIm"];
//    }
//    return _fengeIm;
//}
//
//- (UIView *)quanColorView{
//    
//    if (!_quanColorView) {
//        
//        _quanColorView = [[UIView alloc] init];
//        [_quanColorView az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
//        
//        [_quanColorView addSubview:self.fengeIm];
//        
//        UILabel *la = [[UILabel alloc] init];
//        la.text = @"¥";
//        la.textColor = UIColor.whiteColor;
//        la.font = [UIFont systemFontOfSize:15];
//        [_quanColorView addSubview:la];
//        
//        [_quanColorView addSubview:self.quanValueLa];
//        
//        UILabel *la2 = [[UILabel alloc] init];
//        la2.text = @"优惠券有效期至";
//        la2.textColor = UIColor.whiteColor;
//        la2.font = [UIFont systemFontOfSize:12];
//        [_quanColorView addSubview:la2];
//        
//        [_quanColorView addSubview:self.quanTimeLa];
//        
//        [_quanColorView addSubview:self.rightBuyBtn];
//        
//        [self.fengeIm mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-100);
//            make.top.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(15);
//        }];
//        
//        [la mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(14);
//            make.bottom.equalTo(self.quanValueLa);
//        }];
//        
//        [self.quanValueLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(la.mas_right).offset(5);
//            make.centerY.equalTo(self->_quanColorView);
//            make.height.mas_equalTo(25);
//        }];
//        
//        [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.quanValueLa.mas_right).offset(5);
//            make.top.equalTo(self.quanValueLa);
//            make.height.mas_equalTo(12.5);
//        }];
//        
//        [self.quanTimeLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.quanValueLa.mas_right).offset(5);
//            make.bottom.equalTo(self.quanValueLa);
//            make.height.mas_equalTo(12.5);
//        }];
//        
//        [self.rightBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self->_quanColorView.mas_right);
//            make.top.bottom.mas_equalTo(0);
//            make.left.equalTo(self.fengeIm.mas_right);
//        }];
//    }
//    return _quanColorView;
//}
//
//- (UIView *)quanBgView{
//    
//    if (!_quanBgView) {
//        
//        _quanBgView = [[UIView alloc] init];
//        _quanBgView.backgroundColor = BaseBackGroundColor;
//        
//        [_quanBgView addSubview:self.quanColorView];
//        
//        [_quanBgView addSubview:self.rightImg];
//        
//        [self.quanColorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self->_quanBgView).with.insets(UIEdgeInsetsMake(10, 10, 10, 14));
//        }];
//        
//        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(4);
//            make.top.bottom.equalTo(self.quanColorView);
//            make.left.equalTo(self.quanColorView.mas_right);
//        }];
//        
//    }
//    return _quanBgView;
//}
//
//#pragma mark - 商品描述
//- (UILabel *)goodsDesLa{
//    
//    if (!_goodsDesLa) {
//        
//        _goodsDesLa = [[UILabel alloc] init];
//        _goodsDesLa.numberOfLines = 0;
//    }
//    return _goodsDesLa;
//}
//
//- (UIImageView *)storeLogoIm{
//    
//    if (!_storeLogoIm) {
//        
//        _storeLogoIm = [[UIImageView alloc] init];
//    }
//    return _storeLogoIm;
//}
//
//#pragma mark - 平台奖励
//- (JTImageButton *)upgradeBtn{
//    
//    if (!_upgradeBtn) {
//        
//        _upgradeBtn = [[JTImageButton alloc] init];
//        [_upgradeBtn createTitle:@"立即升级" withIcon:[UIImage imageNamed:@"img_upgrade"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
//        _upgradeBtn.borderWidth = 0.0;
//        _upgradeBtn.titleColor = UIColor.blackColor;
//        _upgradeBtn.iconSide = JTImageButtonIconSideRight;
//        [_upgradeBtn addTarget:self action:@selector(onUpgradeBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    
//    return _upgradeBtn;
//}
//
//- (void)onUpgradeBtn:(UIButton *)sender{
//    
//    [self.viewController.view makeToast:@"点击立即升级" duration:1.0 position:CSToastPositionBottom];
//}
//
//- (UILabel *)leveRewardLa{
//    
//    if (!_leveRewardLa) {
//        
//        _leveRewardLa = [[UILabel alloc] init];
//        _leveRewardLa.text = @"¥ 0.00";
//        _leveRewardLa.textColor = SMOrangeColor;
//        _leveRewardLa.font = [UIFont systemFontOfSize:12];
//        
//    }
//    return _leveRewardLa;
//}
//
//- (UILabel *)leveLa{
//    
//    if (!_leveLa) {
//        
//        _leveLa = [[UILabel alloc] init];
//        _leveLa.text = @"升级奖励";
//        _leveLa.font = [UIFont systemFontOfSize:12];
//        
//    }
//    return _leveLa;
//}
//
//- (UILabel *)platformRewardLa{
//    
//    if (!_platformRewardLa) {
//        
//        _platformRewardLa = [[UILabel alloc] init];
//        _platformRewardLa.text = @"平台奖励 ¥ 0.00";
//        _platformRewardLa.textColor = UIColor.whiteColor;
//        _platformRewardLa.textAlignment = NSTextAlignmentCenter;
//        _platformRewardLa.font = [UIFont systemFontOfSize:12];
//        
//    }
//    return _platformRewardLa;
//}
//
//- (UIView *)rewardBgView2{
//    
//    if (!_rewardBgView2) {
//        
//        _rewardBgView2 = [[UIView alloc] init];
//        _rewardBgView2.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
//        [_rewardBgView2 addSubview:self.platformRewardLa];
//        [self.platformRewardLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(0);
//        }];
//    }
//    return _rewardBgView2;
//}
//
//- (UIView *)rewardBgView{
//    
//    if (!_rewardBgView) {
//        
//        _rewardBgView = [[UIView alloc] init];
//        _rewardBgView.backgroundColor = [UIColor colorWithHexString:@"FDF4D5"];
//        
//        [_rewardBgView addSubview:self.rewardBgView2];
//        
//        UIImageView *im = [[UIImageView alloc] init];
//        im.image = [UIImage imageNamed:@"img_rewardjiantou"];
//        [_rewardBgView addSubview:im];
//        
//        [_rewardBgView addSubview:self.leveLa];
//        [_rewardBgView addSubview:self.leveRewardLa];
//        
//        [_rewardBgView addSubview:self.upgradeBtn];
//        
//        [self.rewardBgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(125);
//        }];
//        
//        [im mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self->_rewardBgView);
//            make.left.equalTo(self->_rewardBgView2.mas_right);
//        }];
//        
//        [self.leveLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(im.mas_right).offset(8);
//            make.top.bottom.mas_equalTo(0);
//        }];
//        
//        [self.leveRewardLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.leveLa.mas_right).offset(5);
//            make.top.bottom.mas_equalTo(0);
//        }];
//        
//        [self.upgradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-10);
//            make.centerY.equalTo(self->_rewardBgView);
////            make.height.mas_equalTo(22);
//        }];
//    }
//    return _rewardBgView;
//}
//
//
//#pragma mark - 券后价格一行
//- (JTImageButton *)searchBtn{
//    
//    if (!_searchBtn) {
//        
//        _searchBtn = [[JTImageButton alloc] init];
//        [_searchBtn createTitle:@"找同款" withIcon:[UIImage imageNamed:@"img_searchSame"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
//        _searchBtn.borderWidth = 0.0;
//        _searchBtn.titleColor = UIColor.blackColor;
//        _searchBtn.iconSide = JTImageButtonIconSideLeft;
//        [_searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _searchBtn;
//}
//
//- (void)onSearchBtn:(UIButton *)sender{
//    
//    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
//    [self.viewController.navigationController pushViewController:vc animated:YES];
//}
//
//- (UILabel *)saleNumLa{
//    
//    if (!_saleNumLa) {
//        
//        _saleNumLa = [[UILabel alloc] init];
//        _saleNumLa.text = @"销量 20万+";
//        _saleNumLa.textColor = UIColor.lightGrayColor;
//        _saleNumLa.font = [UIFont systemFontOfSize:12];
//        
//    }
//    return _saleNumLa;
//}
//
//- (UILabel *)quanHouLa{
//    
//    if (!_quanHouLa) {
//        
//        _quanHouLa = [[UILabel alloc] init];
//        _quanHouLa.text = @"券后";
//        _quanHouLa.textColor = UIColor.lightGrayColor;
//        _quanHouLa.font = [UIFont systemFontOfSize:12];
//        
//    }
//    return _quanHouLa;
//}
//
//- (UILabel *)fuhaolLa{
//    
//    if (!_fuhaolLa) {
//        
//        _fuhaolLa = [[UILabel alloc] init];
//        _fuhaolLa.text = @"¥";
//        _fuhaolLa.textColor = SMOrangeColor;
//        _fuhaolLa.font = [UIFont boldSystemFontOfSize:15];
//        
//    }
//    return _fuhaolLa;
//}
//
//- (UILabel *)priceLa{
//    
//    if (!_priceLa) {
//        
//        _priceLa = [[UILabel alloc] init];
//        _priceLa.textColor = SMOrangeColor;
//        _priceLa.font = [UIFont boldSystemFontOfSize:25];
//        
//    }
//    return _priceLa;
//}

#pragma mark - 当前播放图片index
- (UILabel *)indexLa{
    
    if (!_indexLa) {
        
        _indexLa = [[UILabel alloc] init];
        _indexLa.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _indexLa.layer.cornerRadius = 12;
        _indexLa.layer.masksToBounds = YES;
        _indexLa.textAlignment = NSTextAlignmentCenter;
        _indexLa.textColor = UIColor.whiteColor;
        _indexLa.font = [UIFont systemFontOfSize:12];
    }
    return _indexLa;
}

//#pragma mark - 播报轮播
//- (ProductNewsListView *)newsListView{
//
//    if (!_newsListView) {
//
//        _newsListView = [[ProductNewsListView alloc] init];
//    }
//    return _newsListView;
//}

#pragma mark - 商品图片轮播
- (SDCycleScrollView *)imgSDView{
    
    if (!_imgSDView) {
        
         _imgSDView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
        _imgSDView.showPageControl = NO;
        _imgSDView.autoScroll = NO;
        _imgSDView.imageURLStringsGroup = self.imgArr;
        
    };
    return _imgSDView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imgSDView];
        [self addSubview:self.indexLa];
//        [self addSubview:self.newsListView];
//        [self addSubview:self.fuhaolLa];
//        [self addSubview:self.priceLa];
//        [self addSubview:self.quanHouLa];
//        [self addSubview:self.saleNumLa];
//        [self addSubview:self.searchBtn];
////        [self addSubview:self.rewardBgView];
//        [self addSubview:self.storeLogoIm];
//        [self addSubview:self.goodsDesLa];
//        [self addSubview:self.quanBgView];
//        [self addSubview:self.recView];
//        [self addSubview:self.storeView];
//
//        [self addSubview:self.commentNumLa];
//        [self addSubview:self.commentUserIm];
//        [self addSubview:self.commentUserName];
//        [self addSubview:self.commentContent];
        
        CGFloat marign = 10;
        CGFloat imgHeight = KScreenWidth;
        
        [self.imgSDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(imgHeight);
        }];
        
        [self.indexLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-marign);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(imgHeight - 30);
        }];
        
//        [self.newsListView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(marign);
//            make.right.equalTo(self.indexLa.mas_left).offset(-marign);
//            make.top.mas_equalTo(imgHeight - 30);
//            make.height.mas_equalTo(25);
//        }];
        
//        [self.fuhaolLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(marign);
//            make.top.equalTo(self.imgSDView.mas_bottom).offset(marign * 2);
//            make.height.mas_equalTo(15);
//        }];
//
//        [self.priceLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.fuhaolLa.mas_right).offset(5);
//            make.bottom.equalTo(self.fuhaolLa.mas_bottom);
//            make.height.mas_equalTo(25);
//        }];
//
//        [self.quanHouLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.priceLa.mas_right).offset(2);
//            make.bottom.equalTo(self.priceLa.mas_bottom);
//        }];
//
//        [self.saleNumLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.bottom.equalTo(self.priceLa.mas_bottom);
//        }];
//
//        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.saleNumLa);
//            make.right.mas_equalTo(-space);
//        }];
//
////        [self.rewardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.mas_equalTo(marign);
////            make.right.mas_equalTo(-marign);
////            make.top.equalTo(self.priceLa.mas_bottom).offset(15);
////            make.height.mas_equalTo(28);
////        }];
//
//        [self.storeLogoIm mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.priceLa.mas_bottom).offset(15);
//            make.left.mas_equalTo(marign);
//            make.width.mas_equalTo(30);
//            make.height.mas_equalTo(15);
//        }];
//
//        [self.goodsDesLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.priceLa.mas_bottom).offset(15);
//            make.left.equalTo(self.storeLogoIm);
//            make.right.mas_equalTo(-10);
//        }];
//
//        [self.quanBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.equalTo(self.goodsDesLa.mas_bottom).offset(marign);
//            make.height.mas_equalTo(100);
//        }];
//
//        [self.recView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.equalTo(self.quanBgView.mas_bottom);
//            make.height.mas_equalTo(60);
//        }];
//
//        [self.storeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.equalTo(self.recView.mas_bottom);
//            make.height.mas_equalTo(100);
//        }];
//
//        [self.commentNumLa mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(marign);
//            make.top.equalTo(self.storeView.mas_bottom).offset(space);
//            make.height.mas_equalTo(20);
//        }];
//
//        [self.commentUserIm mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.commentNumLa);
//            make.top.equalTo(self.commentNumLa.mas_bottom).offset(marign);
//            make.width.height.mas_equalTo(40);
//        }];
//
//        [self.commentUserName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.commentUserIm.mas_right).offset(marign);
//            make.centerY.equalTo(self.commentUserIm);
//        }];
//
//        [self.commentContent mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.commentNumLa);
//            make.right.mas_equalTo(-marign);
//            make.top.equalTo(self.commentUserIm.mas_bottom).offset(marign);
//            make.bottom.mas_equalTo(-space);
//        }];
    }
    return self;
}

#pragma mark - SDCycleScrollViewDelegate
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    self.indexLa.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imgArr.count];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.imgArr enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {

            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
//            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];

        } else if ([obj hasSuffix:@".mp4"]) {

            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
//            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];

        } else if ([obj hasPrefix:@"http"]) {

            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
//            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];

        } else {

            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
//            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];

        }
    }];

    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    [browser show];
}

- (void)setDetailModel:(ProductDetailModel *)detailModel{
    
//    self.priceLa.text = [NSString stringWithFormat:@"%.2f",[detailModel.ZkFinalPrice floatValue] - [detailModel.CouponAmount floatValue]];
//    self.storeName.text = detailModel.ShopTitle;
//    self.platformRewardLa.text = [NSString stringWithFormat:@"平台奖励 ¥ %@",detailModel.PlatFormBonus];
//
//    self.quanValueLa.text = detailModel.CouponAmount;
//    self.quanTimeLa.text = [[NSString changeWithTime:detailModel.CouponEndTime] substringWithRange:NSMakeRange(0, 10)];
//
//    NSString *title = [NSString stringWithFormat:@"         %@",detailModel.Title];
//    NSAttributedString *attTitle = [NSString getAttributedWithString:title WithLineSpace:3 kern:0.5 font:[UIFont systemFontOfSize:12] color:[UIColor blackColor]];
//    self.goodsDesLa.attributedText = attTitle;
//
//    self.storeLogoIm.image = [UIImage imageNamed:@"天猫logo"];

    self.imgArr = detailModel.imgArr;
    self.imgSDView.imageURLStringsGroup = detailModel.imgArr;
    self.indexLa.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self.imgArr.count];
}

@end
