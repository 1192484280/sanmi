//
//  NoviceStrategyViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/4.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "NoviceStrategyViewController.h"
#import "NoviceStrategyChildViewController.h"

@interface NoviceStrategyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *imgArr;
@end

@implementation NoviceStrategyViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"更=闪蜜下载",@"APP指南"];
    }
    return _titleArr;
}

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"downshanmi",@"abouushanmi"];
    }
    return _imgArr;
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
    
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = FontColor;
    CGSize itemSize = CGSizeMake(40, 40);
    
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    
    [cell.imageView.image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoviceStrategyChildViewController *vc = [[NoviceStrategyChildViewController alloc] init];
    vc.name = self.titleArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"新手攻略"];
    
    [self.tableView reloadData];
}


@end
