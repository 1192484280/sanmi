//
//  TestListBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

@class HomejxwlModel;

@interface TestListBaseView : UIView <JXPagerViewListViewDelegate>

@property (nonatomic, weak) UINavigationController *naviController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray  *dataSource;

@property (nonatomic, strong) HomejxwlModel *jxwlModel;

- (void)beginFirstRefresh;

@end
