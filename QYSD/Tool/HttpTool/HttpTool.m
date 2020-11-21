//
//  HttpTool.m
//  TradeCloud
//
//  Created by zhangming on 2018/4/10.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "HttpTool.h"
#import "HttpSessionManager.h"
#import <CFNetwork/CFNetwork.h>

//成功返回的标志
#define SuccessResponseCode 1

//网络回传失败域
#define ResponseFailureDomain @"ResponseFailureDomain"

@implementation HttpTool

+ (void)postUrlWithKey:(NSString *)key parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
{
    HttpSessionManager *manager = [HttpSessionManager shareManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
   
    NSString *pathUrl = [HttpTool getUrlWithKey:key];
    
    if ([self hasSetProxy]) {
        
        return;
    }

    [manager POST:pathUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = responseObject;
        
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postUrl:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    HttpSessionManager *manager = [HttpSessionManager shareManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
    
    if ([self hasSetProxy]) {
        
        return;
    }
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = responseObject;
        
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}

#pragma mark - 上传图片
+ (void)uploadFileWithKey:(NSString *)key parameters:(id)parameters imgArr:(NSArray *)imgArr  name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    HttpSessionManager *manager = [HttpSessionManager shareManager];
    
    NSString *pathUrl = [HttpTool getUrlWithKey:key];
    
    [manager POST: pathUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [imgArr enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
             NSData *imageData = UIImageJPEGRepresentation(image,0.2);
            if (imageData != nil) {
                
                NSString *name = [NSString stringWithFormat:@"file%lu",(unsigned long)idx];
                NSString *imgName = [NSString stringWithFormat:@"ios_%lu.jpg",(unsigned long)idx];
                [formData appendPartWithFileData:imageData name:name fileName:imgName mimeType:@"image/jpeg"];
            }
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = responseObject;
        
        if (success) {
            
            
            success(responseDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSError *)inspectError:(NSDictionary *)responseObject {
    
    if ([responseObject[@"code"] integerValue] == 200) {
        
        return nil;
    } else {
        
        NSError *error = [NSError errorWithDomain:ResponseFailureDomain code:[responseObject[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"], NSLocalizedFailureReasonErrorKey:responseObject[@"msg"]}];
        return error;
    }
}

#pragma mark - 解析错误信息
+ (NSString *)handleError:(NSError *)error {
    if ([[error domain] isEqualToString:ResponseFailureDomain]) {
        
        return [error localizedDescription];
        
    } else {
        
        return @"网络错误，请检查您的网络配置";
    }
}

#pragma mark - 监控网络状态
+(void)netWorkState:(void(^)(NSInteger status))block{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        block(status);
    }];
}

#pragma mark - 从plist中读取url
+ (NSString *)getUrlWithKey:(NSString *)key{
    
    NSString *theIP = IP;
    if ([key isEqualToString:@"searchcoupons"] || [key isEqualToString:@"qualityproduct"] || [key isEqualToString:@"guesslike"] || [key isEqualToString:@"productrecommend"] || [key isEqualToString:@"optimusmaterial"] || [key isEqualToString:@"getproductdetail"] || [key isEqualToString:@"navigateproduct"] || [key isEqualToString:@"producthotlist"] || [key isEqualToString:@"browseproduct"] || [key isEqualToString:@"browseproductrecord"] || [key isEqualToString:@"storeproduct"] || [key isEqualToString:@"storeproductrecord"] || [key isEqualToString:@"version"]) {
        
        theIP = TaoTaoIP;
    }
    NSDictionary *pathDic = [[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Api" ofType:@"plist"]] objectForKey:@"Path"];
    NSString *path = [pathDic objectForKey:key];
    NSString *url = [NSString stringWithFormat:@"%@%@",theIP,path];
    return url;
}

#pragma mark - 判断有没有设置代理访问（防抓包）
+ (BOOL)hasSetProxy
{
    BOOL proxy = NO;
    
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSURL *url = [NSURL URLWithString:@"https://www.wanglibao.com"];
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef)(url),
                                                                       (__bridge CFDictionaryRef)(proxySettings)));
    NSLog(@"proxies:%@", proxies);
    NSDictionary *settings = proxies[0];
    NSLog(@"kCFProxyHostNameKey: %@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"kCFProxyPortNumberKey: %@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"kCFProxyTypeKey: %@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
        proxy = NO;
    }
    else {
        proxy = YES;
    }
    
    return proxy;
}

@end
