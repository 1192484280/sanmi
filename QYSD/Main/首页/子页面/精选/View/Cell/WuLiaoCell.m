//
//  WuLiaoCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "WuLiaoCell.h"

#import "RecommendFourCell.h"
#import "OptimusmaterialViewController.h"
#import "HomejxwlModel.h"

@interface WuLiaoCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *listArr;

@end

@implementation WuLiaoCell

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            CGFloat fourType_w = KScreenWidth- 20;
            CGFloat fourType_scale = 0.6;
            CGFloat fourType_h = fourType_w * fourType_scale;
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (fourType_w - 0.5) / 2;
            CGFloat itemH = itemW * fourType_scale;
            layout.itemSize = CGSizeMake(itemW, itemH);
            //            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumInteritemSpacing = 0.5;
            layout.minimumLineSpacing = 0.5;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[RecommendFourCell class] forCellWithReuseIdentifier:@"CELL"];
            _collectionView.layer.cornerRadius = 5;
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BaseBackGroundColor;
        self.layer.cornerRadius = 5;
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomejxwlModel *model = self.listArr[indexPath.row];
    
    if (indexPath.row == 0) {
        
        model.colorStr = @"CDC3FF";
    }else if (indexPath.row == 1){
        
        model.colorStr = @"F7CF89";
    }else if (indexPath.row == 1){
        
        model.colorStr = @"F7C2BD";
    }else{
        
        model.colorStr = @"BCE6FC";
    }
    RecommendFourCell *cell = (RecommendFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomejxwlModel *model = self.listArr[indexPath.row];
    
    OptimusmaterialViewController *vc = [[OptimusmaterialViewController alloc] init];
    vc.jxwlModel = model;
    vc.title = model.NavigateName;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setDataArr:(NSArray *)dataArr{
    
    self.listArr = dataArr;
    [self.collectionView reloadData];
}

@end
