//
//  CollectorStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/24.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectorStore : NSObject



/**
  收藏或取消收藏商品

 @param userguid 用户guid
 @param identity <#identity description#>
 @param itemid <#itemid description#>
 @param title <#title description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)addCollectorWithUserguid:(NSString *)userguid identity:(NSInteger) identity itemid:(NSString *)itemid title:(NSString *)title Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

/**
 获取收藏列表

 @param userguid 用户guid，Guid类型，示例：0F2F0A82-1B63-4E98-8462-E13FAC6A4924
 @param pageno  页码
 @param pagesize 页面容量，示例：20
 */
+(void)getCollectorListWithUserguid:(NSString *)userguid identity:(NSInteger) identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure;


/**
 判断商品是否已收藏

 @param userguid 用户id
 @param itemid 商品id
 */
+(void)judgeGoodsIfCollectorWithUserguid:(NSString *)userguid identity:(NSInteger) identity itemid:(NSString *)itemid Success:(void(^)(BOOL hadCollector))success Failure:(void(^)(NSError *error))failure;

@end


