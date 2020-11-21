//
//  MerchandiseModel.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchandiseModel : NSObject

@property (nonatomic, copy) NSString *PublisherName;//发布人名称
@property (nonatomic, copy) NSString *PublisherPicUrl;//发布人头像地址
@property (nonatomic, copy) NSString *PublishTime;//发布时间
@property (nonatomic, copy) NSString *BelongTypeID;// 1-图文类，2-视频类
@property (nonatomic, copy) NSString *ContentHtml;//文章内容
@property (nonatomic, copy) NSString *ImgUrls;//图片地址，逗号分割

@property (nonatomic, copy) NSArray *imgArr;//图片数组，前台自己分割

@property (nonatomic, assign) NSInteger ForwardsNumber;//转发次数
@property (nonatomic, copy) NSString *VideoUrl;//视频url

//商品推荐
@property (nonatomic, copy) NSString *ProductGuid;//商品主键
@property (nonatomic, copy) NSString *ProductTKL;//商品淘口令
@property (nonatomic, copy) NSString *ProductPrice;//价格
@property (nonatomic, copy) NSString *ItemId;//商品id
@property (nonatomic, copy) NSString *Title;//商品标题
@end


