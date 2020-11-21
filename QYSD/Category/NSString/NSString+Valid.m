//
//  NSString+Valid.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (BOOL)match:(NSString *)Pattern
{
    //1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:Pattern options:0 error:nil];
    
    //2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isEmail
{
    NSString *Pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self match:Pattern];
}


- (NSString *)md5HexDigest {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font{
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
    
}


/**
 *计算富文本字体高度
 *
 * @param lineSpeace 行高
 * @param font 字体
 * @param width 字体所占宽度
 *
 * @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    // paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */ paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size; return size.height;
    
}


#pragma mark - 判断手机号
- (BOOL)isVaildMobileNo{
    
    if(self.length != 11){
        
        return NO;
    }
    
    NSString *phoneRegex = @"^((1[3456789]))\\d{9}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return[phoneTest evaluateWithObject:self];
    
}

#pragma mark - 检查银行卡号
- (BOOL)checkCardNo:(NSString*)cardNo{
    
    if (cardNo.length < 15) {
        
        return NO;
    }
    
    int oddsum = 0;    //奇数求和
    
    int evensum = 0;    //偶数求和
    
    int allsum = 0;
    
    int cardNoLength = (int)[cardNo length];
    
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        
        int tmpVal = [tmpString intValue];
        
        if (cardNoLength % 2 ==1 ) {
            
            if((i % 2) == 0){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }else{
            
            if((i % 2) == 1){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }
        
    }
    
    allsum = oddsum + evensum;
    
    allsum += lastNum;
    
    if((allsum % 10) == 0)
        
        return YES;
    
    else
        
        return NO;
    
}

#pragma mark - 判断字符串是否为数字
+ (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

@end
