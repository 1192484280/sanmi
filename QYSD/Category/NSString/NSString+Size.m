//
//  NSString+Size.m
//  createImg
//
//  Created by 紫枫 on 2018/4/3.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //  行数
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数，真实高度加上行间距
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    } else {
        //  行数超过指定行数的时候，限制行数
        if (rows > numberOfLines) {
            rows = numberOfLines;
                }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    //  返回真实的宽高
    return CGSizeMake(constrainedWidth, realHeight);
}

- (CGSize)textSizeWithFont:(UIFont*)font
             numberOfLines:(NSInteger)numberOfLines
          constrainedWidth:(CGFloat)constrainedWidth{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //  行数
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数，真实高度加上行间距
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) ;
        }
    } else {
        //  行数超过指定行数的时候，限制行数
        if (rows > numberOfLines) {
            rows = numberOfLines;
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) ;
    }
    //  返回真实的宽高
    return CGSizeMake(constrainedWidth, realHeight);
}

/// 计算字符串长度（一行时候）
- (CGSize)textSizeWithFont:(UIFont*)font
                limitWidth:(CGFloat)maxWidth {
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 36)options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)  attributes:@{ NSFontAttributeName : font} context:nil].size;
    size.width = size.width > maxWidth ? maxWidth : size.width;
	size.width = ceil(size.width);
	size.height = ceil(size.height);
    return size;
}

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
	CGSize textSize;
	if (CGSizeEqualToSize(size, CGSizeZero)) {
		NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
		textSize = [self sizeWithAttributes:attributes];
	} else {
		textSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
	}
	return textSize;
}

+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font color:(UIColor *)color{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
};

+ (NSMutableAttributedString *)getMuAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font color:(UIColor *)color{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
};

#pragma mark - 有效字符串
- (BOOL)isValid {

    if (self == nil || (NSNull *)self == [NSNull null] || self.length == 0 ) return NO;
    return YES;
}

#pragma mark - 返回富文本高度
+ (CGFloat)getAttHeightWithStr:(NSAttributedString *)str min_w:(CGFloat)w{
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(w, CGFLOAT_MAX) text:str];
    
    return layout.textBoundingSize.height;
}

#pragma mark - 返回富文本宽度
+ (CGFloat)getAttWidthWithStr:(NSAttributedString *)str min_h:(CGFloat)h{
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(CGFLOAT_MAX, h) text:str];
    
    return layout.textBoundingSize.width;
}
@end
