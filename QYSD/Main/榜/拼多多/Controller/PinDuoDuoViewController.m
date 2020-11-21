//
//  PinDuoDuoViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PinDuoDuoViewController.h"
#import "TaoBaoHeaderView.h"
#import "ProductDetailViewController.h"

@interface PinDuoDuoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TaoBaoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PinDuoDuoViewController
//
//- (UITableView *)tableView{
//    
//    if (!_tableView) {
//        
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.sectionHeaderHeight = 9.5;
//        _tableView.sectionFooterHeight = 0.5;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
//        [self.view addSubview:_tableView];
//        MJWeakSelf
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.top.equalTo(weakSelf.headerView.mas_bottom);
//            make.bottom.mas_equalTo(0);
//        }];
//        
//        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
//            
//            [weakSelf loadData];
//        }];
//        
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//    }
//    return _tableView;
//}
//
//- (TaoBaoHeaderView *)headerView{
//    
//    if (!_headerView) {
//        _headerView = [[TaoBaoHeaderView alloc] init];
//        _headerView.frame = CGRectMake(0, 0, KScreenWidth, 55);
//        _headerView.btnOneTitle = @"火爆热卖";
//        _headerView.btnTwoTitle = @"实时疯抢";
//        MJWeakSelf
//        _headerView.btnOneBlock = ^{
//            
//            [weakSelf.tableView.mj_header beginRefreshing];
//        };
//        
//        _headerView.btnTwoBlock = ^{
//            
//            [weakSelf.tableView.mj_header beginRefreshing];
//        };
//    }
//    return _headerView;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.view.backgroundColor = UIColor.whiteColor;
//    
//    [self.view addSubview:self.headerView];
//        
//    [self.tableView.mj_header beginRefreshing];
//}
//
//- (void)loadData{
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    });
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 150;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 10;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 1;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    TopCell *cell = [TopCell tempWithTableView:tableView];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//}
@end
