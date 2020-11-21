//
//  RecommendSliderView.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendSliderView : UIView

@property (nonatomic, copy) NSArray *dataArr;

- (void)setData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
