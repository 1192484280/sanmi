//
//  HeaderSearchStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchCouponsParamtersModel;

@interface HeaderSearchStore : NSObject

//获取热门检索词条
+ (void)getHotSearchListSuccess:(void(^)(NSArray *hotSearchArr))success Failure:(void(^)(NSError *error))failure;

/**
 获取搜索商品优惠卷信息
 */
+(void)getSearchCouponsWithParamter:(SearchCouponsParamtersModel *)paramters Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure;

@end

