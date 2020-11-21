//
//  SouQuanViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SouQuanViewController.h"
#import "TypeTopView.h"
#import "TypeAnimaView.h"
#import "SouQuanCell.h"

@interface SouQuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TypeTopView *topView;
@property (nonatomic, strong) TypeAnimaView *topBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *imgArr;

@end

@implementation SouQuanViewController

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"souquanLongImg"];
    }
    return _imgArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.equalTo(self.topView.mas_bottom);
        }];
    }
    return _tableView;
}

- (TypeAnimaView *)topBgView{
    
    if (!_topBgView) {
        
        _topBgView = [[TypeAnimaView alloc] init];
    }
    return _topBgView;
}

- (TypeTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[TypeTopView alloc] init];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setUI];
    
    [self.tableView reloadData];
}

- (void)setUI{
    
    [self.view addSubview:self.topView];
    self.topView.frame = CGRectMake(0, 0, KScreenWidth, 130);
    
    [self.view insertSubview:self.topBgView atIndex:0];
    self.topBgView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), KScreenWidth, KScreenWidth * 0.213);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.imgArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KScreenWidth * 3.144;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SouQuanCell *cell = [SouQuanCell tempWithTableView:tableView];
    cell.im.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    return cell;
}
@end
