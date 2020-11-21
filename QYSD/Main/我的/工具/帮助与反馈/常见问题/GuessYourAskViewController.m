//
//  GuessYourAskViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "GuessYourAskViewController.h"

@interface GuessYourAskViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *listArr;

@end

@implementation GuessYourAskViewController

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = @[@"1. 闪蜜免单提现，返款时间说明",@"2. 一分购返款问题解答",@"3. 工资提现答疑"];
    }
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.attributedText = [NSString getAttributedWithString:self.listArr[indexPath.row] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:FontColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self goWebView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
}



@end
