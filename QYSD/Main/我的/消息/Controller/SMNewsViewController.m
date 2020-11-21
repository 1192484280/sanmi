//
//  SMNewsViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMNewsViewController.h"
#import "SMNewsModel.h"
#import "SMNewsCell.h"
#import "SMNewsListViewController.h"

@interface SMNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SMNewsViewController

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        SMNewsModel *model = [[SMNewsModel alloc] init];
        model.img = @"img_new01";
        model.title = @"官方小报";
        model.des = @"官方一切消息通告都在这里，一定要每天关注哦！";
        
        SMNewsModel *model2 = [[SMNewsModel alloc] init];
        model2.img = @"img_new02";
        model2.title = @"闪蜜答疑";
        model2.des = @"专注为您答疑解惑，真心希望能够为您带来帮助！";
        
        _listArr = @[model,model2];
    }
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"消息"];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 73;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMNewsCell *cell = [SMNewsCell tempWithTableView:tableView];
    cell.model = self.listArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SMNewsListViewController *vc = [[SMNewsListViewController alloc] init];
     vc.name = @"官方小报";
    if (indexPath.row == 1) {
        
         vc.name = @"闪蜜答疑";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
