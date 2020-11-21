//
//  SearchAllNetViewController.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface SearchAllNetViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, copy) NSString *keyWord;

@end


