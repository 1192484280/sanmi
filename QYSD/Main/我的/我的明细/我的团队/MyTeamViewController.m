//
//  MyTeamViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyTeamViewController.h"
#import "ZJScrollSegmentView.h"
#import "MyTeamCell.h"

@interface MyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) UIView *xibView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *listArr;
@end

@implementation MyTeamViewController

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"MyTeamBottomBar" owner:self options:nil] lastObject];
    }
    return _xibView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarWithTitle:@"我的团队"];
    
    [self setupSegmentView];
    
    [self.view addSubview:self.xibView];
    [self.xibView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(65 + iPhoneX_Bottom);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.segmentView.mas_bottom).offset(0.5);
        make.bottom.equalTo(self.xibView.mas_top);
    }];
    
    [self loadData];
}

- (void)setupSegmentView{
    
    NSArray *arr = @[@"全部会员",@"二当家",@"三当家",@"直属会员"];
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
    MJWeakSelf
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:nil titles:arr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf loadData];
    }];
    
    segment.backgroundColor = UIColor.whiteColor;
    self.segmentView = segment;
    [self.view addSubview:segment];
    
}

- (void)loadData{
    
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        self.listArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
        [self.tableView reloadData];
    });
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTeamCell *cell = [MyTeamCell tempVithTableView:tableView];
    return cell;
}

@end
