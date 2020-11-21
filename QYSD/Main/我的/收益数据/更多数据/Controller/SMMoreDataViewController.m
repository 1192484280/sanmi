//
//  SMMoreDataViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMMoreDataViewController.h"
#import "ZJScrollSegmentView.h"
#import "SMMoreDataModel.h"
#import "SMMoreDataHeaderView.h"
#import "SMMoreDataCell.h"

@interface SMMoreDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) SMMoreDataHeaderView *headerView;
@end

@implementation SMMoreDataViewController

- (SMMoreDataHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[SMMoreDataHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 75)];
    }
    return _headerView;
}

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        SMMoreDataModel *model1 = [[SMMoreDataModel alloc] init];
        model1.order = @"0";
        model1.yugu = @"0.00";
        
        SMMoreDataModel *model2 = [[SMMoreDataModel alloc] init];
        model2.order = @"0";
        model2.yugu = @"0.00";
        
        SMMoreDataModel *model3 = [[SMMoreDataModel alloc] init];
        model3.order = @"0";
        model3.yugu = @"0.00";
        
        _listArr = @[model1,model2,model3];
    }
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.5;
        _tableView.sectionFooterHeight = 9.5;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    [self setUI];
    
    [self loadData];
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"更多数据"];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_help"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)onRightBtn{
    
    [self goWebView];
}

- (void)setUI{
    
    [self setupSegmentView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.segmentView.mas_bottom).offset(0.5);
    }];
}

-(void)loadData{
    
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        
    });
}
- (void)setupSegmentView{
    
    NSArray *arr = @[@"今日预估",@"本月预估",@"上月预估",@"上月结算"];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
    style.segmentViewBounces = NO;
    style.scaleTitle = YES;
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:nil titles:arr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        NSString *str = @"今日总效果预估";
        if (index == 0) {
            
            str = @"今日总效果预估";
        }else if (index == 1){
            
            str = @"本月总效果预估";
        }else if (index == 2){
            
            str = @"上月总效果预估";
        }else {
            
            str = @"上月总结算收入";
        }
        
        weakSelf.headerView.title = str;
        [weakSelf loadData];
    }];
    
    segment.backgroundColor = UIColor.whiteColor;
    self.segmentView = segment;
    [self.view addSubview:segment];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 118;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMMoreDataCell *cell = [SMMoreDataCell tempVithTableView:tableView];
    [cell setModel:self.listArr[indexPath.section] andSection:indexPath.section];
    return cell;
}
@end
