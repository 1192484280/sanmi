//
//  OpinionStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpinionStore : NSObject
/**
获取意见反馈类型

 */
+ (void)getFeedbacktypeSucess:(void(^)(NSArray *theArr))sucess Failure:(void(^)(NSError *error))failure;



/**
 提交意见反馈

 @param userguid 用户guid
 @param feedbacktypeid 反馈类型
 @param feedbackcontent 反馈内容
 @param imgurls  图片相对路径，逗号隔开
 */
+ (void)feedbackWithUserguid:(NSString *)userguid feedbacktypeid:(NSString *)feedbacktypeid feedbackcontent:(NSString *)feedbackcontent imgurls:(NSString *)imgurls Sucess:(void(^)(void))sucess Failure:(void(^)(NSError *error))failure;


@end


