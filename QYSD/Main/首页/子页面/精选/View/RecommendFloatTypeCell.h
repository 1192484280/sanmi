//
//  RecommendFloatTypeCell.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendFloatTypeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *floatNameLa;
@property (nonatomic, strong) UILabel *desLa;
@property (nonatomic, strong) UIView *line;

- (void)setSelectedWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
