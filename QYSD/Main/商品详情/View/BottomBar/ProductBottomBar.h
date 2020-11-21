//
//  ProductBottomBar.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProductBottomBar : UIView

@property (nonatomic, strong) ProductDetailModel *model;
@property (weak, nonatomic) IBOutlet UIButton *collectorBtn;

- (void)setProductModel:(ProductDetailModel *)data;

@end

NS_ASSUME_NONNULL_END
