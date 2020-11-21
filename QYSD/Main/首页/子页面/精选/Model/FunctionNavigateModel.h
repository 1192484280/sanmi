//
//  FunctionNavigateModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//  NavigateID: 导航栏目ID, NavigateName: 导航栏目名称, PicURL: 导航图片地址, ActiveType:跳转类型:1-原生，2-H5, OrderID:排序号

#import <Foundation/Foundation.h>

@interface FunctionNavigateModel : NSObject

@property (nonatomic, copy) NSString *NavigateName;
@property (nonatomic, assign) NSInteger NavigateID;
@property (nonatomic, copy) NSString *PicURL;
@property (nonatomic, copy) NSString *ActiveType;
@property (nonatomic, copy) NSString *OrderID;


@end


