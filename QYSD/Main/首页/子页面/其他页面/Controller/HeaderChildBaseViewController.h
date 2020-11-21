//
//  HeaderChildBaseViewController.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"

#import "ZJScrollPageViewDelegate.h"

@interface HeaderChildBaseViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, copy) NSString *navigateid;

@property (nonatomic, strong) UICollectionView *collectionView;

@end


