//
//  GoodsCellLayout.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsModel;

@interface GoodsCellLayout : NSObject

@property (nonatomic, strong) GoodsModel *data;
@property (nonatomic, readonly) CGRect imgRect;
@property (nonatomic, readonly) CGRect storeNameRect;
@property (nonatomic, readonly) CGRect titleRect;
@property (nonatomic, readonly) CGRect topTitleRect;
@property (nonatomic, readonly) CGRect oldPriceRect;
@property (nonatomic, readonly) CGRect nowPriceRect;
@property (nonatomic, readonly) CGRect peopleRect;
@property (nonatomic, readonly) CGRect couponRect;
//@property (nonatomic, readonly) CGRect rewardRect;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat width;

//搜索商品
- (instancetype)initWithTabData:(GoodsModel *)data;
//搜索商品
- (instancetype)initWithCollectionData:(GoodsModel *)data;

//实时榜单
- (instancetype)initWithTopTabData:(GoodsModel *)data;

@end

