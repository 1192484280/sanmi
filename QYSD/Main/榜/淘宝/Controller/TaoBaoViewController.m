//
//  TaoBaoViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TaoBaoViewController.h"
#import "TaoBaoHeaderView.h"
#import "ZJScrollPageView.h"
#import "ProductDetailViewController.h"
#import "HeaderStore.h"
#import "TaoBaoStore.h"
#import "HomeNavigateModel.h"
#import "GoodsCell.h"
#import "GoodsCellLayout.h"
#import "HeaderChildCollectionFlowLayout.h"

@interface TaoBaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger identity;
    NSInteger pageno;
    NSInteger listflag;
    NSString *navigateid;
}
@property (nonatomic, strong) TaoBaoHeaderView *headerView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *navModelArr;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TaoBaoViewController

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            HeaderChildCollectionFlowLayout *layout = [[HeaderChildCollectionFlowLayout alloc] init];
            
            layout.sectionInset = UIEdgeInsetsMake(8, 10, 8, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = BaseBackGroundColor;
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"CELL"];
            [self.view addSubview:_collectionView];
            MJWeakSelf
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.equalTo(weakSelf.segmentView.mas_bottom);
                make.bottom.mas_equalTo(0);
            }];

            _collectionView.mj_header = [QYRefreshHeader headerWithRefreshingBlock:^{
                
                self->pageno = 1;
                [weakSelf loadTabData];
            }];
            
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                
                self->pageno ++;
                [weakSelf loadTabData];
            }];
            
            _collectionView.mj_footer = footer;
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (TaoBaoHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[TaoBaoHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, KScreenWidth, 55);
        _headerView.btnOneTitle = @"两小时疯抢";
        _headerView.btnTwoTitle = @"全天榜单";
        MJWeakSelf
        _headerView.btnOneBlock = ^{
            
            self->listflag = 1;
            [weakSelf loadTabData];
        };
        
        _headerView.btnTwoBlock = ^{
            
            self->listflag = 2;
            [weakSelf loadTabData];
        };
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"实时榜单";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.headerView];
    
    [self setupSegmentView];
    
    [self setParametes];
    
    [self showLottie];
    
    [self loadData];
}

- (void)setParametes{
    
    identity = 1;
    pageno = 1;
    listflag = 1;
    
}
#pragma mark - 获取导航栏
- (void)loadData{
    
    MJWeakSelf
    [HeaderStore getHomeNavigateWithParentnavigateid:@"0" Success:^(NSArray *modelArr, NSArray *textArr) {
        
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:modelArr];
        for (HomeNavigateModel *model in modelArr) {
            
            if ([model.NavigateID isEqualToString:@"2"]) {
                
                [muArr removeObject:model];
                
            }
        }
        
        NSMutableArray *textArr1 = [NSMutableArray array];
        for (HomeNavigateModel *model in muArr) {
            
            [textArr1 addObject:model.NavigateName];
        }
        
        weakSelf.titles = textArr1;
        weakSelf.navModelArr = muArr;
        [weakSelf.segmentView reloadTitlesWithNewTitles:weakSelf.titles];
        
        HomeNavigateModel *model = muArr.firstObject;
        self->navigateid = model.NavigateID;
        [weakSelf loadTabData];
        
    } Failure:^(NSError *error) {
        
        [weakSelf hidenLottie];
    }];
}

- (void)loadTabData{

    MJWeakSelf
    [TaoBaoStore getProducthotlistWithIdentity:identity Pageno:pageno Pagesize:PAGESIZE listflag:listflag navigateid:navigateid Success:^(NSArray *tabArr) {
        
        if (self->pageno == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:tabArr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:tabArr];
        }
        
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        [weakSelf hidenLottie];
        
    } Failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf showToastWithError:error ];
        
        [weakSelf hidenLottie];
        
    }];
}
#pragma mark - 获取商品信息
- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //    style.titleMargin = 10;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = YES;
    style.showCover = YES;
    style.scrollLineColor = [UIColor colorWithRGB:0xFA6400];
    style.normalTitleColor = [UIColor colorWithRGB:0x000000];
    style.selectedTitleColor = [UIColor colorWithRGB:0xffffff];
    style.titleMargin = 5;
    style.coverCornerRadius = 12;
    style.coverHeight = 25;
    style.coverBackgroundColor = ThemColor;
    //    style.titleMargin = 35;
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headerView.frame) , KScreenWidth - 20, 45.0) segmentStyle:style delegate:nil titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        HomeNavigateModel *model = weakSelf.navModelArr[index];
        self->navigateid = model.NavigateID;
        [weakSelf loadTabData];
    }];
    segment.onlyOnePage = YES;
    // 自定义标题的样式
    segment.backgroundColor = [UIColor whiteColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    //    self.navigationItem.titleView = self.segmentView;
    [self.view addSubview:segment];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = BaseBackGroundColor;
    [segment addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    GoodsCell *cell = (GoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setLayout:layout andListflag:listflag];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.goodsModel = layout.data;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置每个item的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//行间距 也就是所谓的水平间距
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8, 10, 10, 10);
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.listArr[indexPath.row];
    return CGSizeMake(layout.width,  layout.height);
}
@end
