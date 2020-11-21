//
//  MerchandiseRecommendationViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MerchandiseRecommendationViewController.h"
#import "ZJScrollPageView.h"
#import "MerchandiseReChildViewController.h"
#import "CircleStore.h"
#import "MerchandiseRecomendNavModel.h"

@interface MerchandiseRecommendationViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@property (nonatomic, copy) NSArray *modelArr;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *vcArr;
@end

@implementation MerchandiseRecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.scaleTitle = NO;
    style.selectedTitleColor = UIColor.orangeColor;
    style.scrollLineColor = UIColor.orangeColor;
    style.titleBgColor = UIColor.whiteColor;
    style.titleHeight = 30;
    style.titleCornerRadius = 15;
    
    // 颜色渐变
    style.gradualChangeTitleColor = YES;

    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - STATUS_BAR_HEIGHT - 40 - TAB_BAR_HEIGHT);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    self.scrollPageView.segmentView.backgroundColor = BaseBackGroundColor;
    
    [self.view addSubview:self.scrollPageView];
    
    [self loadData];
}

- (void)loadData{
    
    MJWeakSelf
    [CircleStore getMerchandiseRecomendNavSuccess:^(NSArray * _Nonnull listArr) {
        
        self.modelArr = listArr;
        
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        for (MerchandiseRecomendNavModel *model in listArr) {
            
            [arr1 addObject:model.NavigateName];
            
            MerchandiseReChildViewController *vc = [[MerchandiseReChildViewController alloc] init];
            vc.navigateid = model.NavigateID;
            [arr2 addObject:vc];
        }
        weakSelf.titles = arr1;
        self.vcArr = arr2;
        [weakSelf.scrollPageView.segmentView reloadTitlesWithNewTitles:weakSelf.titles];
        [weakSelf.scrollPageView.contentView reload];
        
    } Failure:^(NSError * _Nonnull error) {
        [weakSelf showToastWithError:error];
    }];
}

- (NSInteger)numberOfChildViewControllers {
    return self.vcArr.count;// 传入页面的总数, 推荐使用titles.count
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = self.vcArr[index];
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

@end
