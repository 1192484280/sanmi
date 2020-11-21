//
//  UIImage+VKDImageAsset.h
//  VKDCommons
//
//  Created by YangJihang on 2018/11/12.
//

#import "UIImage+VKDImageAsset.h"
#import "NSBundle+VKDImageAsset.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation UIImage (VKDImageAsset)

+ (UIImage *)vkd_kitImageName:(NSString *)imageName withBundleName:(NSString *)bName {
    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle vkd_assetsImageBundleWithBundleName:bName] compatibleWithTraitCollection:nil];
    return image;
}

+ (UIImage *)vkd_kitimageWithContentsOfName:(NSString *)path withBundleName:(NSString *)bName {
    if (path && [path isKindOfClass:[NSString class]] && ![path isEqualToString:@""]) {
        NSString *imagePath = [[NSBundle vkd_fileImagePathWithBundleName:bName] stringByAppendingPathComponent:path];
        return [UIImage imageWithContentsOfFile:imagePath];
    }
    return nil;
}

+ (UIImage *)vkd_kitGifImageName:(NSString *)gifName withBundleName:(NSString *)bName {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle vkd_fileImageBundleWithBundleName:bName] pathForResource:[gifName stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage sd_imageWithGIFData:data];
        }
        
        NSString *path = [[NSBundle vkd_fileImageBundleWithBundleName:bName] pathForResource:gifName ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_imageWithGIFData:data];
        }
        
        return [UIImage vkd_kitImageName:gifName withBundleName:bName];
    }
    else {
        NSString *path = [[NSBundle vkd_fileImageBundleWithBundleName:bName] pathForResource:gifName ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_imageWithGIFData:data];
        }
        
        return [UIImage vkd_kitImageName:gifName withBundleName:bName];
    }
}

@end
