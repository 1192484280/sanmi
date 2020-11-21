//
//  GoodsModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
ItemId：商品ID PictUrl：商品主图 Title：商品标题 ShopTitle：店铺名称 CouponAmount：优惠券面额 ZkFinalPrice：商品折扣价格（即：原价） UserType：卖家类型 0：集市 1：天猫（用于前端图标显示） PlatFormBonus：平台奖励金（不同的用户身份， 此处奖励金动态不同。示例：合伙人/团长/超级团长）
 */

@interface GoodsModel : NSObject

@property (nonatomic, copy) NSString *ItemId;
@property (nonatomic, copy) NSString *PictUrl;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *ShopTitle;
@property (nonatomic, copy) NSString *CouponAmount;
@property (nonatomic, copy) NSString *Volume;
@property (nonatomic, copy) NSString *ZkFinalPrice;
@property (nonatomic, assign) NSInteger UserType;
@property (nonatomic, copy) NSString *PlatFormBonus;

@end

