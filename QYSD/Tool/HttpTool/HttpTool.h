//
//  HttpTool.h
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpTool : NSObject

//+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postUrlWithKey:(NSString *)key parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postUrl:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 上传图片
 */
+ (void)uploadFileWithKey:(NSString *)key parameters:(id)parameters imgArr:(NSArray *)imgArr  name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (NSError *)inspectError:(NSDictionary *)responseObject;

+ (NSString *)handleError:(NSError *)error;

#pragma mark - 监控网络状态
+ (void)netWorkState:(void(^)(NSInteger status))block;

#pragma mark - 从plist中读取url
+ (NSString *)getUrlWithKey:(NSString *)key;
@end
