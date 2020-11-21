//
//  CollectorViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CollectorViewController.h"
#import "CollectorCell.h"
#import "ProductDetailViewController.h"
#import "CollectorBottomView.h"
#import "CollectorStore.h"
#import "GoodsCellLayout.h"

@interface CollectorViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageno;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) CollectorBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *deleteArr;

@end

@implementation CollectorViewController

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (NSMutableArray *)deleteArr{
    
    if (!_deleteArr) {
        
        _deleteArr = [NSMutableArray array];
    }
    return _deleteArr;
}

- (CollectorBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[CollectorBottomView alloc] initWithFrame:CGRectMake(0, KScreenHeight - iPhoneX_Top, KScreenWidth, TAB_BAR_HEIGHT)];
        
        MJWeakSelf
        _bottomView.deleteBlock = ^{
            
            MJStrongSelf
            if (self.deleteArr.count <= 0) {
                
                [weakSelf showFailMsg:@"请选择至少一个商品"];
            }else{
                
                [strongSelf.listArr removeObjectsInArray:weakSelf.deleteArr];
                strongSelf.deleteArr = [NSMutableArray array];
                
                [weakSelf.tableView reloadData];
                
            }
            
        };
        
        _bottomView.selectedBlock = ^(BOOL selected) {
            
            if (selected) {
                
                for (int i = 0; i < self.listArr.count; i ++) {
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                    
                    [weakSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                    
                    [weakSelf.deleteArr addObjectsFromArray:weakSelf.listArr];
                };
            }else{
                
                for (int i = 0; i < self.listArr.count; i ++) {
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                    
                    [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
                    
                    weakSelf.deleteArr = [NSMutableArray array];
                };
            }
        };
    }
    return _bottomView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        
        MJWeakSelf
        _tableView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
            
            self->pageno = 1;
            [weakSelf loadData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->pageno ++;
            [weakSelf loadData];
        }];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pageno = 1;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNavBarWithTitle:@"我的收藏"];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItem:)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
     [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self showLottie];
    
    [self loadData];
    
}

#pragma mark - 管理
- (void)onRightItem:(UIBarButtonItem *)item{
    
    if (self.listArr.count <= 0) {
        
        return;
    }
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];

    if (self.tableView.isEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.bottomView.top -= TAB_BAR_HEIGHT;
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.bottomView.top += TAB_BAR_HEIGHT;
        }];
    }
}

- (void)loadData{
    
    MJWeakSelf
    [CollectorStore getCollectorListWithUserguid:SMUserGuid identity:SMIdentity Pageno:pageno  Pagesize:PAGESIZE Success:^(NSArray *tabArr) {
        
        if (self->pageno == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:tabArr];
            
        }else{
            
            [weakSelf.listArr addObjectsFromArray:tabArr];
        }
        
        if (weakSelf.listArr.count <= 0) {
            
            weakSelf.tableView.emptyDataSetSource = self;
            weakSelf.tableView.emptyDataSetDelegate = self;
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf hidenLottie];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showToastWithError:error];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        [weakSelf hidenLottie];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    
    return layout.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        
        cell = [[CollectorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setLayout:self.listArr[indexPath.row]];
    return cell;
}

//出现左侧的选中框
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    
    if (!tableView.isEditing) {
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
        vc.goodsModel = layout.data;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        [self.deleteArr addObject:[self.listArr objectAtIndex:indexPath.row]];
        
        if (self.deleteArr.count == self.listArr.count) {
            
            self.bottomView.selectedBtn.selected = YES;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [self.deleteArr removeObject:[self.listArr objectAtIndex:indexPath.row]];
    
     self.bottomView.selectedBtn.selected = NO;
}


@end
