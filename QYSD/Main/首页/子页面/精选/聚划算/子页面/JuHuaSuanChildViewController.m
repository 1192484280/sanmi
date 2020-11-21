//
//  JuHuaSuanChildViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "JuHuaSuanChildViewController.h"
#import "ZJScrollPageView.h"
#import "JuHuaSuanGrandsonViewController.h"

@interface JuHuaSuanChildViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, copy) NSArray *titlesArr;
@property (nonatomic, copy) NSArray *vcArr;

@end

@implementation JuHuaSuanChildViewController

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i< self.titlesArr.count; i++) {
            
            JuHuaSuanGrandsonViewController *childVc = [[JuHuaSuanGrandsonViewController alloc] init];
            [arr addObject:childVc];
            
        }
        _vcArr = arr;
    }
    return _vcArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"聚划算"];
    [self setupSegmentView];
    [self setupContentView];
    [self loadData];
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
//    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = YES;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
    style.scaleTitle = NO;
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
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 40.5, kScreenWidth, KScreenHeight - iPhoneX_Top - 40.5 - 40.5) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view insertSubview:content atIndex:1];
    //    [self.view addSubview:self.contentView];
    
}

#pragma mark - 刷新数据
- (void)loadData{
    
    MJWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        weakSelf.titlesArr = @[@"女装",
                            @"男装",
                            @"内衣",
                            @"母婴",
                            @"美妆",
                            @"家居",
                            @"鞋包配饰",
                            @"美食",
                            @"文体车品",
                            @"数码家电",
                            @"户外运动",
                            @"其他",
                            ];
        [weakSelf.segmentView reloadTitlesWithNewTitles:self.titlesArr];
        [weakSelf.contentView reload];
        
    });
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
