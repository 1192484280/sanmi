//
//  WkWebList.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WkWebList : NSObject

@property (nonatomic, copy) NSString *url;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
