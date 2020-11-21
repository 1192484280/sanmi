//
//  MineViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineNavView.h"
#import "CommonStore.h"
#import "UserModel.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;
@property (nonatomic, strong) MineNavView *navView;

@end

@implementation MineViewController

//- (MineNavView *)navView{
//
//    if (!_navView) {
//
//        _navView = [[MineNavView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top)];
//        _navView.alpha = 0;
//    }
//    return _navView;
//}

- (MineHeaderView *)headerView{
    
    if (!_headerView) {
        
//        CGFloat height = STATUS_BAR_HEIGHT + 130 + 80 - 15 + 135 + 10 + 70 +10 + 140 + 10 + 120 +10 + 268 +10 + 20;
        
        CGFloat height = STATUS_BAR_HEIGHT + 130 + 150 - 25 + 130 + 10;
        
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [UIView new];
        
        MJWeakSelf
        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
            
            [weakSelf loadData];
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
    
//    [self.view addSubview:self.navView];
    
    [self.view insertSubview:self.tableView atIndex:0];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"LoginSuccess" object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData{
    
    if (![SMUserGuid isValid]) {
        
        [self.tableView.mj_header endRefreshing];
        return;
    }
    MJWeakSelf
    [CommonStore getUserInfoWithUserguid:SMUserGuid Sucess:^(UserModel *userModel) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.headerView.topView.model = userModel;
        
    } Failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark - 滚动监听
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat alpha = offsetY / 100;
//    
//    self.navView.alpha = alpha;
//
//    if (scrollView == self.tableView) {
//        CGFloat offY = scrollView.contentOffset.y;
//        if (offY < 0) {
//            scrollView.contentOffset = CGPointZero;
//        }
//    }
//}


@end
