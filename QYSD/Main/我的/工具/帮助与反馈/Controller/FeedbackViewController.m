//
//  FeedbackViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "FeedbackViewController.h"
#import "ZJScrollPageView.h"
#import "GuessYourAskViewController.h"
#import "OpinionViewController.h"
#import "MyFeedbackViewController.h"
@interface FeedbackViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) NSArray *vcArr;
@end

@implementation FeedbackViewController

- (NSArray *)titles{
    
    if (!_titles) {
        
        _titles =  @[@"常见问题",
                     @"意见反馈",
                     @"我的反馈"
                     ];
    }
    return _titles;
}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        GuessYourAskViewController *vc1 = [[GuessYourAskViewController alloc] init];
        OpinionViewController *vc2 = [[OpinionViewController alloc] init];
        MyFeedbackViewController *vc3 = [[MyFeedbackViewController alloc] init];
        
        _vcArr = @[vc1,vc2,vc3];
    }
    return _vcArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavBarWithTitle:@"意见反馈"];
    [self setupSegmentView];
    [self setupContentView];
    
    [self.segmentView setSelectedIndex:self.selectedIndex animated:YES];
    
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    //    style.titleMargin = 10;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
    style.segmentViewBounces = NO;
    
    style.scaleTitle = YES;
    //    style.titleMargin = 35;
    //    style.showExtraButton = YES;
    //    style.extraBtnBackgroundImageName = @"img_more";
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.view endEditing:YES];
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    segment.backgroundColor = UIColor.whiteColor;
    
    self.segmentView = segment;
    [self.view addSubview:segment];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 40, kScreenWidth, KScreenHeight - iPhoneX_Top  - 40) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
   
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}


- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = reuseViewController;
    childVc = self.vcArr[index];
    return childVc;
}

@end
