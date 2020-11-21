//
//  SliderCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UICollectionViewCell

@property (nonatomic, copy) NSArray *dataArr;

- (void)setData:(NSArray *)data;

@end

