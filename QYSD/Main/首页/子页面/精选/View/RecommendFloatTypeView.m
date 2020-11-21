//
//  RecommendFloatTypeView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendFloatTypeView.h"
#import "RecommendFloatTypeCell.h"

@interface RecommendFloatTypeView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger selectedIndex;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RecommendFloatTypeView

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 80)/4;
            CGFloat itemH = 50;
            layout.itemSize = CGSizeMake(itemW, itemH);
//            layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumInteritemSpacing = 1;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[RecommendFloatTypeCell class] forCellWithReuseIdentifier:@"CELL"];
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        selectedIndex = 0;
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendFloatTypeCell *cell = (RecommendFloatTypeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.floatNameLa.textColor = UIColor.blackColor;
    cell.desLa.layer.cornerRadius = 0;
    cell.desLa.backgroundColor = UIColor.clearColor;
    cell.desLa.textColor = UIColor.lightGrayColor;
    
    if (indexPath.row == 0) {
        
        cell.line.hidden = YES;
    }else{
        
        cell.line.hidden = NO;
    }
    
    if (indexPath.row == selectedIndex) {
        [cell setSelectedWithIndex:selectedIndex];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedIndex = indexPath.row;
    [collectionView reloadData];
    
}
@end
