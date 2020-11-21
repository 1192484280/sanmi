//
//  ProductTopCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductInfoLayout;
@class ProductDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProductTopCell : UITableViewCell

@property (nonatomic, strong) ProductDetailModel *model;

- (void)setLayout:(ProductInfoLayout *)layout;

@end

NS_ASSUME_NONNULL_END
