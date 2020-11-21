//
//  ProductDetailStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProductDetailModel;

@interface ProductDetailStore : NSObject

/**
 获取商品详情接口（基础）

 @param identity 用户标识（1：合伙人 2：团长 3：超级团长）
 @param itmeid 商品ID
 @param title  商品标题（作用于模糊检索）
 */
+(void)getProductDetailWithIdentity:(NSInteger)identity itmeid:(NSString *)itmeid title:(NSString *)title Success:(void(^)(ProductDetailModel *detailModel))success Failure:(void(^)(NSError *error))failure;

/**
 获取商品详情-相关推荐商品信息
 
 @param itemid 商品ID
 @param count 页 推荐条目（示例：4条）<=20
 */
+(void)getProductRecommendWithIdentity:(NSInteger)identity itemid:(NSString *)itemid title:(NSString *)title count:(NSInteger)count Success:(void(^)(NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure;


/**
 获取商品店铺评价、用户评论数据
 */
-(void)getProductOtherInfoWothItemNumId:(NSString *)itemNumId Success:(void(^)(NSString *baobeiScore, NSString *maijiaServiceScore, NSString *wuliuScore, NSString *commentCount, NSString *commentUserName, NSString *commentUserIcon, NSString *commentContent))success Failure:(void(^)(NSError *error))failure;

/**
 获取商品图片
 */
-(void)getProductPicsWothItemNumId:(NSString *)itemNumId Success:(void(^)(NSString *htmlStr))success Failure:(void(^)(NSError *error))failure;

@end

