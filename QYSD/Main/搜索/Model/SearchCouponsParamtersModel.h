//
//  SearchCouponsParamtersModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCouponsParamtersModel : NSObject

@property (nonatomic, copy) NSString *keyword;// 检索关键字（示例：牛仔裤）
@property (nonatomic, assign) NSInteger identity;// 用户标识（1：合伙人 2：团长 3：超级团长）
@property (nonatomic, copy) NSString *sort;// （1：综合排序 2：月销量 3：旗舰）默认：1
@property (nonatomic, copy) NSString *hasCoupon;// 是否有优惠券（1：有 0：不限制） 默认：0
@property (nonatomic, copy) NSString *startprice;// 折扣价范围下限（示例：20）
@property (nonatomic, copy) NSString *endprice;// 折扣价范围上限（示例：100）
@property (nonatomic, assign) NSInteger pageno;// 第几页，示例：１
@property (nonatomic, assign) NSInteger pagesize;// 页大小，示例：20，1~100

@end


