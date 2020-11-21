//
//  NSString+Valid.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Valid)

/**
 *  判断是否为邮箱格式
 */
- (BOOL)isEmail;

/**
 * md5加密
 */
- (NSString *) md5HexDigest;

/**
 * 富文本
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font;

/**
 * 富文本行高
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

/**
 * 判断手机号
 */
- (BOOL)isVaildMobileNo;


/**
 * 判断银行卡号
 */
- (BOOL)checkCardNo:(NSString*)cardNo;

/**
 * 判断字符串是否为数字
 */
+ (BOOL)isNumber:(NSString *)strValue;


@end

