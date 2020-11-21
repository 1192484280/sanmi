//
//  NSString+Change.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/10.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "NSString+Change.h"

@implementation NSString (Change)

+(NSAttributedString *)getAttStrWithHtml:(NSString *)html{
    
    NSData *data = [html dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    
//    NSDictionary *attriDict = @{
//                                NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithData:data options:options  documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:14] range:NSMakeRange(0, attStr.length)];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 0;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    
//    [attStr addAttribute:NSForegroundColorAttributeName value:BlackColor range:NSMakeRange(0, attriStr.length)];
    return attStr;
}

#pragma mark - 时间戳转字符串
+ (NSString *)changeWithTime:(NSString *)timeStr{
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval  = [timeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate: date];
    
    return dateString;
}


#pragma mark - 字典转json
+(NSString *)dicToJson:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
- (NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
