//
//  NSBundle+VKDImageAsset.m
//  VKDCommons
//
//  Created by YangJihang on 2018/11/12.
//

#import "NSBundle+VKDImageAsset.h"

@implementation NSBundle (VKDImageAsset)

+ (NSString *)vkd_assetsImagePathWithBundleName:(NSString *)bName {
    return [[NSBundle mainBundle] pathForResource:bName ofType:@"bundle"];
}

+ (NSString *)vkd_fileImagePathWithBundleName:(NSString *)bName {
    return [[NSBundle mainBundle] pathForResource:bName ofType:@"bundle"];
}

+ (instancetype)vkd_assetsImageBundleWithBundleName:(NSString *)bName {
    return [NSBundle bundleWithPath:[self vkd_assetsImagePathWithBundleName:bName]];
}

+ (instancetype)vkd_fileImageBundleWithBundleName:(NSString *)bName {
    return [NSBundle bundleWithPath:[self vkd_fileImagePathWithBundleName:bName]];
}

@end
