//
//  MerchandiseReChildCollectionCell.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchandiseReChildCollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) UIImageView *playIm;
@property (nonatomic, strong) UIImageView *priceIm;

@end

NS_ASSUME_NONNULL_END
