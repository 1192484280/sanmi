//
//  HeaderChildCollectionReusableView.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderChildCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) void(^sortBlock)(NSString *sort);

@property (nonatomic, copy) NSString *sort;

@end

NS_ASSUME_NONNULL_END
