//
//  WKWebViewController.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) BOOL hadRelod;//是否有刷新按钮

@property (nonatomic, assign) BOOL present;//是否是present进来的

@end

NS_ASSUME_NONNULL_END
