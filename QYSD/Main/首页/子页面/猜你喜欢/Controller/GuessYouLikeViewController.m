//
//  GuessYouLikeViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "GuessYouLikeViewController.h"
#import "HeaderChildCollectionFlowLayout.h"
#import "HeaderList.h"
#import "ProductDetailViewController.h"
#import "GoodsCell.h"
#import "GoodsCellLayout.h"
#import "GuessYouLikeStore.h"

@interface GuessYouLikeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger pageno;
}
@property (nonatomic, strong) NSMutableArray *listArr;
//@property (nonatomic, copy) NSArray *listArr2;
@property (nonatomic, strong) UIButton *goTopBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation GuessYouLikeViewController

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
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"CELL"];
            
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

- (void)viewDidLoad {
    [super viewDidLoad];
        
    pageno = 1;
    
    [self setUI];
    
    [self showLottie];

    [self loadData];
}

- (void)setUI{
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.goTopBtn];
    [self.goTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - 刷新数据
- (void)loadData{
    
    MJWeakSelf
    [GuessYouLikeStore getGuessLikeWithIdentity:IDENTITY Pageno:pageno Pagesize:PAGESIZE Success:^(NSArray *tabArr, NSArray *collectionArr) {
        
        if (self->pageno == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:collectionArr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:collectionArr];
        }
        
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        [weakSelf hidenLottie];
        
    } Failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf showToastWithError:error];
        
        [weakSelf hidenLottie];
    }];
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
    [self.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    return CGSizeMake(layout.width,  layout.height);
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
