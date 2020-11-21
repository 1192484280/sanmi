//
//  RecommendStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendStore : NSObject

/**
 获取推荐轮播图
 */
+ (void)getHomeBannerSuccess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure;

/**
 获取推荐菜单按钮
 */
+ (void)getFunctionNavigateSuccess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure;


/**
 获取首页精选数据

 @param identity 用户标识（1：合伙人 2：团长 3：超级团长）
 @param pageno 页
 @param pagesize size
 */
+(void)getQualityProductWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure;


/**
 获取首页精选物料导航栏目

 @param parentnavigateid "-1"为父级栏目，其余为子集栏目
 */
+(void)getHomejxwlWithParentnavigateid:(NSInteger)parentnavigateid Success:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure;

/**
 获取精选物料信息（母婴专区/品牌券/大额券/高佣榜）
 
@param materialid 物料id，示例：9660 （参考官方精品商品库id） 
 @param identity 用户标识（1：合伙人 2：团长 3：超级团长）
 @param pageno 页
 @param pagesize size
 */
+(void)getOptimusMaterialWithMaterialid:(NSInteger)materialid identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure;


/**
 获取首页自定义活动管理数据集
 
 */
+(void)getHomeActivitySuccess:(void(^)(NSArray *oldArr,NSArray *theArr))success Failure:(void(^)(NSError *error))failure;
@end


