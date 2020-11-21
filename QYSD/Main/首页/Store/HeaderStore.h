//
//  HeaderStore.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderStore : NSObject


/**
 获取推荐页面数据

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getHeaderInfoSuccess:(void(^)(NSArray *styleOneArr,NSArray *styleTwoArr))success Failure:(void(^)(NSError *error))failure;

/**
 获取首页导航栏目

 @param parentnavigateid 父级id，一级为0，获取子集传其父级id
 */
+ (void)getHomeNavigateWithParentnavigateid:(NSString *)parentnavigateid Success:(void(^)(NSArray *modelArr,NSArray *textArr))success Failure:(void(^)(NSError *error))failure;

@end


