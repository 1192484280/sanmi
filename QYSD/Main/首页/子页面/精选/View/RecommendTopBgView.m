//
//  RecommendTopBgView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//  顶部小圆弧效果

#import "RecommendTopBgView.h"
#import "ColorArrManager.h"

@interface RecommendTopBgView ()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, copy) NSString *color1;

@end

@implementation RecommendTopBgView

- (UIView *)topView{
    
    if (!_topView) {
        
        //F88222
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
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScroll:) name:@"ADSCROLL" object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotic:) name:@"SDPROGRESS" object:nil];
    }
    return self;
}

//- (void)dealloc{
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

//- (void)onScroll:(NSNotification *)noti{
//    
//    NSDictionary *dic = noti.userInfo;
//    NSString *colorStr = [dic objectForKey:@"color"];
//    
//    self.topView.backgroundColor = [UIColor colorWithHexString:colorStr];
//    
//}

- (void)setUI{
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
    }];
}

//- (void)onNotic:(NSNotification*)noti{
//    
//    NSDictionary *dic = noti.userInfo;
//    NSString *pro = [dic objectForKey:@"progress"];
//    NSString *currentColor = [dic objectForKey:@"currentColor"];
//    NSString *nextColor = [dic objectForKey:@"nextColor"];
//    CGFloat progress = [pro floatValue];
//    DLog(@"滑动进度:%@，当前颜色:%@，即将呈现颜色：%@",pro,currentColor,nextColor);
//    
//    NSArray *normalColorRGBA = [ColorArrManager getColorRGBA:[UIColor colorWithHexString:currentColor]];
//    NSArray *selectedColorRGBA = [ColorArrManager getColorRGBA:[UIColor colorWithHexString:nextColor]];
//    
//    NSArray *deltaRGBA;
//    if (normalColorRGBA && selectedColorRGBA) {
//        CGFloat deltaR = [normalColorRGBA[0] floatValue] - [selectedColorRGBA[0] floatValue];
//        CGFloat deltaG = [normalColorRGBA[1] floatValue] - [selectedColorRGBA[1] floatValue];
//        CGFloat deltaB = [normalColorRGBA[2] floatValue] - [selectedColorRGBA[2] floatValue];
//        CGFloat deltaA = [normalColorRGBA[3] floatValue] - [selectedColorRGBA[3] floatValue];
//        deltaRGBA = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
//    }
//    
//    self.topView.backgroundColor = [UIColor
//                                    colorWithRed:[normalColorRGBA[0] floatValue] - [deltaRGBA[0] floatValue] * progress
//                                    green:[normalColorRGBA[1] floatValue] - [deltaRGBA[1] floatValue] * progress
//                                    blue:[normalColorRGBA[2] floatValue] - [deltaRGBA[2] floatValue] * progress
//                                    alpha:[normalColorRGBA[3] floatValue] - [deltaRGBA[3] floatValue] * progress];
//    
//}


@end
