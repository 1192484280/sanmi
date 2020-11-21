//
//  OrderCenterHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "OrderCenterHeaderView.h"
#import "ZJScrollSegmentView.h"

@interface OrderCenterHeaderView ()

@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) ZJScrollSegmentView *segmentView2;
@property (nonatomic, strong) UIView *xibView;
@end

@implementation OrderCenterHeaderView

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
        
        [self setupSegmentView];
        [self setupSegmentView2];
        [self addSubview:self.xibView];
        self.xibView.frame = CGRectMake(0, 80, KScreenWidth, 100);
    }
    return self;
}

- (void)setupSegmentView{
    
    NSArray *arr = @[@"我的订单",@"二当家订单",@"三当家订单"];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
    style.segmentViewBounces = NO;
    style.scaleTitle = YES;
    // 注意: 一定要避免循环引用!!
    MJWeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:nil titles:arr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        if (weakSelf.selectedTypeBlock) {
            
            weakSelf.selectedTypeBlock();
        }
        
    }];
    
    segment.backgroundColor = UIColor.whiteColor;
    self.segmentView = segment;
    [self addSubview:segment];
    
}

- (void)setupSegmentView2{
    
    NSArray *arr = @[@"全部",@"已付款",@"已失效",@"已结算"];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
        style.titleMargin = (KScreenWidth - 60 * 4) / 5;
    //    style.showLine = YES;
    style.scaleTitle = NO;
    //    style.showCover = YES;
    style.selectedTitleColor = UIColor.orangeColor;
    style.scrollLineColor = UIColor.orangeColor;
    style.titleBgColor = UIColor.whiteColor;
    style.titleHeight = 30;
    style.titleCornerRadius = 15;
    
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 注意: 一定要避免循环引用!!
    MJWeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 40, KScreenWidth, 40.0) segmentStyle:style delegate:nil titles:arr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        if (weakSelf.selectedTypeBlock) {
            
            weakSelf.selectedTypeBlock();
        }
    }];
    
    segment.backgroundColor = BaseBackGroundColor;
    self.segmentView2 = segment;
    [self addSubview:segment];
    
}


@end
