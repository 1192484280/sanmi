//
//  SearchResultSelectedView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultSelectedView : UIView

@property (nonatomic, copy) void(^sureBlock) (NSString *str1,NSString *str2);

@end

NS_ASSUME_NONNULL_END
