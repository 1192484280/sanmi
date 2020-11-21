//
//  NSString+Change.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/10.
//  Copyright © 2019 qingyun. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Change)


/**
 html转富文本
 */
+(NSAttributedString *)getAttStrWithHtml:(NSString *)html;

/**
 * 时间戳转字符串
 */
+ (NSString *)changeWithTime:(NSString *)timeStr;


/**
 字典转json

 */
+(NSString *)dicToJson:(NSDictionary *)dict;

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
- (NSString *)URLDecodedString;

@end

NS_ASSUME_NONNULL_END
