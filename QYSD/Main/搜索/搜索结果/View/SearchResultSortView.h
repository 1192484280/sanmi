//
//  SearchResultCollectionReusableView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultSortView : UIView

@property (nonatomic, copy) void(^SortBlock) (NSString *str);

@end

NS_ASSUME_NONNULL_END
