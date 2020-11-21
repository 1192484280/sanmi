//
//  HomeBannerModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//  BannerURL: banner图片地址, BannerTags: banner标签/关联文章标题, ActiveType:跳转方式，1-原生，2-H5, RedirectContentType:跳转内容，1-地址，2-商品详情 RedirectPath: 跳转地址, ItemID：商品Id, Title:商品标题, OrderID:排序号

#import <Foundation/Foundation.h>

@interface HomeBannerModel : NSObject

@property (nonatomic, copy) NSString *BannerURL;
@property (nonatomic, copy) NSString *BannerTags;
@property (nonatomic, assign) NSInteger ActiveType;

@property (nonatomic, assign) NSInteger RedirectContentType;
@property (nonatomic, copy) NSString *RedirectPath;
@property (nonatomic, copy) NSString *ItemID;

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *OrderID;

@end


