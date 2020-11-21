//
//  UIFont+MyFont.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/14.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "UIFont+MyFont.h"

@implementation UIFont (MyFont)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

//+(UIFont *)systemFontOfSize:(CGFloat)fontSize{
//    
//     //根据屏幕尺寸判断的设备，然后字体设置为0.8倍
//    if (KScreenHeight <= 568) {
//        
//        fontSize = fontSize * 0.8;
//    }
//    
//    UIFont *newFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    UIFontDescriptor *ctfFont = newFont.fontDescriptor;
//    NSString *fontString = [ctfFont objectForKey:@"NSFontNameAttribute"];
//    //使用fontWithName 设置字体
//    return [UIFont fontWithName:@"Helvetica" size:fontSize];
//    
//}
//
//+(UIFont *)boldSystemFontOfSize:(CGFloat)fontSize{
//    
//    //根据屏幕尺寸判断的设备，然后字体设置为0.8倍
//    if (KScreenHeight <= 568) {
//        
//        fontSize = fontSize * 0.8;
//    }
//    
//    return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
//    
//}

//+ (void)load {
//    
//    Method selfMethod = class_getClassMethod([self class], @selector(runtimeFitFont:));
//    Method systenMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
//    method_exchangeImplementations(selfMethod, systenMethod);
//    
//    Method selfMethod2 = class_getClassMethod([self class], @selector(runtimeFitBoldFont:));
//    Method systenMethod2 = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
//    method_exchangeImplementations(selfMethod2, systenMethod2);
//}
//
//+ (UIFont *)runtimeFitFont:(CGFloat)fontSize {
//    UIFont *fitFont = nil;
//    //这里并不会造成递归调用,方法已经被交换
//    fitFont = [UIFont runtimeFitFont:fontSize * (KScreenWidth / 375 )];
//    return fitFont;
//}
//
//+ (UIFont *)runtimeFitBoldFont:(CGFloat)fontSize {
//    UIFont *fitFont = nil;
//    //这里并不会造成递归调用,方法已经被交换
//    fitFont = [UIFont runtimeFitBoldFont:fontSize * (KScreenWidth / 375 )];
//    return fitFont;
//}

@end
