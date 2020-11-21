//
//  IncomeRankingTopThreeView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "IncomeRankingTopThreeView.h"

@interface IncomeRankingTopThreeView ()

@property (nonatomic, strong) UIView *xibView;

@end

@implementation IncomeRankingTopThreeView

- (UIView *)xibView{
    if (!_xibView) {
        
        ClassName
        _xibView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return _xibView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
    }
    return self;
}

@end
