//
//  PopCopyTKLView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/10/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopCopyTKLView : UIView

@property (nonatomic, copy) void(^closeBlock)(void);
@property (nonatomic, copy) void(^searchBlock)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
