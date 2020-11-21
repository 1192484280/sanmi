//
//  UILabel+VKDFontStyle.m
//  vipkid-parent
//
//  Created by 王雪松 on 2017/12/8.
//  Copyright © 2017年 fuyujia. All rights reserved.
//

#import "UILabel+VKDFontStyle.h"

@implementation UILabel (VKDFontStyle)

+ (UIFont *)vkd_fontWithStyle:(NSString *)style andSize:(CGFloat)size{
    UIFont *customFont  = [UIFont fontWithName:style size:size];
    UIFont *systemFont  = [UIFont systemFontOfSize:size];
    return customFont?customFont:systemFont;
}

@end
