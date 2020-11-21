//
//  IncomeRankingViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "IncomeRankingViewController.h"
#import "IncomeRankingNavView.h"
#import "ZJScrollPageView.h"
#import "IncomeRankingTopThreeView.h"
#import "IncomeRankingCell.h"

@interface IncomeRankingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IncomeRankingNavView *navView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) IncomeRankingTopThreeView *topThreeView;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIView *bgView;
@end

@implementation IncomeRankingViewController


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 5;
    }
    return _tableView;
}

- (IncomeRankingTopThreeView *)topThreeView{
    
    if (!_topThreeView) {
        
        _topThreeView = [[IncomeRankingTopThreeView alloc] init];
        
    }
    return _topThreeView;
}

- (IncomeRankingNavView *)navView{

    if(!_navView){

        _navView = [[IncomeRankingNavView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top)];

    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    [self.view az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"E0204E"],[UIColor colorWithHexString:@"FA6400"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    
    [self.view addSubview:self.navView];
    [self setupSegmentView];
    [self.view addSubview:self.topThreeView];
     [self.view addSubview:self.tableView];
    
    [self.topThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.equalTo(self.segmentView.mas_bottom);
        make.height.mas_equalTo(180);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topThreeView.mas_bottom);
        make.bottom.mas_equalTo(-35);
    }];

}

- (void)setupSegmentView{
    
    NSArray *arr = @[@"今日收益排行榜",@"七日收入排行榜"];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
//    style.showLine = YES;
    //    style.titleMargin = 10;
    style.showCover = YES;
    style.coverBackgroundColor = [UIColor whiteColor];
    //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.normalTitleColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = [UIColor colorWithRed:235.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = [UIColor colorWithRGB:0xffffff];
    style.normalTitleColor = [UIColor colorWithRGB:0xffffff];
    style.selectedTitleColor = [UIColor colorWithRGB:0xE02020];
    style.segmentViewBounces = YES;
    style.scaleTitle = YES;
    //    style.titleMargin = 35;
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(35, iPhoneX_Top + 10, KScreenWidth - 70, 35.0) segmentStyle:style delegate:nil titles:arr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
    }];
    
    segment.layer.cornerRadius = 17.5;
    segment.layer.borderUIColor = UIColor.whiteColor;
    segment.layer.borderWidth = 1;
//    segment.backgroundColor = [UIColor redColor];
    
    self.segmentView = segment;
    //    self.navigationItem.titleView = self.segmentView;
    [self.view addSubview:segment];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IncomeRankingCell *cell = [IncomeRankingCell tempWithTableView:tableView];
    cell.indexLa.text = [NSString stringWithFormat:@"%ld",indexPath.row + 4];
    cell.phoneLa.text = @"176****7323";
    cell.moneyLa.text = @"¥ 123456";
    return cell;
}
@end
