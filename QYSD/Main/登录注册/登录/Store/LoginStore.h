//
//  LoginStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginParameters;

@interface LoginStore : NSObject


/**
 用户登录

 @param loginParameters 登录参数模型

 */
+(void)loginWithParamters:(LoginParameters *)loginParameters Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure;

@end


