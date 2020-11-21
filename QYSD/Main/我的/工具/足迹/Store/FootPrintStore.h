//
//  FootPrintStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/25.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootPrintStore : NSObject

/**
 添加足迹

 @param userguid 用户guid
 @param identity   用户标识（1：合伙人 2：团长 3：超级团长）
 @param itemid  商品id
 @param title   商品标题
 */
+(void)addBrowseproductUserguid:(NSString *)userguid identity:(NSInteger)identity itemid:(NSString *)itemid title:(NSString *)title Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

/**
 获取足迹列表
 
 @param userguid 用户guid，Guid类型，示例：0F2F0A82-1B63-4E98-8462-E13FAC6A4924
 @param pageno  页码
 @param pagesize 页面容量，示例：20
 */
+(void)getFootPrintListWithUserguid:(NSString *)userguid identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure;

@end


