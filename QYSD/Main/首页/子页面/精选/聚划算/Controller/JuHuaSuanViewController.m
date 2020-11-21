//
//  JuHuaSuanViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "JuHuaSuanViewController.h"
#import "ZJScrollPageView.h"
#import "JuHuaSuanChildViewController.h"

@interface JuHuaSuanViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, copy) NSArray *titlesArr;
@property (nonatomic, copy) NSArray *vcArr;

@end

@implementation JuHuaSuanViewController

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i< self.titlesArr.count; i++) {
            
            JuHuaSuanChildViewController *childVc = [[JuHuaSuanChildViewController alloc] init];
            [arr addObject:childVc];
            
        }
        _vcArr = arr;
    }
    return _vcArr;
}

- (NSArray *)titlesArr{
    
    if (!_titlesArr) {
        
        _titlesArr = @[@"聚划算",@"淘抢购",@"热门分享",@"特惠专区",@"好货云集"];
    }
    return _titlesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavBarWithTitle:@"聚划算"];
    [self setupSegmentView];
    [self setupContentView];
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
//    style.segmentViewBounces = NO;
    style.scaleTitle = YES;
    style.segmentViewBounces = YES;
    style.scrollContentView = NO;
    // 注意: 一定要避免循环引用!!
    MJWeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:nil titles:self.titlesArr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    segment.backgroundColor = UIColor.whiteColor;
    self.segmentView = segment;
    [self.view addSubview:segment];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 40.5, kScreenWidth, KScreenHeight - iPhoneX_Top - 40.5) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view insertSubview:content atIndex:1];
    //    [self.view addSubview:self.contentView];
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titlesArr.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = reuseViewController;
    childVc = self.vcArr[index];
    return childVc;
}
@end
