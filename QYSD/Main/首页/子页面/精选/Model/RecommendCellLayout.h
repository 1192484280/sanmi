//
//  RecommendCellLayout.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendCellModel;

@interface RecommendCellLayout : NSObject

@property (nonatomic, strong) RecommendCellModel *data;
@property (nonatomic, readonly) CGRect imgRect;
//@property (nonatomic, readonly) CGRect storeLogoRect;
@property (nonatomic, readonly) CGRect titleRect;
@property (nonatomic, readonly) CGRect oldPriceRect;
@property (nonatomic, readonly) CGRect nowPriceRect;
@property (nonatomic, readonly) CGRect peopleRect;
@property (nonatomic, readonly) CGRect couponRect;
@property (nonatomic, readonly) CGRect rewardRect;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat width;

- (instancetype)initWithData:(RecommendCellModel *)model;
- (instancetype)initWithTableData:(RecommendCellModel *)model;
@end

