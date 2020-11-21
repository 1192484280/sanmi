//
//  CircleViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CircleViewController.h"
#import "ZJScrollPageView.h"
#import "MerchandiseRecommendationViewController.h"
#import "MerchandiseReChildViewController.h"
#import "WKWebViewController.h"
#import "WkWebList.h"

@interface CircleViewController ()<ZJScrollPageViewDelegate>

@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *vcArr;
@property (nonatomic, strong) UIButton *schoolBtn;
@end

@implementation CircleViewController

//- (UIButton *)schoolBtn{
//    
//    if (!_schoolBtn) {
//        
//        _schoolBtn = [[UIButton alloc] init];
//        [_schoolBtn setTitle:@"商学院" forState:UIControlStateNormal];
//        [_schoolBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//        _schoolBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_schoolBtn addTarget:self action:@selector(onSchoolBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _schoolBtn;
//}
//
//#pragma mark - 点击商学院
//- (void)onSchoolBtn:(UIButton *)sendder{
//    
//    [WkWebList sharedInstance].url = @"http://shanmi.qytimes.cn/H5/Public/";
//    WKWebViewController *webVC = [[WKWebViewController alloc] init];
//    [webVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:webVC animated:YES];
//}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        MerchandiseRecommendationViewController *childVc1 = [[MerchandiseRecommendationViewController alloc] init];
        
        MerchandiseReChildViewController *childVc2 = [[MerchandiseReChildViewController alloc] init];
        childVc2.type = 4;
        
        MerchandiseReChildViewController *childVc3 = [[MerchandiseReChildViewController alloc] init];
        childVc3.type = 5;
        
        [WkWebList sharedInstance].url = @"http://shanmi.qytimes.cn/H5/Public/";
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        
        _vcArr = @[childVc1,childVc2,childVc3,webVC];
    }
    return _vcArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = UIColor.whiteColor;

    [self setUI];
    
}

- (void)setUI{
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    CGFloat width = KScreenWidth /4;
//    CGFloat height = 40;
//    [self.view addSubview:self.schoolBtn];
//    [self.schoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(0);
//        make.top.mas_equalTo(STATUS_BAR_HEIGHT);
//        make.width.mas_equalTo(width);
//        make.height.mas_equalTo(height);
//    }];
    
    [self setupSegmentView];
    [self setupContentView];

}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.adjustCoverOrLineWidth = YES;
    //    style.isAdjustCoverOrLineWidth = YES;
    style.showLine = YES;
    style.scrollTitle = NO;
    style.scaleTitle = YES;
    style.selectedTitleColor = UIColor.orangeColor;
    style.scrollLineColor = UIColor.orangeColor;
    style.titleFont = [UIFont boldSystemFontOfSize:15];
    
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    self.titles = @[@"商品推荐",
                    @"营销素材",
                    @"新手必发",
                    ];
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, KScreenWidth, 40.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    self.segmentView = segment;
    [self.view insertSubview:segment atIndex:1];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, STATUS_BAR_HEIGHT + 40, kScreenWidth, KScreenHeight - STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT - 40) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view insertSubview:content atIndex:1];
    //    [self.view addSubview:self.contentView];
    
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
        
    UIViewController *childVc = self.vcArr[index];
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

@end
