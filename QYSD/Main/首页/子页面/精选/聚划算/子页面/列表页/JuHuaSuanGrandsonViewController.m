//
//  JuHuaSuanGrandsonViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "JuHuaSuanGrandsonViewController.h"
#import "ProductDetailViewController.h"

@interface JuHuaSuanGrandsonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JuHuaSuanGrandsonViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = BaseBackGroundColor;
        _tableView.separatorColor = CellLineColor;
        [self.view addSubview:_tableView];
        MJWeakSelf
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
            
            [weakSelf loadData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 150;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 20;
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
