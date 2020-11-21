//
//  SearchAllNetViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchAllNetViewController.h"
//#import "HeaderChildCollectionCell.h"
#import "HeaderChildCollectionFlowLayout.h"
//#import "RecommendCollectionViewCell.h"
//#import "HeaderStore.h"
//#import "RecommendCellLayout.h"
#import "HeaderList.h"
 #import "SearchAllNetSortView.h"
#import "ProductDetailViewController.h"
#import "SearchResultSelectedView.h"
#import "SearchCouponsParamtersModel.h"
#import "HeaderSearchStore.h"
#import "GoodsCell.h"
#import "GoodsCellLayout.h"

@interface SearchAllNetViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    BOOL ifTabStyle;
}
@property (nonatomic, copy) NSArray *listArr;
@property (nonatomic, strong) NSMutableArray *listArr1;
@property (nonatomic, strong) NSMutableArray *listArr2;
@property (nonatomic, strong) UIButton *goTopBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SearchAllNetSortView *sortView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) SearchResultSelectedView *selectedView;

@property (nonatomic, strong) SearchCouponsParamtersModel *parametersModel;

@property (nonatomic, weak) JTImageButton *selctionBtn;

@end

@implementation SearchAllNetViewController

- (SearchResultSelectedView *)selectedView{
    
    if(!_selectedView){
        
        _selectedView = [[SearchResultSelectedView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
        MJWeakSelf
        _selectedView.sureBlock = ^(NSString * _Nonnull str1, NSString * _Nonnull str2) {

            weakSelf.parametersModel.startprice = str1;
            weakSelf.parametersModel.endprice = str2;
            [weakSelf didBgView];
            [weakSelf.collectionView.mj_header beginRefreshing];
        };
    }
    return _selectedView;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, KScreenHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgView)]];
    }
    
    return _bgView;
}

- (void)didBgView{
    
    self.selctionBtn.selected = NO;
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.view bringSubviewToFront:self.sortView];
        self.selectedView.top = 0;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
    }];
    
}

- (SearchAllNetSortView *)sortView{
    
    if (!_sortView) {
        
        _sortView = [[SearchAllNetSortView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 85)];
        MJWeakSelf
        _sortView.SortBlock = ^(NSString *str, JTImageButton *sender) {
            
            weakSelf.selctionBtn = sender;
            [weakSelf sortWithStr:str];
        };
        
        _sortView.SwitchBlock = ^(BOOL open) {
            
            NSString *has = @"1";
            if (!open) {
                has = @"0";
            }
            weakSelf.parametersModel.hasCoupon = has;
            [weakSelf.collectionView.mj_header beginRefreshing];
        };
    }
    return _sortView;
}

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
                
                weakSelf.parametersModel.pageno = 1;
                [weakSelf loadData];
            }];
            
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                
                self.parametersModel.pageno ++;
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
    
    [self initParameters];
    
    [self setUI];
    
    [self loadData];
    
    //接受用户点击搜索通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveSearchNoti:) name:@"SEARCHKEYWORD" object:nil];
}

- (void)initParameters{
    
    ifTabStyle = YES;
    
    self.parametersModel = [[SearchCouponsParamtersModel alloc] init];
    self.parametersModel.keyword = self.keyWord;
    self.parametersModel.identity = IDENTITY;
    self.parametersModel.pageno = 1;
    self.parametersModel.pagesize = 20;
    self.parametersModel.hasCoupon = @"0";
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reciveSearchNoti:(NSNotification *)noti{
    
    NSDictionary *dic = noti.userInfo;
    self.parametersModel.keyword = [dic objectForKey:@"keyWord"];
//    [self showFailMsg:[dic objectForKey:@"keyWord"]];
    
    [self.collectionView.mj_header beginRefreshing];
    
}

- (void)setUI{
    
    [self.view addSubview:self.selectedView];
    
    [self.view addSubview:self.sortView];
    
    [self.view insertSubview:self.collectionView atIndex:0];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.sortView.mas_bottom);
    }];
    
    [self.view addSubview:self.goTopBtn];
    [self.goTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-80);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - 刷新数据
- (void)loadData{
    
    MJWeakSelf
    [HeaderSearchStore getSearchCouponsWithParamter:self.parametersModel Success:^(NSArray *tabArr,NSArray *collectionArr) {
        
        if (self.parametersModel.pageno == 1) {
            
            weakSelf.listArr1 = [NSMutableArray arrayWithArray:collectionArr];
            weakSelf.listArr2 = [NSMutableArray arrayWithArray:tabArr];
        }else{
            
            [weakSelf.listArr1 addObjectsFromArray:collectionArr];
            [weakSelf.listArr2 addObjectsFromArray:tabArr];
        }
        
        self.listArr = self->ifTabStyle?weakSelf.listArr2:weakSelf.listArr1;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } Failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf showToastWithError:error ];
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


#pragma mark - 排序
- (void)sortWithStr:(NSString *)str{
    
    if ([str isEqualToString:@"cellStyleCollection"]) {
        
        ifTabStyle = NO;
        self.listArr = self.listArr1;
        [self.collectionView reloadData];
        return;
    }else if([str isEqualToString:@"cellStyleTable"]){
        
        ifTabStyle = YES;
        self.listArr = self.listArr2;
        [self.collectionView reloadData];
        return;
    }
    
    if ([str isEqualToString:@"打开筛选"]) {
        
        [self.view bringSubviewToFront:self.selectedView];
        [self.view insertSubview:self.bgView belowSubview:self.selectedView];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.selectedView.top = 45;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            
        } completion:nil];
        
        return;
    }else if ([str isEqualToString:@"关闭筛选"]){
        
        [self didBgView];
        return;
    }
    
    if ([str isEqualToString:@"综合"]) {
        
        self.parametersModel.sort = @"1";
        
    }else if ([str isEqualToString:@"销量"]){
        
        self.parametersModel.sort = @"2";
    }else if ([str isEqualToString:@"旗舰"]){
        
        self.parametersModel.sort = @"3";
    }
    
    [self.collectionView.mj_header beginRefreshing];
    
}
@end
