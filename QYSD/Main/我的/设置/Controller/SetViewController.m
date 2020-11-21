//
//  SetViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/25.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SetViewController.h"
#import "SetHeaderView.h"

@interface SetViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SetHeaderView *headerView;

@end

@implementation SetViewController

- (SetHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[SetHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 465)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavBarWithTitle:@"设置"];
    
    [self.tableView reloadData];
}


@end
