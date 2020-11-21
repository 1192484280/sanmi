//
//  SMNewsListViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMNewsListViewController.h"
#import "SMNewsListModel.h"
#import "SMNewsListCell.h"

@interface SMNewsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SMNewsListViewController

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i< 20; i ++) {
            
            SMNewsListModel *model = [[SMNewsListModel alloc] init];
            model.img = @"img_newsList";
            model.title = @"闪蜜小程序，闪蜜大牌";
            model.des = @"邀请好友拿现金红包，天天拆红包，转盘抽奖，更多福利";
            model.time = @"2019-08-08";
            [arr addObject:model];
        }
        
        _listArr = arr;
    }
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 250;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self loadData];
            
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [self loadData];
            
        }];
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:self.name];
    [self.tableView reloadData];
}

- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMNewsListCell *cell = [SMNewsListCell tempWithTableView:tableView];
    cell.model = self.listArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    [self goWebView];
}

@end
