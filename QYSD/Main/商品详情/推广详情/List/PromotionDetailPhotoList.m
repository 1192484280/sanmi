//
//  PromotionDetailPhotoList.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailPhotoList.h"

@implementation PromotionDetailPhotoList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedPhotoArr = [NSMutableArray array];
    }
    return self;
}

+(instancetype)sharedInstance{
    
    static PromotionDetailPhotoList *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[PromotionDetailPhotoList alloc] init];
    });
    return client;
}

@end
