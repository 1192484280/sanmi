//
//  ProductDetailModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

/*
 ItemId：商品ID
PictUrl：商品主图
 Title：商品标题
 ShopTitle：店铺名称
 CouponAmount：优惠券面额
 ZkFinalPrice：商品折扣价格（即：原价）
 UserType：卖家类型 0：集市 1：天猫（用于前端图标显示）
 PlatFormBonus：平台奖励金（不同的用户身份，此处奖励金动态不同。示例：合伙人/团长/超级团长）
 PlatFormBonus_Up：平台升级奖励金（不同的用户身份，此处奖励金动态不同。示例：合伙人/团长/超级团长） CommissionRate：佣金比率
 CouponStartTime：优惠券开始时间 CouponEndTime：优惠券结束时间
 CouponShareUrl：推广链接 ItemDescription：推荐理由
 Volume:销量
 */

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject

@property (nonatomic, copy) NSString *ItemId;
@property (nonatomic, copy) NSString *PictUrl;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *CouponAmount;
@property (nonatomic, copy) NSString *Volume;
@property (nonatomic, copy) NSString *ZkFinalPrice;
@property (nonatomic, assign) NSInteger UserType;
@property (nonatomic, copy) NSString *SellerId;
@property (nonatomic, copy) NSString *ShopTitle;
@property (nonatomic, copy) NSString *PlatFormBonus;
@property (nonatomic, copy) NSString *CommissionRate;
@property (nonatomic, copy) NSString *CouponStartTime;
@property (nonatomic, copy) NSString *CouponEndTime;
@property (nonatomic, copy) NSString *CouponShareUrl;
@property (nonatomic, copy) NSString *ItemDescription;
@property (nonatomic, copy) NSString *SmallImageUrls;
@property (nonatomic, copy) NSArray *imgArr;

@property (nonatomic, copy) NSString *baobeimiaoshu;//宝贝描述
@property (nonatomic, copy) NSString *maijiafuwu;//卖家服务
@property (nonatomic, copy) NSString *wuliufuwu;//物流服务

@property (nonatomic, copy) NSString *baobeicomment;//评论数量
@property (nonatomic, copy) NSString *commentIcon;//评论人头像
@property (nonatomic, copy) NSString *commentName;//评论人昵称
@property (nonatomic, copy) NSString *commentDes;//评论内容

@end


