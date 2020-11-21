//
//  HeaderChildStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderChildStore : NSObject


/**
 获取首页导航栏目商品数据

 @param navigateid 导航ID
 @param identity  用户标识（1：合伙人 2：团长 3：超级团长）
 */
+(void)getNavigateproductWithNavigateid:(NSString *)navigateid Identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Sort:(NSString *)sort Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure;

@end


