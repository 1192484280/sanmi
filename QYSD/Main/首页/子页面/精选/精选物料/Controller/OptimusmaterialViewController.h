//
//  OptimusmaterialViewController.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/17.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"
#import "PagingViewTableHeaderView.h"
#import "TestListBaseView.h"
#import "JXCategoryTitleView.h"

@class HomejxwlModel;

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 40;

@interface OptimusmaterialViewController : UIViewController<JXPagerViewDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
- (JXPagerView *)preferredPagingView;

@property (nonatomic, strong) HomejxwlModel *jxwlModel;
@end

