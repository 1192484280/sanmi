//
//  TypeTobBgView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TypeAnimaView.h"

@interface TypeAnimaView ()

@property (nonatomic, strong) UIView *topView;

@end

@implementation TypeAnimaView

- (UIView *)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc] init];
        [_topView az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        UIImageView *topIm = [[UIImageView alloc] init];
        topIm.image = [UIImage imageNamed:@"img_recommondTopIm"];
        [_topView addSubview:topIm];
        [topIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _topView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
    }];
}

@end
