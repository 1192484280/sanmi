//
//  ProductInfoLayout.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProductDetailModel;

@interface ProductInfoLayout : NSObject

@property (nonatomic, strong) ProductDetailModel *data;

@property (nonatomic, readonly) CGRect bgOneRect;
@property (nonatomic, readonly) CGRect fuhaoRect;
@property (nonatomic, readonly) CGRect priceRect;
@property (nonatomic, readonly) CGRect quanhouRect;
@property (nonatomic, readonly) CGRect saleNumRect;
@property (nonatomic, readonly) CGRect searchBtnRect;
@property (nonatomic, readonly) CGRect desRect;

@property (nonatomic, readonly) CGRect quanBgViewRect;

@property (nonatomic, readonly) CGRect tuijianBgRect;
@property (nonatomic, readonly) CGRect tuijianDesRect;

@property (nonatomic, readonly) CGRect storeBgRect;

@property (nonatomic, readonly) CGRect commentBgRect;
@property (nonatomic, readonly) CGRect comontRect;
@property (nonatomic, readonly) CGRect comontIconRect;
@property (nonatomic, readonly) CGRect comontNameRect;
@property (nonatomic, readonly) CGRect comontDesRect;

@property (nonatomic, readonly) CGFloat height;

- (instancetype)initWithData:(ProductDetailModel *)data;

@end


