//
//  NSBundle+VKDImageAsset.h
//  VKDCommons
//
//  Created by YangJihang on 2018/11/12.
//

#import <Foundation/Foundation.h>

@interface NSBundle (VKDImageAsset)

+ (NSString *)vkd_assetsImagePathWithBundleName:(NSString *)bName;
+ (NSString *)vkd_fileImagePathWithBundleName:(NSString *)bName;

+ (instancetype)vkd_assetsImageBundleWithBundleName:(NSString *)bName;
+ (instancetype)vkd_fileImageBundleWithBundleName:(NSString *)bName;

@end
