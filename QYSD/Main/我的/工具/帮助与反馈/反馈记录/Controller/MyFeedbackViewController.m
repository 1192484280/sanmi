//
//  MyFeedbackViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyFeedbackViewController.h"
#import "MyFeedBackStore.h"
#import "MyFeedBackModel.h"
#import "FeedBackCell.h"
#import "FeedBackLayout.h"

@interface MyFeedbackViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageno;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation MyFeedbackViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        [_tableView registerClass:[FeedBackCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        if (@available(iOS 11.0, *)) {
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        } else {
            
            self.automaticallyAdjustsScrollViewInsets = NO;
            
        }
        
        MJWeakSelf
        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
            
            self->pageno = 1;
            [weakSelf loadData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->pageno ++;
            [self loadData];
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarWithTitle:@"反馈记录"];
    
    pageno = 1;
    
    [self loadData];
}


- (void)loadData{
    
    MJWeakSelf
    [MyFeedBackStore getFeedbacklistWithUserguid:SMUserGuid pageno:pageno pagesize:PAGESIZE Sucess:^(NSArray * _Nonnull theArr) {
        
        if (self->pageno == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:theArr];
            
            if (theArr.count < 20) {
                
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                
                weakSelf.tableView.mj_footer.hidden = NO;
            }
        }else{
            if (theArr.count <= 0) {
                
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                
                [weakSelf.listArr addObjectsFromArray:theArr];
            }
            
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } Failure:^(NSError * _Nonnull error) {
        
        [weakSelf showToastWithError:error];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedBackLayout *layout = self.listArr[indexPath.section];
    return layout.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell = [[FeedBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setLayout:self.listArr[indexPath.section]];
    return cell;
}


@end
