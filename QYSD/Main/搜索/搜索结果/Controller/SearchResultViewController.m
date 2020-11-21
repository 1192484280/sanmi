//
//  SearchResultViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultHeaderView.h"
#import "ZJScrollPageView.h"
#import "SearchBigMoneyViewController.h"
#import "SearchAllNetViewController.h"

@interface SearchResultViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) SearchResultHeaderView *headerView;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *vcArr;

@end

@implementation SearchResultViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"搜全网"];
    }
    return _titleArr;
}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        _vcArr = @[[[SearchAllNetViewController alloc] init]];
    }
    return _vcArr;
}

- (SearchResultHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[SearchResultHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top) andKeyWord:self.keyWord];
    }
    return _headerView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.headerView];
    
//    [self setupSegmentView];
    
    [self setupContentView];
    
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.adjustCoverOrLineWidth = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = [UIColor colorWithRGB:0xFA6400];
    style.normalTitleColor = [UIColor colorWithRGB:0x000000];
    style.selectedTitleColor = [UIColor colorWithRGB:0xFA6400];
    style.segmentViewBounces = NO;
    style.scaleTitle = YES;
    // 注意: 一定要避免循环引用!!
    MJWeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top, KScreenWidth, 45.0) segmentStyle:style delegate:nil titles:self.titleArr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    self.segmentView = segment;
    self.segmentView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:segment];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top, kScreenWidth, KScreenHeight - iPhoneX_Top) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

- (NSInteger)numberOfChildViewControllers {
    return self.titleArr.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
//    UIViewController *childVc = self.vcArr[index];

    SearchAllNetViewController *childVc =  [[SearchAllNetViewController alloc] init];
    childVc.keyWord = self.keyWord;
    return childVc;
}

@end
