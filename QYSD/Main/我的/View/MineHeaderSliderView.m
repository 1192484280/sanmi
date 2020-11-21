//
//  MineHeaderSliderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderSliderView.h"
#import "SDCycleScrollView.h"

@interface MineHeaderSliderView ()<SDCycleScrollViewDelegate>

@end

@implementation MineHeaderSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = UIColor.whiteColor;
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    NSArray *imgArr = @[@"http://lc-4cjyhep8.cn-n1.lcfile.com/dddb5ec034014bbab7a8/min_slider_02.png"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
    cycleScrollView.pageDotColor = UIColor.whiteColor;
    cycleScrollView.currentPageDotColor =ThemColor;
    cycleScrollView.imageURLStringsGroup = imgArr;
    cycleScrollView.autoScrollTimeInterval = 5;
    [self addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    UIImageView *bgImg;
//    [bgImg sd_cancelCurrentAnimationImagesLoad];
    [bgImg sd_setImageWithURL:nil];

}

@end
