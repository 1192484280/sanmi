//
//  MySecondPartnerViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MySecondPartnerViewController.h"
#import "MySecondPartnerCellTableViewCell.h"

@interface MySecondPartnerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *monyerLa;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *xibView;

@end

@implementation MySecondPartnerViewController

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"MySecondPartnerHeaderView" owner:self options:nil] lastObject];
        _xibView.frame = CGRectMake(0, 0, KScreenWidth, 45);
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
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.top.equalTo(self.xibView.mas_bottom);
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavBarWithTitle:@"我的二当家"];

    [self.view addSubview:self.xibView];

    if (self.flag  == 3) {
        
        [self setNavBarWithTitle:@"我的三当家"];
        self.titleLa.text = @"今日三当家带给我的收益";
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySecondPartnerCellTableViewCell *cell = [MySecondPartnerCellTableViewCell tempWithTableView:tableView];
    return cell;
}
@end
