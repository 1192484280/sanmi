//
//  ChangeUrlModelViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ChangeUrlModelViewController.h"
#import "ChangeUrlModelHeaderView.h"

@interface ChangeUrlModelViewController ()

@property (nonatomic, strong) ChangeUrlModelHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ChangeUrlModelViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (ChangeUrlModelHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[ChangeUrlModelHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 487)];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"转链模板设置"];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.tableView reloadData];
}


@end
