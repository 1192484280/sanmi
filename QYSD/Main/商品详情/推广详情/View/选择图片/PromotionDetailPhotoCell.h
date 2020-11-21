//
//  PromotionDetailPhotoCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PromotionDetailPhotoModel;

@interface PromotionDetailPhotoCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) PromotionDetailPhotoModel *model;

- (void)setData:(PromotionDetailPhotoModel *)data;

@end


