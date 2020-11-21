//
//  RecommendStoreTypeView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/7.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendFestivalView.h"
#import "RecommendFestivalCell.h"

@interface RecommendFestivalView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *topIm;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *imgArr;
@end

@implementation RecommendFestivalView

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@[@"img_festivalStore_01",@"img_festivalStore_02",@"img_festivalStore_03",@"img_festivalStore_04"],@[@"img_festivalStore_05",@"img_festivalStore_06",@"img_festivalStore_07",@"img_festivalStore_08"]];
    }
    return _imgArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 5;
            layout.minimumInteritemSpacing = 5;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[RecommendFestivalCell class] forCellWithReuseIdentifier:@"CELL"];
           
        }
        return _collectionView;
    }
    return _collectionView;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithHexString:@"F2DFBD"];
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}

- (UIImageView *)topIm{
    
    if (!_topIm) {
        
        _topIm = [[UIImageView alloc] init];
        _topIm.image = [UIImage imageNamed:@"img_festivalTopIm"];
    }
    return _topIm;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        self.layer.cornerRadius = 10;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{

    [self addSubview:self.bgView];
    [self addSubview:self.topIm];
    [self.bgView addSubview:self.collectionView];

    CGFloat festivalTopIm_w = KScreenWidth- 20;
    CGFloat festivalTopIm_scale = 0.28;
    CGFloat festivalTopIm_h = festivalTopIm_w * festivalTopIm_scale;
    
    [self.topIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(festivalTopIm_h);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.topIm.mas_bottom).offset(-5);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat festivalCell1_w = (KScreenWidth- 20 - 20 - 5)/2;
    CGFloat festivalCell1_scale = 0.4;
    CGFloat festivalCell1_h = festivalCell1_w * festivalCell1_scale;
    
    CGFloat festivalCell2_w = (KScreenWidth- 20 - 20 - 5 * 3)/4;
    CGFloat festivalCell2_scale = 1.2;
    CGFloat festivalCell2_h = festivalCell2_w * festivalCell2_scale;
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(festivalCell1_w, festivalCell1_h);
    }
    return CGSizeMake(festivalCell2_w, festivalCell2_h);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.imgArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *arr = self.imgArr[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendFestivalCell *cell = (RecommendFestivalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.img = self.imgArr[indexPath.section][indexPath.row];
    return cell;
}
@end
