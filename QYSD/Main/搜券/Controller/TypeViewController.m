//
//  TypeViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TypeViewController.h"
#import "TypeTopView.h"
#import "TypeAnimaView.h"
#import "TypeCollectionViewCell.h"
#import "TypeCollectionReusableViewOneSection.h"
#import "TypeCollectionReusableViewTwoSection.h"
#import "TypeCellModel.h"
#import "TypeCollectionViewFlowLayout.h"
@interface TypeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) TypeTopView *topView;
@property (nonatomic, strong) TypeAnimaView *topBgView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation TypeViewController

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
        
        for (int i = 1; i < 20;  i++) {
            
            TypeCellModel *model = [[TypeCellModel alloc] init];
            model.name = @"name";
            model.img = [NSString stringWithFormat:@"img_pinpaiLogo_%d",i];
            [_listArr addObject:model];
        }
    }
    return _listArr;
}
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            TypeCollectionViewFlowLayout *layout = [[TypeCollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth) / 4;
            CGFloat itemH = itemW;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"TypeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            [_collectionView registerClass:[TypeCollectionReusableViewOneSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
            [_collectionView registerClass:[TypeCollectionReusableViewTwoSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header2"];
            [self.view addSubview:_collectionView];
            
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(0);
                make.top.equalTo(self.topView.mas_bottom);
            }];
        }
        return _collectionView;
    }
    return _collectionView;
}

- (TypeAnimaView *)topBgView{
    
    if (!_topBgView) {
        
        _topBgView = [[TypeAnimaView alloc] init];
    }
    return _topBgView;
}

- (TypeTopView *)topView{
 
    if (!_topView) {
        
        _topView = [[TypeTopView alloc] init];
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setUI];
    
    [self.collectionView reloadData];
}

- (void)setUI{
    
    [self.view addSubview:self.topView];
    self.topView.frame = CGRectMake(0, 0, KScreenWidth, 130);
    
    [self.view insertSubview:self.topBgView atIndex:0];
    self.topBgView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), KScreenWidth, KScreenWidth * 0.213);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.listArr.count % 4 == 0) {
        
        return self.listArr.count;
    }
    
    NSInteger a = 4 - self.listArr.count%4;
    for (int i = 0; i< a; i ++) {
        
        TypeCellModel *model = [[TypeCellModel alloc] init];
        [self.listArr addObject:model];
    }
    return self.listArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeCellModel *model = self.listArr[indexPath.row];
    TypeCollectionViewCell *cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    cell.im.image = [UIImage imageNamed:model.img];
    cell.la.text = model.name;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TypeCollectionReusableViewOneSection *sectionOneView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1" forIndexPath:indexPath];
        return sectionOneView;
    }
    
    TypeCollectionReusableViewTwoSection *sectionTwoView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header2" forIndexPath:indexPath];
    return sectionTwoView;
    
}


- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        CGSize size = CGSizeMake(KScreenWidth, (KScreenWidth - 28) * 0.32 + 20 +40 + 40);
        return size;
    }
    
    CGSize size = CGSizeMake(KScreenWidth, 10 + 40 + 40);
    return size;
   
}

#pragma mark - 滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    DLog(@"%f",self.topBgView.top);
    
    if (offsetY > 0) {
        
        self.topBgView.top = -offsetY + 130;
    }
    
}

#pragma mark - 解决iOS11下，滑块被header遮挡的问题
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    view.layer.zPosition = 0;
    
}


@end
