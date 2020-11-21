//
//  CommonStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface CommonStore : NSObject

/**
 获取基础配置信息
 (资源上传地址)
 */
+ (void)getBasicinfoSucess:(void(^)(NSString *prefixpath))sucess Failure:(void(^)(NSError *error))failure;

/**
 上传文件
 */
+ (void)getUploadfilesListWithBusstype:(NSInteger)busstype imags:(NSArray *)imags Sucess:(void(^)(NSArray *theArr))sucess Failure:(void(^)(NSError *error))failure;


/**
 获取用户信息

 @param userguid  用户guid
 */
+ (void)getUserInfoWithUserguid:(NSString *)userguid Sucess:(void(^)(UserModel *userModel))success Failure:(void(^)(NSError *error))failure;


/**
 获取下载连接

 */
+ (void)getAPPDownLoadUrlSucess:(void(^)(NSString *url))success Failure:(void(^)(NSError *error))failure;


/**
获取当前app版本
 
 */
+ (void)getAPPVersionSucess:(void(^)(NSString *version))success Failure:(void(^)(NSError *error))failure;

/**
获取版本更新内容
 
 */
+ (void)getAPPVersionUpInfoSucess:(void(^)(NSAttributedString *upInfo))success Failure:(void(^)(NSError *error))failure;


@end


