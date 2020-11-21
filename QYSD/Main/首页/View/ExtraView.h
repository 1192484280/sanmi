//
//  ExtraView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraView : UIView

@property (nonatomic, copy) void(^typeBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame modelArr:(NSArray *)modelArr;

@end

NS_ASSUME_NONNULL_END
