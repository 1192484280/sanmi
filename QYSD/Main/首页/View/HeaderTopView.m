//
//  HeaderTopView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderTopView.h"
#import "HeaderSearchViewController.h"
#import "SMNewsViewController.h"
#import "PopoverView.h"
#import "HeaderList.h"

@interface HeaderTopView ()

@property (nonatomic, weak) UIButton *searchBtn;
@property (nonatomic, weak) UIImageView *btnIm;
@property (nonatomic, weak) UILabel *btnTitleLa;
@property (nonatomic, weak) UILabel *la;
@property (nonatomic, weak) UIButton *signInBtn;
@property (nonatomic, weak) UIButton *newsBtn;

@end

@implementation HeaderTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        [self setUI];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScroll:) name:@"ADSCROLL" object:nil];
    }
    return self;
}

#pragma mark - 接收通知，刷新顶部topBgColorView的背景色
//- (void)onScroll:(NSNotification *)noti{
//
//    if ( [HeaderList sharedInstance].recommendTop == NO) {
//
//        self.backgroundColor = [UIColor colorWithHexString:@"F88222"] ;
//
//        return;
//    }
//
//    NSDictionary *dic = noti.userInfo;
//    NSString *colorStr = [dic objectForKey:@"color"];
//    self.backgroundColor = [UIColor colorWithHexString:colorStr];
//}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)handleTap{
    
    NSString *str = @"";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    #ifdef DEBUG
    str = [NSString stringWithFormat:@"当前版本：dev%@\n       build：%@",app_Version,app_build];
    #else
    str = [NSString stringWithFormat:@"当前版本：relese%@,build：%@",app_Version,app_build];
    #endif
    
    [self.viewController.view makeToast:str duration:2.0 position:CSToastPositionBottom];

}

- (void)setUI{
    
    UILabel *la = [[UILabel alloc] init];
    self.la = la;
    la.textColor = UIColor.blackColor;
    la.font = [UIFont boldSystemFontOfSize:20];
    la.textAlignment = NSTextAlignmentCenter;
    la.text = @"闪蜜";
    la.userInteractionEnabled = YES;
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    doubleTapGesture.numberOfTapsRequired =5;
    doubleTapGesture.numberOfTouchesRequired =1;
    [la addGestureRecognizer:doubleTapGesture];
  
    
    [self addSubview:la];
    
//    UIButton *signInBtn = [[UIButton alloc] init];
//    self.signInBtn = signInBtn;
//    [signInBtn setImage:[UIImage imageNamed:@"签到"] forState:UIControlStateNormal];
//    [signInBtn addTarget:self action:@selector(onSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:signInBtn];
//
//    UIButton *newsBtn = [[UIButton alloc] init];
//    self.newsBtn = newsBtn;
//    [newsBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
//    [newsBtn addTarget:self action:@selector(onNewsBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:newsBtn];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.backgroundColor = UIColor.whiteColor;
    searchBtn.layer.cornerRadius = 15;
    self.searchBtn = searchBtn;
    [searchBtn addTarget:self action:@selector(onSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    
    UIImageView *btnIm= [[UIImageView alloc] init];
    btnIm.image = [UIImage imageNamed:@"img_search"];
    [searchBtn addSubview:btnIm];
    self.btnIm = btnIm;
    
    UILabel *btnTitleLa = [[UILabel alloc] init];
    btnTitleLa.attributedText = [NSString getAttributedWithString:@"粘贴宝贝标题，先领券再购买" WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:13] color:UIColor.lightGrayColor];
    
    [searchBtn addSubview:btnTitleLa];
    self.btnTitleLa = btnTitleLa;
}

#pragma mark - 搜索
- (void)onSearchBtn:(UIButton *)sender{
    
    HeaderSearchViewController *vc = [[HeaderSearchViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 签到
- (void)onSignInBtn:(UIButton *)sender{
    
    DLog(@"签到");
}

#pragma mark - 消息
- (void)onNewsBtn:(UIButton *)sender{
    
    SMNewsViewController *vc = [[SMNewsViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (void)layoutSubviews{
    
    //    CGFloat spacing = 10;
    
    CGFloat min_x = 0;
    CGFloat min_y = STATUS_BAR_HEIGHT;
    CGFloat min_w = 65;
    CGFloat min_h = 35;
    self.la.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
//    min_x = KScreenWidth - 35;
//    min_w = 30;
//    min_h = 30;
//    self.newsBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
//
//    min_x = KScreenWidth - 65;
//    self.signInBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_y = min_y + 2.5;
    min_x = CGRectGetMaxX(self.la.frame);
    min_w = KScreenWidth - 70 - 10;
    min_h = 30;
    self.searchBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 10;
    min_y = 2.5;
    min_w = 25;
    min_h = 25;
    self.btnIm.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = CGRectGetMaxX(self.btnIm.frame);
    min_y = 0;
    min_w = KScreenWidth - 70 - 70 - 10 - 30;
    min_h = 30;
    self.btnTitleLa.frame = CGRectMake(min_x, min_y, min_w, min_h);
}
@end
