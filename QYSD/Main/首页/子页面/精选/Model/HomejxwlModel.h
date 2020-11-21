//
//  HomejxwlModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//NavigateID: 导航栏目ID, NavigateName: 导航栏目名称, PicURL: 首页导航图片地址, PicURL1: 详情列表顶部导航图片地址, ParentNavigateID: 父级栏目id，一级为“-1”，获取子集传其父级id

#import <Foundation/Foundation.h>

@interface HomejxwlModel : NSObject

@property (nonatomic, copy) NSString *NavigateName;
@property (nonatomic, assign) NSInteger NavigateID;
@property (nonatomic, assign) NSInteger ParentNavigateID;
@property (nonatomic, assign) NSInteger OrderID;
@property (nonatomic, copy) NSString *PicURL;
@property (nonatomic, copy) NSString *PicURL1;

@property (nonatomic, copy) NSString *colorStr;//自己添加的

@end

