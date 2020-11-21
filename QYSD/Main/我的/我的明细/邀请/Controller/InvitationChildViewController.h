//
//  InvitationChildViewController.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
@class InvitationChildLayout;
NS_ASSUME_NONNULL_BEGIN

@interface InvitationChildViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, strong) InvitationChildLayout *layout;

@end

NS_ASSUME_NONNULL_END
