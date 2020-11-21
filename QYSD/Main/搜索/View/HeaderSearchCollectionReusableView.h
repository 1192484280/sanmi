//
//  HeaderSearchCollectionReusableView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderSearchCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIButton *cleanBtn;

@property (nonatomic, copy) void (^cleanBlock)(void);

@end

NS_ASSUME_NONNULL_END
