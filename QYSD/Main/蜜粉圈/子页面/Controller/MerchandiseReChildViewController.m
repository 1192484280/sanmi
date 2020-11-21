//
//  MerchandiseReChildViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MerchandiseReChildViewController.h"
#import "MerchandiseReChildCell.h"
#import "MerchandiseChildLayout.h"
#import "CircleStore.h"

@interface MerchandiseReChildViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation MerchandiseReChildViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        [_tableView registerClass:[MerchandiseReChildCell class] forCellReuseIdentifier:@"Cell"];
        
        if (@available(iOS 11.0, *)) {

            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        } else {

            self.automaticallyAdjustsScrollViewInsets = NO;

        }
        
        MJWeakSelf
         _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{

             self->page = 1;
             [weakSelf loadData];
        }];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->page ++;
            [self loadData];
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    page = 1;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self showLottie];
    
    [self loadData];
}

- (void)loadData{
    
    
    MJWeakSelf
    [CircleStore getFQmaterialWithType:self.type andNavigateid:self.navigateid pageno:page pagesize:PAGESIZE Success:^(NSArray *listArr) {
        
        if (self->page == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
            
            if (listArr.count < 20) {
                
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                
                weakSelf.tableView.mj_footer.hidden = NO;
            }
        }else{
            if (listArr.count <= 0) {
                
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                
                [weakSelf.listArr addObjectsFromArray:listArr];
            }
            
        }
        
        if (weakSelf.listArr.count <= 0) {
            
            weakSelf.tableView.emptyDataSetSource = self;
            weakSelf.tableView.emptyDataSetDelegate = self;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [weakSelf hidenLottie];
        
    } Failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf showToastWithError:error];
        
        [weakSelf hidenLottie];

    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchandiseChildLayout *layout = self.listArr[indexPath.section];
    return layout.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchandiseReChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell = [[MerchandiseReChildCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setLayout:self.listArr[indexPath.section]];
    return cell;
}


@end
