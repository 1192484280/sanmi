//
//  VersionUpdateView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionUpdateView : UIView

@property (nonatomic, copy) void(^closeBlock)(void);
@property (nonatomic, copy) void(^searchBlock)();

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSAttributedString *)title;

@end

NS_ASSUME_NONNULL_END
