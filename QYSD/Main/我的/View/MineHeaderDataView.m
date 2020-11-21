//
//  MineHeaderDataView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderDataView.h"
#import "ZJScrollPageView.h"
#import "MineHeaderDataCell.h"
#import "SMMoreDataViewController.h"
#import "MyTeamViewController.h"

@interface MineHeaderDataView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) JTImageButton *moreBtn;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *numArr;

@end

@implementation MineHeaderDataView

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"今日预估",@"今日粉丝",@"本月预估"];
    }
    return _titleArr;
}

- (NSArray *)numArr{
    
    if (!_numArr) {
        
        _numArr = @[@"¥ 0.00",@"0",@"¥ 0.00"];
    }
    return _numArr;
}
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 20) / 3;
            CGFloat itemH = 50;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[MineHeaderDataCell class] forCellWithReuseIdentifier:@"CELL"];
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (void)onTodayBtn1:(UIButton *)sender{
    
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = BaseBackGroundColor;
    }
    return _line;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont boldSystemFontOfSize:15];
        _titleLa.text  = @"收益数据";
    }
    return _titleLa;
}

- (JTImageButton *)moreBtn{
    
    if (!_moreBtn) {
        
        _moreBtn = [[JTImageButton alloc] init];
        [_moreBtn createTitle:@"更多数据" withIcon:[UIImage imageNamed:@"mine_dataMore"] font:[UIFont systemFontOfSize:12] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _moreBtn.borderWidth = 0.0;
        _moreBtn.titleColor = UIColor.grayColor;
        _moreBtn.iconSide = JTImageButtonIconSideRight;
        _moreBtn.padding = JTImageButtonPaddingMedium;
        [_moreBtn addTarget:self action:@selector(onMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreBtn;
}

- (void)onMoreBtn:(UIButton *)sender{
    
    SMMoreDataViewController *vc = [[SMMoreDataViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.titleLa];
        [self addSubview:self.moreBtn];
        [self setupSegmentView];
        [self addSubview:self.line];
        
        [self addSubview:self.collectionView];
        
        CGFloat margin = 10.0f;
        CGFloat space = 14.0f;
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(margin);
            make.height.mas_equalTo(20);
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-space);
            make.centerY.equalTo(self.titleLa);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(22);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.segmentView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.top.equalTo(self.line.mas_bottom);
        }];
    }
    return self;
}

- (void)setupSegmentView{
    
    NSArray *titles = @[
                        @"淘宝",
                        @"拼多多",
                        @"京东"
                        ];
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.adjustCoverOrLineWidth = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = [UIColor colorWithRGB:0xFA6400];
    style.normalTitleColor = [UIColor colorWithRGB:0x000000];
    style.selectedTitleColor = [UIColor colorWithRGB:0xFA6400];
    // 注意: 一定要避免循环引用!!
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 20, 35) segmentStyle:style delegate:nil titles:titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        
    }];
    
    segment.backgroundColor = [UIColor whiteColor];
    
    self.segmentView = segment;
    [self addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.titleLa.mas_bottom);
        make.height.mas_equalTo(35);
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 3;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineHeaderDataCell *cell = (MineHeaderDataCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.titleLa.attributedText = [NSString getAttributedWithString:self.titleArr[indexPath.row] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:14] color:FontColor];
    cell.numLa.attributedText = [NSString getAttributedWithString:self.numArr[indexPath.row] WithLineSpace:0 kern:0 font:[UIFont boldSystemFontOfSize:16] color:FontColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        MyTeamViewController *vc = [[MyTeamViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }else{
        
        SMMoreDataViewController *vc = [[SMMoreDataViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}
@end
