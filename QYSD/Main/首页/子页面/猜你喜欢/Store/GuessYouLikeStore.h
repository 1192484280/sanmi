//
//  GuessYouLikeStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessYouLikeStore : NSObject

/**
 获取猜你喜欢数据
 
 @param identity 用户标识（1：合伙人 2：团长 3：超级团长）
 @param pageno 页
 @param pagesize size
 */
+(void)getGuessLikeWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure;

@end


