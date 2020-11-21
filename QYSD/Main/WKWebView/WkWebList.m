//
//  WkWebList.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "WkWebList.h"

@implementation WkWebList

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.url = @"http://www.qytimes.cn";
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static WkWebList *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[WkWebList alloc] init];
    });
    return client;
}

@end
