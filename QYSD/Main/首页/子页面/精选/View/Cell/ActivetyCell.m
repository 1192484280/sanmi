//
//  ActivetyCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ActivetyCell.h"
#import "ActivetyImgCell.h"
#import "ActiveDetailModel.h"
#import "WKWebViewController.h"
#import "WkWebList.h"

@interface ActivetyCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *listArr;

@end

@implementation ActivetyCell

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            
            layout.minimumInteritemSpacing = 5;
            layout.minimumLineSpacing = 5;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[ActivetyImgCell class] forCellWithReuseIdentifier:@"CELL"];
            _collectionView.scrollEnabled = NO;
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
    
    ActiveDetailModel *model = self.listArr[indexPath.row];
    ActivetyImgCell *cell = (ActivetyImgCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];

    [cell.im sd_setImageWithURL:model.PicUrl.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    if (model.ActivityNum == 1) {
        
        cell.im.layer.cornerRadius = 10;
    }else{
        
        cell.im.layer.cornerRadius = 5;
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ActiveDetailModel *model = self.listArr[indexPath.row];
    
    CGFloat min_h = 0;
    CGFloat min_w = 0;
    
    if (model.ActivityNum == 1) {
        
        min_w = KScreenWidth - 20;
        min_h = min_w * 0.4;
    }else if (model.ActivityNum == 2){
        
        min_w = (KScreenWidth - 25)/2;
        min_h = min_w * 0.4;
    }else if (model.ActivityNum == 3){
        
        min_w = (KScreenWidth - 30)/3;
        min_h = min_w * 0.4;
    }else if (model.ActivityNum == 4){
        
        min_w = (KScreenWidth - 35)/4;
        min_h = min_w * 0.4;
    }
    
    return CGSizeMake(min_w, min_h);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ActiveDetailModel *model = self.listArr[indexPath.row];
    
    if (model.ActiveType == 1) {
        
        
    }else{
        
        [WkWebList sharedInstance].url = model.RedirectPath;
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        [webVC setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)setDataArr:(NSArray *)dataArr{
    
    self.listArr = dataArr;
    [self.collectionView reloadData];
}

@end
