//
//  MyProfitViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyProfitViewController.h"
#import "MyProfitHeaderView.h"

@interface MyProfitViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyProfitHeaderView *headerView;
@end

@implementation MyProfitViewController

- (MyProfitHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[MyProfitHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, iPhoneX?870:845)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
//
////    self.edgesForExtendedLayout = UIRectEdgeNone;
//
    [self.tableView reloadData];
}


@end
