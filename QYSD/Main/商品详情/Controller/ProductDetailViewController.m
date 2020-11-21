//
//  ProductViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductTableHeaderView.h"
#import "ProductHeaderView.h"
#import "HeaderStore.h"
#import "GoodsCellLayout.h"
#import "GoodsCell.h"
#import "ProductCollectionReusableView.h"
#import "ProductTopBtnView.h"
#import "ProductBottomBar.h"
#import <WebKit/WebKit.h>

#import "ProductDetailStore.h"
#import "GoodsModel.h"
#import "SDImageCache.h"

#import "ProductImgCell.h"
#import "ProductTopCell.h"
#import "ProductInfoLayout.h"
#import "ProductDetailModel.h"
#import "CollectorStore.h"
#import "FootPrintStore.h"

@interface ProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL ifTopPage;
}
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *myProgressView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ProductTableHeaderView *tableHeaderView;
@property (nonatomic, strong) ProductHeaderView *navView;
@property (nonatomic, strong) ProductTopBtnView *topBtnView;
@property (nonatomic, copy) NSArray *collectArr;
@property (nonatomic, strong) ProductBottomBar *bottomBarView;

@property (nonatomic, copy) NSArray *imgArr;
@property (nonatomic, strong) ProductInfoLayout *detailLayout;

@end

@implementation ProductDetailViewController

- (ProductBottomBar *)bottomBarView{
    
    if (!_bottomBarView) {
        
        _bottomBarView = [[ProductBottomBar alloc] init];
    }
    return _bottomBarView;
}

- (ProductTopBtnView *)topBtnView{

    if (!_topBtnView) {

        _topBtnView = [[ProductTopBtnView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top)];
    }
    return _topBtnView;
}
- (ProductHeaderView *)navView{
    
    if (!_navView) {
        
        _navView = [[ProductHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top)];
        _navView.alpha = 0;
        
        MJWeakSelf
        
        //点击宝贝
        _navView.onBaoBeiBtnBlock = ^{
            
            self->ifTopPage = YES;
            weakSelf.navView.alpha = 0;
            weakSelf.topBtnView.hidden = NO;
            [weakSelf.bgScrollView scrollToTopAnimated:YES];
        };
        
        //点击详情
        _navView.onXiangQingBtnBlock = ^{
            
            self->ifTopPage = NO;
            weakSelf.navView.alpha = 1;
            [weakSelf.bgScrollView setContentOffset:CGPointMake(0, KScreenHeight) animated:YES];
        };
        
        //点击推荐
        _navView.onTuiJianBtnBlock = ^{
            
            self->ifTopPage = NO;
            weakSelf.navView.alpha = 1;
            [weakSelf.bgScrollView setContentOffset:CGPointMake(0, KScreenHeight * 2) animated:YES];
        };
    }
    return _navView;
}

-(UIScrollView *)bgScrollView
{
    if (_bgScrollView == nil)
    {
        _bgScrollView = [[UIScrollView alloc]init];
        _bgScrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight * 3);
        //设置分页效果
        _bgScrollView.pagingEnabled = YES;
        //禁用滚动
        _bgScrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _bgScrollView;
}


////allWebsiteDataTypes清除所有缓存
//- (void)deleteWebCache {
//
//    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
//
//    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//
//    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//        
//    }];
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    
//    [super viewDidDisappear:animated];
//    
//    [self deleteWebCache];
//}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ([SMUserGuid isValid]){
         [self addFooter];
    }
}

#pragma mark - 添加足迹
- (void)addFooter{
    
    [FootPrintStore addBrowseproductUserguid:SMUserGuid identity:SMIdentity itemid:self.goodsModel.ItemId title:self.goodsModel.Title Success:^{
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavBarWithTitle:@"商品详情"];

    ifTopPage = YES;
    [self.view addSubview:self.bgScrollView];
    
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
//        make.bottom.equalTo(self.bottomBarView.mas_top);
    }];
    
    [self.bgScrollView addSubview:self.tableView];
    [self.bgScrollView addSubview:self.webView];
    [self.bgScrollView addSubview:self.collectionView];
    [self.view addSubview:self.myProgressView];
    [self loadData];
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.topBtnView];
    [self.view addSubview:self.bottomBarView];
    
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(TAB_BAR_HEIGHT);
    }];

}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//}


#pragma mark - 宝贝
- (ProductTableHeaderView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        CGFloat headerHeight =  KScreenWidth;
        _tableHeaderView = [[ProductTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, headerHeight)];
        
    }
    return _tableHeaderView;
}

-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.tableHeaderView;
        
        MJWeakSelf
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self->ifTopPage = NO;
                self.topBtnView.hidden = YES;
                [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
                [weakSelf.navView.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [weakSelf.navView.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                weakSelf.bgScrollView.contentOffset = CGPointMake(0, KScreenHeight);
            } completion:^(BOOL finished) {
                //结束加载
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
        }];
        
        [footer setTitle:@"上拉查看图文详情" forState:MJRefreshStateIdle];
        [footer setTitle:@"上拉查看图文详情" forState:MJRefreshStatePulling];
        [footer setTitle:@"上拉查看图文详情" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"上拉查看图文详情" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"上拉查看图文详情" forState:MJRefreshStateNoMoreData];
        
        footer.arrowView.image = nil;
        _tableView.mj_footer = footer;
        
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if ([tableView isEqual:self.tableView]) {
//
//        return 1;
//    }
//    return self.imgArr.count;
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.detailLayout.height;
//    if ([tableView isEqual:self.tableView]) {
//
//        return self.detailLayout.height;
//    }
//
//    UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.imgArr[indexPath.row]];
//    if (!img) {
//        img =  [UIImage imageNamed:@"img_placeImg"];
//    }
//    CGFloat height = img.size.height;
//    return (height/img.size.width)*KScreenWidth;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ProductTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        
        cell = [[ProductTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    [cell setLayout:self.detailLayout];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
//    if ([tableView isEqual:self.tableView]) {
//
//        ProductTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
//        if (!cell) {
//
//            cell = [[ProductTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
//        }
//        [cell setLayout:self.detailLayout];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//
//    ProductImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL2"];
//    if (!cell) {
//
//        cell = [[ProductImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL2"];
//    }
//    [cell.im sd_setImageWithURL:self.imgArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
}

#pragma mark - 详情
- (UIProgressView *)myProgressView {
    
    if (_myProgressView == nil) {
        
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
        _myProgressView.tintColor = SMOrangeColor;
        _myProgressView.trackTintColor = BaseBackGroundColor;
        
    }
    
    return _myProgressView;
    
}

- (WKWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KScreenHeight + iPhoneX_Top, KScreenWidth, KScreenHeight - iPhoneX_Top - TAB_BAR_HEIGHT)];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//        _tableView2.delegate = self;
//        _tableView2.dataSource = self;
//        _tableView2.pagingEnabled = YES;
//        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
//        _tableView2.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
       
        MJWeakSelf
        //设置WKWebView 有下拉操作
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->ifTopPage = YES;
//            self.topBtnView.hidden = NO;
            [weakSelf.navView.baobeiBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
            [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [weakSelf.navView.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

            //下拉执行对应的操作
            [weakSelf.bgScrollView scrollToTopAnimated:YES];
            //结束加载
            [weakSelf.webView.scrollView.mj_header endRefreshing];
        }];
        header.stateLabel.font = [UIFont systemFontOfSize:15];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.arrowView.image = nil;
        [header setTitle:@"上拉返回宝贝" forState:MJRefreshStateIdle];
        [header setTitle:@"松开立即返回宝贝" forState:MJRefreshStatePulling];

        self.webView.scrollView.mj_header = header;

        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{

                [weakSelf.navView.tuijianBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
                [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [weakSelf.navView.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [self.bgScrollView scrollToBottomAnimated:YES];
//                self.bgScrollView.contentOffset = CGPointMake(0, KScreenHeight * 2);
            } completion:^(BOOL finished) {
                //结束加载
                [self.webView.scrollView.mj_footer endRefreshing];
            }];
        }];

        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateIdle];
        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStatePulling];
        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateNoMoreData];

        footer.arrowView.image = nil;
        self.webView.scrollView.mj_footer = footer;
    }
    return _webView;
}
- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - 观察者-进度条，标题
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.myProgressView.alpha = 0.0f;
                
            } completion:^(BOOL finished) {
                
                [self.myProgressView setProgress:0 animated:NO];
                
            }];
            
        }
        
    }
}


//-(WKWebView *)webView
//{
//    if (_webView == nil)
//    {
//        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, KScreenHeight + iPhoneX_Top, KScreenWidth, KScreenHeight - iPhoneX_Top - TAB_BAR_HEIGHT)];
//        NSString *url = @"http://www.qytimes.cn";
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//        [_webView loadRequest:request];
//
//        MJWeakSelf
//        //设置WKWebView 有下拉操作
//        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            self->ifTopPage = YES;
////            self.topBtnView.hidden = NO;
//            [weakSelf.navView.baobeiBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
//            [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//            [weakSelf.navView.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//
//            //下拉执行对应的操作
//            [weakSelf.bgScrollView scrollToTopAnimated:YES];
//            //结束加载
//            [weakSelf.webView.scrollView.mj_header endRefreshing];
//        }];
//        header.stateLabel.font = [UIFont systemFontOfSize:15];
//        header.lastUpdatedTimeLabel.hidden = YES;
//        header.arrowView.image = nil;
//        [header setTitle:@"上拉返回宝贝" forState:MJRefreshStateIdle];
//        [header setTitle:@"松开立即返回宝贝" forState:MJRefreshStatePulling];
//
//        _webView.scrollView.mj_header = header;
//
//        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//
//                [weakSelf.navView.tuijianBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
//                [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//                [weakSelf.navView.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//                [self.bgScrollView scrollToBottomAnimated:YES];
////                self.bgScrollView.contentOffset = CGPointMake(0, KScreenHeight * 2);
//            } completion:^(BOOL finished) {
//                //结束加载
//                [self.webView.scrollView.mj_footer endRefreshing];
//            }];
//        }];
//
//        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateIdle];
//        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStatePulling];
//        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateRefreshing];
//        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateWillRefresh];
//        [footer setTitle:@"上拉查看推荐" forState:MJRefreshStateNoMoreData];
//
//        footer.arrowView.image = nil;
//        _webView.scrollView.mj_footer = footer;
//    }
//    return _webView;
//}

#pragma mark - 推荐
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(0, 10, 8, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KScreenHeight * 2 + iPhoneX_Top, KScreenWidth, KScreenHeight - iPhoneX_Top - TAB_BAR_HEIGHT) collectionViewLayout:layout];
            _collectionView.backgroundColor = BaseBackGroundColor;
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            _collectionView.emptyDataSetSource = self;
            _collectionView.emptyDataSetDelegate = self;
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"CELL"];
            [_collectionView registerClass:[ProductCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
            
            MJWeakSelf
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                
                [weakSelf.navView.xiangqingBtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
                [weakSelf.navView.baobeiBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [weakSelf.navView.tuijianBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                
                //        下拉执行对应的操作
                [self.bgScrollView scrollRectToVisible:CGRectMake(0, KScreenHeight, KScreenWidth, KScreenHeight) animated:YES];
                //结束加载
                [self.collectionView.mj_header endRefreshing];
            }];
            
            header.stateLabel.font = [UIFont systemFontOfSize:15];
            header.lastUpdatedTimeLabel.hidden = YES;
            header.arrowView.image = nil;
            [header setTitle:@"上拉返回详情" forState:MJRefreshStateIdle];
            [header setTitle:@"松开立即返回详情" forState:MJRefreshStatePulling];
            _collectionView.mj_header = header;
            
            if (@available(iOS 11.0, *)) {
                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }else {
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
        return _collectionView;
    }
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.collectArr[indexPath.row];
    GoodsCell *cell = (GoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setLayout:layout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.collectArr[indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.goodsModel = layout.data;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCellLayout *layout = self.collectArr[indexPath.row];
    return CGSizeMake(layout.width,  layout.height);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    ProductCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    return view;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(KScreenWidth, 40);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (ifTopPage) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat alpha = offsetY / 100;
        
        self.navView.alpha = alpha;
        if (alpha > 0) {
            
            self.topBtnView.hidden = YES;
        }else{
            
            self.topBtnView.hidden = NO;
        }
    }else{
        
        self.navView.alpha = 1;
        self.topBtnView.hidden = YES;
    }
}

#pragma mark - 刷新数据
- (void)loadData{
    
    MJWeakSelf
    ProductDetailStore *store = [[ProductDetailStore alloc] init];
    
    ProductDetailModel *productModel = [[ProductDetailModel alloc] init];
    [ProductDetailStore getProductDetailWithIdentity:IDENTITY itmeid:self.goodsModel.ItemId title:self.goodsModel.Title Success:^(ProductDetailModel *detailModel) {
        
        weakSelf.tableHeaderView.detailModel = detailModel;
        
        productModel.ItemId = detailModel.ItemId;
        productModel.PictUrl = detailModel.PictUrl;
        productModel.Title = detailModel.Title;
        productModel.CouponAmount = detailModel.CouponAmount;
        productModel.Volume = detailModel.Volume;
        productModel.ZkFinalPrice = detailModel.ZkFinalPrice;
        productModel.UserType = detailModel.UserType;
        productModel.SellerId = detailModel.SellerId;
        productModel.ShopTitle = detailModel.ShopTitle;
        productModel.PlatFormBonus = detailModel.PlatFormBonus;
        productModel.CommissionRate = detailModel.CommissionRate;
        productModel.CouponStartTime = detailModel.CouponStartTime;
        productModel.CouponEndTime = detailModel.CouponEndTime;
        productModel.CouponShareUrl = detailModel.CouponShareUrl;
        productModel.ItemDescription = detailModel.ItemDescription;
        
        productModel.baobeimiaoshu = [self getRanScore];
        productModel.maijiafuwu = [self getRanScore];
        productModel.wuliufuwu = [self getRanScore];
        
        [self.bottomBarView setProductModel:detailModel];
        
        self.detailLayout = [[ProductInfoLayout alloc] initWithData:productModel];
        [weakSelf.tableView reloadData];
        
    } Failure:^(NSError *error) {
    }];
//    ProductDetailStore *store = [[ProductDetailStore alloc] init];
//
//    dispatch_queue_t queue = dispatch_queue_create("com.task.gcd", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_enter(group);
//    //获取商品详细信息
//    [ProductDetailStore getProductDetailWithIdentity:IDENTITY itmeid:self.goodsModel.ItemId title:self.goodsModel.Title Success:^(ProductDetailModel *detailModel) {
//
//        weakSelf.tableHeaderView.detailModel = detailModel;
//
//        productModel.ItemId = detailModel.ItemId;
//        productModel.PictUrl = detailModel.PictUrl;
//        productModel.Title = detailModel.Title;
//        productModel.CouponAmount = detailModel.CouponAmount;
//        productModel.Volume = detailModel.Volume;
//        productModel.ZkFinalPrice = detailModel.ZkFinalPrice;
//        productModel.UserType = detailModel.UserType;
//        productModel.SellerId = detailModel.SellerId;
//        productModel.ShopTitle = detailModel.ShopTitle;
//        productModel.PlatFormBonus = detailModel.PlatFormBonus;
//        productModel.CommissionRate = detailModel.CommissionRate;
//        productModel.CouponStartTime = detailModel.CouponStartTime;
//        productModel.CouponEndTime = detailModel.CouponEndTime;
//        productModel.CouponShareUrl = detailModel.CouponShareUrl;
//        productModel.ItemDescription = detailModel.ItemDescription;
//
//        [self.bottomBarView setProductModel:detailModel];
//
//        dispatch_group_leave(group);
//
//    } Failure:^(NSError *error) {
//        dispatch_group_leave(group);
//    }];
//
//    dispatch_group_enter(group);
//    //商品店铺评价、用户评论数据
//    [store getProductOtherInfoWothItemNumId:self.goodsModel.ItemId Success:^(NSString *baobeiScore, NSString *maijiaServiceScore, NSString *wuliuScore, NSString *commentCount, NSString *commentUserName, NSString *commentUserIcon, NSString *commentContent) {
//
//        productModel.baobeimiaoshu = baobeiScore;
//        productModel.maijiafuwu = maijiaServiceScore;
//        productModel.wuliufuwu = wuliuScore;
//        productModel.baobeicomment = commentCount;
//        productModel.commentName = commentUserName;
//        productModel.commentIcon = commentUserIcon;
//        productModel.commentDes = commentContent;
//
//        dispatch_group_leave(group);
//    } Failure:^(NSError *error) {
//        dispatch_group_leave(group);
//    }];
//
//    dispatch_group_notify(group, queue, ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            self.detailLayout = [[ProductInfoLayout alloc] initWithData:productModel];
//            [weakSelf.tableView reloadData];
//        });
//    });
    
    
    //获取商品推荐
    [ProductDetailStore getProductRecommendWithIdentity:IDENTITY itemid:self.goodsModel.ItemId title:self.goodsModel.Title count:20 Success:^(NSArray *collectionArr) {
        weakSelf.collectArr = collectionArr;
        [weakSelf.collectionView reloadData];
        
    } Failure:^(NSError *error) {
    }];
    
    
    
    //商品详情图片集合
    [store getProductPicsWothItemNumId:self.goodsModel.ItemId Success:^(NSString *htmlStr) {
        
        [weakSelf.webView loadHTMLString:htmlStr baseURL:nil];
//        weakSelf.imgArr = imgsArr;
//        [weakSelf.tableView2 reloadData];
        
    } Failure:^(NSError *error) {
        
    }];
    
    //获取商品是否已收藏
    if ([SMUserGuid isValid]) {
        
        [CollectorStore judgeGoodsIfCollectorWithUserguid:SMUserGuid identity:SMIdentity itemid:self.goodsModel.ItemId Success:^(BOOL hadCollector) {
            
            weakSelf.bottomBarView.collectorBtn.selected = hadCollector;
        } Failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark - 获取随机评分
- (NSString *)getRanScore{
    
    BOOL run = YES;
    float r = 4.8;
    while (run) {
        
        r = (float)(arc4random()%100) / 100 + 4.0;
        
        if (r>=4.6 && r<=5.0) {
            
            run = NO;
        }
    }
    return [NSString stringWithFormat:@"%.1f",r];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    
    NSString *text = @"暂无推荐";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:FONTNAME size:14],
                                 NSForegroundColorAttributeName: UIColor.lightGrayColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
