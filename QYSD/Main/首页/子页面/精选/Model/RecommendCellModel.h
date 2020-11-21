//
//  RecommendCellModel.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
"uid": "1",
"storeName":"爱马仕",
"storeLogo":"",
"title": "春秋出行必备",
"oldPrice": "1999.00",
"nowPrice": "988.88",
"people": "6245",
"img_width": "240",
"img_height": "240",
"img": "http:\/\/imgsrc.baidu.com\/forum\/eWH%3D240%2C176\/sign=183252ee8bd6277ffb784f351a0c2f1c\/5d6034a85edf8db15420ba310523dd54564e745d.jpg",
*/
@interface RecommendCellModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeLogo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *oldPrice;
@property (nonatomic, copy) NSString *nowPrice;
@property (nonatomic, copy) NSString *people;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *coupon;
@property (nonatomic, copy) NSString *reward;
@end

