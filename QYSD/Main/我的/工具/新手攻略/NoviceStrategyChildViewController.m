//
//  NoviceStrategyChildViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/4.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "NoviceStrategyChildViewController.h"

@interface NoviceStrategyChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArr;

@end

@implementation NoviceStrategyChildViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"如何下载闪蜜APP",@"登录注册方式"];
    }
    return _titleArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.emptyDataSetSource = self;
        //        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = FontColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self goWebView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:self.name];
    
    [self.tableView reloadData];
}

@end
