//
//  HeaderList.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderList : NSObject

@property (nonatomic, assign) BOOL recommendPage;
@property (nonatomic, assign) BOOL recommendTop;
@property (nonatomic, copy) NSString *currentColorr;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
