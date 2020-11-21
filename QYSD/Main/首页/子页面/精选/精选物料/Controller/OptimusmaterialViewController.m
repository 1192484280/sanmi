//
//  OptimusmaterialViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/17.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "OptimusmaterialViewController.h"
#import "JXCategoryView.h"
#import "JXPagerView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"
#import "RecommendStore.h"
#import "HomejxwlModel.h"

@interface OptimusmaterialViewController ()<JXPagerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *modes;
@end

@implementation OptimusmaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BaseBackGroundColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
    
    _userHeaderView = [[PagingViewTableHeaderView alloc] init];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
//    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = UIColor.clearColor;
    
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = SMOrangeColor;
    self.categoryView.titleColor = FontColor;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];
    self.categoryView.titleLabelZoomScale = 1;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = SMOrangeColor;
//    lineView.indicatorLineWidth = 30;
    lineView.indicatorHeight = 1;
    self.categoryView.indicators = @[lineView];
    
    _pagerView = [self preferredPagingView];
    [self.view addSubview:self.pagerView];
    
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    [self loadData];
}

- (void)loadData{
    
    [self.userHeaderView.im sd_setImageWithURL:self.jxwlModel.PicURL1.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    //获取导航栏
    MJWeakSelf
    [RecommendStore getHomejxwlWithParentnavigateid:self.jxwlModel.NavigateID Success:^(NSArray *theArr) {

        self.modes = theArr;

        NSMutableArray *arr = [NSMutableArray array];
        for (HomejxwlModel *model in theArr) {

            [arr addObject:model.NavigateName];
        }

        weakSelf.titles = arr;
        weakSelf.categoryView.titles = weakSelf.titles;
        [weakSelf.categoryView reloadData];
        [weakSelf.pagerView reloadData];



    } Failure:^(NSError *error) {
//        [weakSelf showToastWithError:error ];
    }];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerListRefreshView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return KScreenWidth *0.39;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
    HomejxwlModel *model = self.modes[index];
    TestListBaseView *listView = [[TestListBaseView alloc] init];
    listView.jxwlModel = model;
    listView.naviController = self.navigationController;
    return listView;
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
    [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


@end
