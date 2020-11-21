//
//  MyFeedBackStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFeedBackStore : NSObject

/**
 获取意见反馈数据集
 */
+(void)getFeedbacklistWithUserguid:(NSString *)userguid pageno:(NSInteger)pageno pagesize:(NSInteger)pagesize Sucess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
