//
//  TypeCollectionReusableViewTwoSection.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/15.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TypeCollectionReusableViewTwoSection.h"
#import "ZJScrollPageView.h"

@interface TypeCollectionReusableViewTwoSection ()

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *seBgView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) UIView *line;

@end

@implementation TypeCollectionReusableViewTwoSection

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = CellLineColor;
    }
    return _line;
}

- (UIView *)seBgView{
    
    if (!_seBgView) {
        
        _seBgView = [[UIView alloc] init];
        _seBgView.backgroundColor = UIColor.whiteColor;
    }
    return _seBgView;
}

- (UIView *)titleView{
    
    if (!_titleView) {
        
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = UIColor.whiteColor;
        
        UILabel *la = [[UILabel alloc] init];
        [_titleView addSubview:la];
        la.text = @"百货商城";
        la.font = [UIFont boldSystemFontOfSize:17];
        la.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_titleView);
        }];
        
        UIImageView *leftIm = [[UIImageView alloc] init];
        leftIm.image = [UIImage imageNamed:@"img_superLeft"];
        [_titleView addSubview:leftIm];
        [leftIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(la.mas_left);
            make.top.bottom.mas_equalTo(0);
        }];
        
        UIImageView *rightIm = [[UIImageView alloc] init];
        rightIm.image = [UIImage imageNamed:@"img_superRight"];
        [_titleView addSubview:rightIm];
        [rightIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(la.mas_right);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _titleView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(40);
        }];
        
        [self setupSegmentView];
        
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}


- (void)setupSegmentView{
    
    NSArray *titles = @[
                        @"亚洲",
                        @"欧美"
                        ];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.adjustCoverOrLineWidth = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = [UIColor colorWithRGB:0xFA6400];
    style.normalTitleColor = [UIColor colorWithRGB:0x000000];
    style.selectedTitleColor = [UIColor colorWithRGB:0xFA6400];
    // 注意: 一定要避免循环引用!!
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40) segmentStyle:style delegate:nil titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        
    }];
    
    segment.backgroundColor = [UIColor whiteColor];
    
    self.segmentView = segment;
    [self addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
}

@end
