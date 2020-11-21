//
//  CacheManager.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject

//j获取缓存
+(NSString *)getCachesSize;

// 清除缓存
+ (void)removeCache;

@end

NS_ASSUME_NONNULL_END
