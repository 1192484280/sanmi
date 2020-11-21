//
//  RecommendCollectionReusableView.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendSliderView.h"
#import "RecommendMenueView.h"
#import "RecommendFourTypeView.h"

@interface RecommendCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) RecommendSliderView *sliderView;

@property (nonatomic, strong) RecommendMenueView *menueView;

@property (nonatomic, strong) RecommendFourTypeView *fourTypeView;


@end

