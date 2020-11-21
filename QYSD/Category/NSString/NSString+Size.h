//
//  NSString+Size.h
//  createImg
//
//  Created by 紫枫 on 2018/4/3.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)
/**
 根据字体、行数、行间距和指定的宽度constrainedWidth计算文本占据的size
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param lineSpacing 行间距
 @param constrainedWidth 文本指定的宽度
  @return 返回文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth;

/**
 根据字体、行数、行间距和指定的宽度constrainedWidth计算文本占据的size
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param constrainedWidth 文本指定的宽度
 @return 返回文本占据的size
 */
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
          constrainedWidth:(CGFloat)constrainedWidth;

/// 计算字符串长度（一行时候）
- (CGSize)textSizeWithFont:(UIFont*)font
                limitWidth:(CGFloat)maxWidth;

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

//富文本
+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font color:(UIColor *)color;

//可变富文本
+ (NSMutableAttributedString *)getMuAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font color:(UIColor *)color;

//有效字符串
- (BOOL)isValid;

//返回富文本高度
+(CGFloat)getAttHeightWithStr:(NSAttributedString *)str min_w:(CGFloat)w;
// 返回富文本宽度
+ (CGFloat)getAttWidthWithStr:(NSAttributedString *)str min_h:(CGFloat)h;

@end
