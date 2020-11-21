//
//  PromotionDetailPhotoList.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PromotionDetailPhotoList : NSObject

@property (nonatomic, strong) NSMutableArray *selectedPhotoArr;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
