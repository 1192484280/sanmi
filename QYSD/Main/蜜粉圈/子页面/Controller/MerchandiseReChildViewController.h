//
//  MerchandiseReChildViewController.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface MerchandiseReChildViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) NSInteger type; //4-营销素材，5-新手必发 
@property (nonatomic, assign) NSInteger navigateid;//商品推荐，导航栏目id
@end

