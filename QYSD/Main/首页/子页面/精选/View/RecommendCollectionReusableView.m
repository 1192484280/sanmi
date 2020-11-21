//
//  RecommendCollectionReusableView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendCollectionReusableView.h"
#import "RecommendCourseView.h"
#import "RecommendFestivalView.h"
#import "RecommendFloatTypeView.h"
#import "RecommentForYouView.h"

@interface RecommendCollectionReusableView ()

@property (nonatomic, strong) RecommendCourseView *courseView;
@property (nonatomic, strong) RecommendFestivalView *festivalView;
@property (nonatomic, strong) RecommendFloatTypeView *floatTypeView;
@property (nonatomic, strong) RecommentForYouView *recommentForYouView;
@end

@implementation RecommendCollectionReusableView

#pragma mark - 为你推荐
- (RecommentForYouView *)recommentForYouView{
    
    if (!_recommentForYouView) {
        
        _recommentForYouView = [[RecommentForYouView alloc] init];
    }
    return _recommentForYouView;
}

#pragma mark - 精选物料
- (RecommendFourTypeView *)fourTypeView{
    
    if (!_fourTypeView) {
        
        _fourTypeView = [[RecommendFourTypeView alloc] init];
    }
    return _fourTypeView;
}

#pragma mark - 平台类型
- (RecommendFloatTypeView *)floatTypeView{

    if (!_floatTypeView) {

        _floatTypeView = [[RecommendFloatTypeView alloc] init];
    }
    return _floatTypeView;
}

#pragma mark - 节日活动
- (RecommendFestivalView *)festivalView{
    
    if (!_festivalView) {
        
        _festivalView = [[RecommendFestivalView alloc] init];
    }
    
    return _festivalView;
}

#pragma mark - 新手教程
- (RecommendCourseView *)courseView{
    
    if (!_courseView) {
        
        _courseView = [[RecommendCourseView alloc] init];
    }
    
    return _courseView;
}

#pragma mark - 菜单
- (RecommendMenueView *)menueView{
    
    if (!_menueView) {
        
        _menueView = [[RecommendMenueView alloc] init];
        
    }
    return _menueView;
}

#pragma mark - 广告轮播图
- (RecommendSliderView *)sliderView{
    
    if (!_sliderView) {
        
        _sliderView = [[RecommendSliderView alloc] init];
        
    }
    return _sliderView;
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
    
//    //轮播图
//    [self addSubview:self.sliderView];
//    
//    //菜单
////    [self addSubview:self.menueView];
//    
//    //新手攻略
//    [self addSubview:self.courseView];
//    
//    //节日活动
////    [self addSubview:self.festivalView];
//    
//    //精选物料
//    [self addSubview:self.fourTypeView];
//    
//    //平台类型
////    [self addSubview:self.floatTypeView];
//    
//    //为你推荐
//    [self addSubview:self.recommentForYouView];
//    
//    CGFloat banner_w = KScreenWidth - 20;
//    CGFloat banner_scale = 0.35;
//    CGFloat banner_h = banner_w * banner_scale;
//    
//    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.top.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(banner_h);
//    }];
    
//    [self.menueView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.equalTo(self.sliderView.mas_bottom).offset(10);
//        make.height.mas_equalTo(162);
//
//    }];
    
//    CGFloat course_w = (KScreenWidth - 20 - 8*2 - 10)/2;
//    CGFloat course_scale = 0.38;
//    CGFloat course_h = course_w * course_scale + 8 * 2;
//
//    [self.courseView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.equalTo(self.sliderView.mas_bottom).offset(10);
//        make.height.mas_equalTo(course_h);
//
//    }];
    
//    CGFloat festivalTopIm_w = KScreenWidth- 20;
//    CGFloat festivalTopIm_scale = 0.28;
//    CGFloat festivalTopIm_h = festivalTopIm_w * festivalTopIm_scale;
//
//    CGFloat festivalCell1_w = (KScreenWidth- 20 - 20 - 5)/2;
//    CGFloat festivalCell1_scale = 0.4;
//    CGFloat festivalCell1_h = festivalCell1_w * festivalCell1_scale;
//
//    CGFloat festivalCell2_w = (KScreenWidth- 20 - 20 - 5 * 3)/4;
//    CGFloat festivalCell2_scale = 1.2;
//    CGFloat festivalCell2_h = festivalCell2_w * festivalCell2_scale;
//
//    CGFloat festival_h = festivalTopIm_h + festivalCell1_h * 2 + 5 + 10 + festivalCell2_h + 10 + 5;
//    [self.festivalView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.equalTo(self.courseView.mas_bottom).offset(10);
//        make.height.mas_equalTo(festival_h);
//
//    }];
    
//    CGFloat fourType_w = KScreenWidth- 20;
//    CGFloat fourType_scale = 0.6;
//    CGFloat fourType_h = fourType_w * fourType_scale;
//    [self.fourTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.equalTo(self.sliderView.mas_bottom).offset(10);
//        make.height.mas_equalTo(fourType_h);
//
//    }];
    
//    [self.floatTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.equalTo(self.fourTypeView.mas_bottom).offset(10);
//        make.height.mas_equalTo(60);
//
//    }];
    
    [self.recommentForYouView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.fourTypeView.mas_bottom);
    }];
}
@end
