//
//  TestListBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TestListBaseView.h"
#import "GoodsCell.h"
#import "HomejxwlModel.h"
#import "RecommendStore.h"
#import "HeaderChildCollectionFlowLayout.h"
#import "ProductDetailViewController.h"
#import "GoodsCellLayout.h"

@interface TestListBaseView()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger pageno;
}
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation TestListBaseView

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            HeaderChildCollectionFlowLayout *layout = [[HeaderChildCollectionFlowLayout alloc] init];
            
            layout.sectionInset = UIEdgeInsetsMake(8, 10, 8, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"CELL"];
            [self insertSubview:_collectionView atIndex:0];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            MJWeakSelf
            _collectionView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
                
                self->pageno = 1;
                [weakSelf loadData];
            }];
            
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                self->pageno ++;
                [weakSelf loadData];
            }];
            _collectionView.mj_footer = footer;
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BaseBackGroundColor;
        pageno = 1;
        [self.collectionView.mj_header beginRefreshing];
    }
    return self;
}

- (void)loadData{
    
    MJWeakSelf
    [RecommendStore getOptimusMaterialWithMaterialid:self.jxwlModel.NavigateID identity:IDENTITY Pageno:pageno Pagesize:PAGESIZE Success:^(NSArray *tabArr) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (self->pageno == 1) {
            
            self.listArr = [NSMutableArray arrayWithArray:tabArr];
        }else{
            
            [self.listArr addObjectsFromArray:tabArr];
        }
        
        [weakSelf.collectionView reloadData];
        
    } Failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    }];
}


- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
//    DetailViewController *detailVC = [[DetailViewController alloc] init];
//    detailVC.infoString = self.dataSource[indexPath.row];
//    [self.naviController pushViewController:detailVC animated:YES];
//
//    if (self.lastSelectedIndexPath == indexPath) {
//        return;
//    }
//    if (self.lastSelectedIndexPath != nil) {
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
//        [cell setSelected:NO animated:NO];
//    }
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelected:YES animated:NO];
//    self.lastSelectedIndexPath = indexPath;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    GoodsCell *cell = (GoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setLayout:layout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.goodsModel = layout.data;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    return CGSizeMake(layout.width,  layout.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self;
}

- (UIScrollView *)listScrollView {
    return self.collectionView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listDidAppear {
    NSLog(@"listDidAppear");
}

- (void)listDidDisappear {
    NSLog(@"listDidDisappear");
}

@end
