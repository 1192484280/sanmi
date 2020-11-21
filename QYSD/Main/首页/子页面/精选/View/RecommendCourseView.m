//
//  RecommendCourseView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/7.
//  Copyright © 2019 qingyun. All rights reserved.
//  新手教程

#import "RecommendCourseView.h"
#import "WKWebViewController.h"
#import "WkWebList.h"

@implementation RecommendCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = UIColor.whiteColor;
        
        self.layer.cornerRadius = 10;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    NSMutableArray *tolAry = [NSMutableArray new];
    
    UIImageView *im1 = [[UIImageView alloc] init];
    im1.image = [UIImage imageNamed:@"img_fuli"];
    [self addSubview:im1];
    [tolAry addObject:im1];
    im1.userInteractionEnabled = YES;
    self.im1 = im1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(onTapIm)];
    [im1 addGestureRecognizer:tap];
    
    UIImageView *im2 = [[UIImageView alloc] init];
    im2.image = [UIImage imageNamed:@"img_jiaocheng"];
    [self addSubview:im2];
    im2.userInteractionEnabled = YES;
    [tolAry addObject:im2];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [tap2 addTarget:self action:@selector(onTapIm)];
    [im2 addGestureRecognizer:tap2];
    
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:8 tailSpacing:8];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.bottom.equalTo(@-8);
    }];
    
}

- (void)onTapIm{
    
    [WkWebList sharedInstance].url = @"http://shanmi.qytimes.cn/H5/Public/";
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    webVC.hadRelod = YES;
    [webVC setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}
@end
