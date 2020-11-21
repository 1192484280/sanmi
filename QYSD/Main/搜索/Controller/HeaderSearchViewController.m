//
//  HeaderSearchViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchViewController.h"
#import "HeaderSearchNavView.h"
#import "HeaderSearchStore.h"
#import "HeaderSearchHotCellLayout.h"
#import "HotModel.h"
#import "HeaderSearchCollectionViewCell.h"
#import "HeaderSearchCollectionReusableView.h"
#import "BGFMDB.h"
#import "SearchResultViewController.h"
 #import "ZQSearchNormalLayout.h"

#define bg_tablename @"HISTORYTAB"
@interface HeaderSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) HeaderSearchNavView *navView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *hotArr;
@property (nonatomic , strong) NSArray  *historyArr;      //搜索历史
@end

@implementation HeaderSearchViewController

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            ZQSearchNormalLayout *layout = [[ZQSearchNormalLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(0, 14, 10, 50);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
//
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = BaseBackGroundColor;
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[HeaderSearchCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
            [_collectionView registerClass:[HeaderSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
            [self.view addSubview:_collectionView];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.navView.mas_bottom);
                make.left.right.bottom.mas_equalTo(0);
            }];
        }
        return _collectionView;
    }
    return _collectionView;
}

- (HeaderSearchNavView *)navView{
    
    if (!_navView) {
        
        CGFloat height = iPhoneX_Top + 10 + 10 + 15 + 10 + 60 + 5;
        _navView = [[HeaderSearchNavView alloc] init];
        _navView.frame = CGRectMake(0, 0, KScreenWidth, height);
        
        MJWeakSelf
        _navView.searchBlock = ^(NSString * _Nonnull keyWord) {
        
            [weakSelf insertHistoryKeyWord:keyWord];
            
            SearchResultViewController *vc = [[SearchResultViewController alloc] init];
            vc.keyWord = keyWord;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _navView;
}

- (void)insertHistoryKeyWord:(NSString *)keyWord{
    
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"title"),bg_sqlValue(keyWord)];
    NSArray* arr = [HotModel bg_find:bg_tablename where:where];
    if (arr.count <= 0) {
        
        HotModel *model = [[HotModel alloc] init];
        model.bg_tableName = bg_tablename;
        model.HotKey = keyWord;
        [model bg_save];
        [self loadHistoryData];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.navView];

    [self loadData];

    [self loadHistoryData];
}

- (void)loadData{
    
    MJWeakSelf
    [HeaderSearchStore getHotSearchListSuccess:^(NSArray * _Nonnull hotSearchArr) {
        
        weakSelf.hotArr = hotSearchArr;
        [weakSelf.collectionView reloadData];
    } Failure:^(NSError * _Nonnull error) {
        
        [weakSelf showToastWithError:error];
    }];
}

- (void)loadHistoryData{
    
    NSArray* finfAlls = [HotModel bg_findAll:bg_tablename];
    NSMutableArray *arr = [NSMutableArray array];
    for (HotModel *model in finfAlls) {
        
        HeaderSearchHotCellLayout *layout = [[HeaderSearchHotCellLayout alloc] initWithData:model];
        [arr addObject:layout];
    }
    self.historyArr = [[arr reverseObjectEnumerator] allObjects];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger row = 0;
    if (self.hotArr.count > 0) {

        row += 1;
    }

    if (self.historyArr.count > 0) {

        row += 1;
    }
    return row;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.hotArr.count;
    }
    return self.historyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeaderSearchHotCellLayout *layout = [[HeaderSearchHotCellLayout alloc] init];
    if (indexPath.section == 0) {

        layout = self.hotArr[indexPath.row];
    }else{

        layout = self.historyArr[indexPath.row];
    }
    
    HeaderSearchCollectionViewCell *cell = (HeaderSearchCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath ];
    [cell setLayout:layout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeaderSearchHotCellLayout *layout = self.hotArr[indexPath.row];
    if (indexPath.section == 1) {
        
        layout= self.historyArr[indexPath.row];
    }
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.keyWord = layout.data.HotKey;
    [self.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeaderSearchHotCellLayout *layout = [[HeaderSearchHotCellLayout alloc] init];
    if (indexPath.section == 0) {

        layout = self.hotArr[indexPath.row];
        return layout.cellSize;
    }else{

        layout = self.historyArr[indexPath.row];
        return layout.cellSize;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    HeaderSearchCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    MJWeakSelf
    view.cleanBlock = ^{
        
        [HotModel bg_clear:bg_tablename];
        [weakSelf loadHistoryData];
    };
    view.title = @"热门搜索";
    view.cleanBtn.hidden = YES;
    if (indexPath.section == 1) {
        
        view.title = @"搜索历史";
        view.cleanBtn.hidden = NO;
    }
    
    return view;
}


- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    CGSize size = CGSizeMake(KScreenWidth, 35);
    return size;
}

@end
