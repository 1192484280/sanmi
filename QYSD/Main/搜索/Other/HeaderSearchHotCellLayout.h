//
//  HeaderSearchHotCellLayout.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotModel;


@interface HeaderSearchHotCellLayout : NSObject

@property (nonatomic, strong) HotModel *data;


@property (nonatomic, readonly) CGSize cellSize;

//搜索标签
- (instancetype)initWithData:(HotModel *)model;

@end


