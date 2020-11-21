//
//  OrderCenterHeaderView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderCenterHeaderView : UIView

@property (nonatomic, copy) void(^selectedTypeBlock) (void);

@end

NS_ASSUME_NONNULL_END
