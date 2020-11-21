//
//  HeaderSearchNavView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderSearchNavView : UIView

@property (nonatomic, copy) void(^searchBlock)(NSString *keyWord);

@end

NS_ASSUME_NONNULL_END
