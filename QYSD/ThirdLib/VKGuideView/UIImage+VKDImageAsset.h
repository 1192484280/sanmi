//
//  UIImage+VKDImageAsset.h
//  VKDCommons
//
//  Created by YangJihang on 2018/11/12.
//

#import <UIKit/UIKit.h>

@interface UIImage (VKDImageAsset)

+ (UIImage *)vkd_kitImageName:(NSString *)imageName withBundleName:(NSString *)bName;
+ (UIImage *)vkd_kitimageWithContentsOfName:(NSString *)path withBundleName:(NSString *)bName;
+ (UIImage *)vkd_kitGifImageName:(NSString *)gifName withBundleName:(NSString *)bName;

@end
