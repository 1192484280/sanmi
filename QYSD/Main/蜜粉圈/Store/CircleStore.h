//
//  CircleStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleStore : NSObject

/**
 商品推荐导航栏目
 */
+(void)getMerchandiseRecomendNavSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;

/**
 获取营销素材、新手必发
 
 @param type 类型:4-营销素材，5-新手必发
 @param pageno 页码，示例：1
 @param pagesize 页面容量，示例：20
 */
+(void)getFQmaterialWithType:(NSInteger)type andNavigateid:(NSInteger)navigateid pageno:(NSInteger)pageno pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure;

@end


