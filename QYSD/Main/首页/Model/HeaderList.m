//
//  HeaderList.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderList.h"

@implementation HeaderList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.recommendTop = YES;
    }
    return self;
}
+ (instancetype)sharedInstance{
    
    static HeaderList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[HeaderList alloc] init];
    });
    return sharedClient;
}

@end
