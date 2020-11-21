//
//  LoginMainViewController.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginMainViewController : BaseViewController

@property (nonatomic, copy) void(^loginSuccessBlock)(void);

@end

