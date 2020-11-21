//
//  ExtraView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//  展示全部分类

#import "ExtraView.h"
#import "TypeCollectionViewCell.h"
#import "HomeNavigateModel.h"

@interface ExtraView ()

@property (nonatomic, copy) NSArray *listArr;

@end

@interface ExtraView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UIButton *extraBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ExtraView

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = KScreenWidth / 4;
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
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.attributedText = [NSString getAttributedWithString:@"请选择" WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:FontColor];
    }
    return _titleLa;
}
- (UIButton *)extraBtn{
    
    if (!_extraBtn) {
        
        _extraBtn = [[UIButton alloc] init];
        [_extraBtn setImage:[UIImage imageNamed:@"img_more_black"] forState:UIControlStateNormal];
        [_extraBtn addTarget:self action:@selector(onCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _extraBtn;
}

- (void)onCloseBtn{
    
    if (self.typeBlock) {
        
        self.typeBlock(1000);
    }
}

- (instancetype)initWithFrame:(CGRect)frame modelArr:(NSArray *)modelArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _listArr = modelArr;
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.titleLa];
        [self addSubview:self.extraBtn];
        [self addSubview:self.collectionView];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.height.mas_equalTo(20);
        }];
        
        [self.extraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(28);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.equalTo(self.titleLa.mas_bottom);
        }];
        
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
    
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = KScreenWidth / 4;
    return CGSizeMake(width,  width);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeNavigateModel *model = self.listArr[indexPath.item];
    
    TypeCollectionViewCell *cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    [cell.im sd_setImageWithURL:model.PicURL.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    cell.la.attributedText = [NSString getAttributedWithString:model.NavigateName WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:13] color:FontColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.typeBlock) {
        
        self.typeBlock(indexPath.row);
    }
}
@end
