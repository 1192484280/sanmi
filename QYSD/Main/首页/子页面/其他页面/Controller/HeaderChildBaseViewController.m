//
//  HeaderChildBaseViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderChildBaseViewController.h"
#import "HeaderChildCollectionReusableView.h"
#import "HeaderChildCollectionCell.h"
#import "HeaderChildCollectionFlowLayout.h"
#import "HeaderList.h"
#import "ProductDetailViewController.h"

#import "HeaderChildStore.h"
#import "GoodsCell.h"
#import "GoodsCellLayout.h"
#import "HeaderStore.h"
#import "HomeNavigateModel.h"
#import "SearchResultViewController.h"

@interface HeaderChildBaseViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger pageno;
    NSString *currentSort;
}
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) NSMutableArray *listArr2;
@property (nonatomic, strong) UIButton *goTopBtn;
@property (nonatomic, strong) HeaderChildCollectionReusableView *headerView;
@end

@implementation HeaderChildBaseViewController

- (UIButton *)goTopBtn{
    
    if (!_goTopBtn) {
        
        _goTopBtn = [[UIButton alloc] init];
        _goTopBtn.hidden = YES;
        [_goTopBtn setImage:[UIImage imageNamed:@"img_goTop"] forState:UIControlStateNormal];
        [_goTopBtn addTarget:self action:@selector(goTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goTopBtn;
}

- (void)goTop{
    
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

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
            [_collectionView registerClass:[HeaderChildCollectionCell class] forCellWithReuseIdentifier:@"CELL"];
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"CELL2"];
            [_collectionView registerClass:[HeaderChildCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
            [self.view insertSubview:_collectionView atIndex:0];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            MJWeakSelf
            _collectionView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
                
                self->pageno = 1;
                [weakSelf loadData];
            }];
            
            _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                
                self->pageno ++;
                [weakSelf loadData];
            }];
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageno = 1;
    currentSort = @"1";
    
    [self showLottie];
    
    [self loadData];
    [self addGoTopBtn];

}

- (void)addGoTopBtn{
    
    [self.view addSubview:self.goTopBtn];
    [self.goTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - 菜单数据
- (void)loadData{
    
    dispatch_queue_t queue = dispatch_queue_create("com.task.gcd", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    MJWeakSelf
    //获取顶部菜单
    
    dispatch_group_enter(group);
    [HeaderStore getHomeNavigateWithParentnavigateid:self.navigateid Success:^(NSArray *modelArr, NSArray *textArr) {
        
        weakSelf.listArr = modelArr;
        
        dispatch_group_leave(group);
        
    } Failure:^(NSError *error) {
        
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HeaderChildStore getNavigateproductWithNavigateid:self.navigateid Identity:IDENTITY Pageno:pageno Pagesize:PAGESIZE_Chid Sort:currentSort Success:^(NSArray *tabArr, NSArray *collectionArr) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        if (self->pageno == 1) {
            
            weakSelf.listArr2 = [NSMutableArray arrayWithArray:collectionArr];
        }else{
            
            [weakSelf.listArr2 addObjectsFromArray:collectionArr];
        }
        
        dispatch_group_leave(group);
        
    } Failure:^(NSError *error) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        [weakSelf showToastWithError:error];
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"全部执行完毕");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf hidenLottie];
            [weakSelf.collectionView reloadData];
        });
    });
    
}

#pragma mark - 加载列表数据
- (void)loadTabData{
    
    //获取商品信息
    MJWeakSelf
    [HeaderChildStore getNavigateproductWithNavigateid:self.navigateid Identity:IDENTITY Pageno:pageno Pagesize:PAGESIZE_Chid Sort:currentSort Success:^(NSArray *tabArr, NSArray *collectionArr) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        if (self->pageno == 1) {
            
            weakSelf.listArr2 = [NSMutableArray arrayWithArray:collectionArr];
        }else{
            
            [weakSelf.listArr2 addObjectsFromArray:collectionArr];
        }
        
        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
    } Failure:^(NSError *error) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        [weakSelf showToastWithError:error];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.listArr.count;
    }
    return self.listArr2.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HeaderChildCollectionCell *cell = (HeaderChildCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        cell.model = self.listArr[indexPath.row];
        return cell;
    }else{
        
        GoodsCellLayout *layout = self.listArr2[indexPath.row];
        GoodsCell *cell = (GoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL2" forIndexPath:indexPath];
        [cell setLayout:layout];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HomeNavigateModel *model = self.listArr[indexPath.row];
        SearchResultViewController *vc = [[SearchResultViewController alloc] init];
        vc.keyWord = model.NavigateName;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        GoodsCellLayout *layout = self.listArr2[indexPath.row];
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
        vc.goodsModel = layout.data;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

//设置每个item的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//行间距 也就是所谓的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 1) {
        
        return 10;
    }
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
        if (self.listArr.count <= 0) {
            
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }else{
            
            return UIEdgeInsetsMake(0, 0, 8, 0);
        }
        
    }else{
        
        return UIEdgeInsetsMake(8, 10, 10, 10);
    }
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    
//        CGFloat itemW = (kScreenWidth) / 4;
//        return CGSizeMake(itemW, itemW);
        
        NSInteger num = 4;
        CGFloat itemW = kScreenWidth/num;
        CGFloat height = itemW;

        if(indexPath.row == 0){
            //第一列的width比其他列稍大一些，消除item之间的间隙
            CGFloat realWidth = CGRectGetWidth(collectionView.bounds) - floor(itemW) * (num - 1);
            return CGSizeMake(realWidth, realWidth);
        }else{
            
            CGFloat realWidth = CGRectGetWidth(collectionView.bounds) - floor(itemW) * (num - 1);
            return CGSizeMake(floor(itemW), realWidth);
        }
    }else{
        
        GoodsCellLayout *layout = self.listArr2[indexPath.row];
        return CGSizeMake(layout.width,  layout.height);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeaderChildCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    view.sort = currentSort;
    MJWeakSelf
    view.sortBlock = ^(NSString * _Nonnull sort) {
        
        self->currentSort = sort;
        self->pageno = 1;
        [weakSelf loadTabData];
    };
    return view;
}


- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeMake(KScreenWidth, 45);
    if (section == 0) {
        
        return CGSizeZero;
    }
    return size;
}

#pragma mark - 滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;

    //根据偏移量，显示或隐藏返回顶部按钮
    if (offsetY > 150) {
        
        self.goTopBtn.hidden = NO;
    }else{
        
        self.goTopBtn.hidden = YES;
    }

    
}

//- (void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    
//    [HeaderList sharedInstance].recommendPage = NO;
//    NSDictionary *dic =@{
//                         @"color":@"F88222"
//                         };
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADSCROLL" object:nil userInfo:dic];
//}

@end
