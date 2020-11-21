//
//  PromotionDetailCopywritingView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailCopywritingView.h"
#import "PromotionDetailCopywritingCell.h"

@interface PromotionDetailCopywritingView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *listArr;

@end

@implementation PromotionDetailCopywritingView

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = @[@"商品】【奥克斯】手持挂烫机小型电熨斗\n【密券】30元\n【在售价】89.00元\n【券后价】59.00元\n【优惠地址】http://t.cn/Ai8R9fC9\n-------------\n【小编推荐】大牌奥克斯！平烫挂烫二合一，强劲蒸汽，快速抚平褶皱，衣服不再皱巴巴！小巧好收纳，旅行也能带上！【赠运费险】\n【长按图片识别二维码查看详情】\n【下单方式】长按复制这条信息,打开手机淘宝,领券并下单",@"😏【券后价】59.00元🐬\n大牌奥克斯！平烫挂烫二合一🍏\n 强劲蒸汽🍆\n 快速抚平褶皱🍒\n衣服不再皱巴巴！小巧好收纳🍅\n旅行也能带上！【赠运费险】😋"];
    }
    return _listArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 20);
            CGFloat itemH = 242;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.pagingEnabled = YES;
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"PromotionDetailCopywritingCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            [self addSubview:_collectionView];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        
        }
        return _collectionView;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.collectionView reloadData];
        
    }
    return self;
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    CGFloat contentX = targetContentOffset->x;
    float pageFloat = contentX/(KScreenWidth - 20);
    NSInteger page = (int)round(pageFloat);
    
    if (self.scrollViewEndBlock) {
        
        self.scrollViewEndBlock(page);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PromotionDetailCopywritingCell *cell = (PromotionDetailCopywritingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.tf.text = self.listArr[indexPath.row];
    if (indexPath.row == 1) {
        
        cell.reduceBtn.hidden = YES;
    }
    return cell;
}
@end
