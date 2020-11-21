//
//  OrderCenterViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "OrderCenterViewController.h"
#import "OrderCenterHeaderView.h"
#import "OrderCenterCell.h"
#import "ProductDetailViewController.h"

@interface OrderCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderCenterHeaderView *headerView;
@property (nonatomic, copy) NSArray *listArr;
@end

@implementation OrderCenterViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJWeakSelf
        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
            
            [weakSelf loadData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
    }
    return _tableView;
}

- (OrderCenterHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[OrderCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 180)];
        MJWeakSelf
        _headerView.selectedTypeBlock = ^{
          
            [weakSelf loadData];
        };
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"我的订单"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self loadData];
}


- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
         self.listArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
        [self.tableView reloadData];
    });
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 218;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCenterCell *cell = [OrderCenterCell tempVithTableView:tableView];
    cell.titleLa.attributedText = [NSString getAttributedWithString:@"雅诗兰黛迷你v90 小瓶更好用" WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:15] color:UIColor.blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
