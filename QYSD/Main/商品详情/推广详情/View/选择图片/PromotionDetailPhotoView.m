//
//  PromotionDetailTopView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailPhotoView.h"
#import "PromotionDetailPhotoCell.h"
#import "PromotionDetailPhotoModel.h"
#import "PromotionDetailPhotoList.h"

#import "YBImageBrowser.h"
#import "YBIBVideoData.h"

@interface PromotionDetailPhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *selectedLa;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *listArr;

@end

@implementation PromotionDetailPhotoView

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<10; i ++) {
            PromotionDetailPhotoModel *model = [[PromotionDetailPhotoModel alloc] init];
            model.img = @"img_proPhoto";
            if (i == 0) {
                
                model.selected = YES;
                [[PromotionDetailPhotoList sharedInstance].selectedPhotoArr addObject:model];
            }
            [arr addObject:model];
        }
        _listArr = arr;
    }
    return _listArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 50) / 3;
            CGFloat itemH = 90;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"PromotionDetailPhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            [self addSubview:_collectionView];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.bottom.mas_equalTo(-10);
                make.top.equalTo(self.titleLa.mas_bottom).offset(10);
            }];
        }
        return _collectionView;
    }
    return _collectionView;
}

- (UILabel *)selectedLa{
    
    if (!_selectedLa) {
        
        _selectedLa = [[UILabel alloc] init];
        _selectedLa.text = @"已选择1张";
        _selectedLa.textColor = FontColor;
        _selectedLa.font = [UIFont systemFontOfSize:12];
    }
    return _selectedLa;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = @"选择图片";
        _titleLa.textColor = FontColor;
        _titleLa.font = [UIFont systemFontOfSize:15];
    }
    return _titleLa;
}

- (UIButton *)selectedBtn{
    
    if (!_selectedBtn) {
        
        _selectedBtn = [[UIButton alloc] init];
        [_selectedBtn setTitle:@"选择" forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"img_photonormalAll"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"img_photoSelectedAll"] forState:UIControlStateSelected];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_selectedBtn setTitleColor:FontColor forState:UIControlStateNormal];
        [_selectedBtn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}

- (void)onSelectBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        for (PromotionDetailPhotoModel *model in self.listArr) {
            model.selected = sender.selected;
        }
        [PromotionDetailPhotoList sharedInstance].selectedPhotoArr = [NSMutableArray arrayWithArray:self.listArr];
    }else{
        
        for (int i = 0; i < self.listArr.count; i ++) {
            
            PromotionDetailPhotoModel *model  = self.listArr[i];
            if (i != 0) {
                model.selected = sender.selected;
            }
        }
        
        [PromotionDetailPhotoList sharedInstance].selectedPhotoArr = [NSMutableArray arrayWithObject:self.listArr[0]];
    }
    
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = UIColor.redColor;
        
        [self addSubview:self.titleLa];
        [self addSubview:self.selectedLa];
        [self addSubview:self.selectedBtn];
        [self.collectionView reloadData];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(20);
        }];
        
        [self.selectedLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLa.mas_right).offset(20);
            make.centerY.equalTo(self.titleLa);

        }];
        
        [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self.titleLa);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
        }];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PromotionDetailPhotoModel *model = self.listArr[indexPath.row];
    PromotionDetailPhotoCell *cell = (PromotionDetailPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.index = indexPath.row;
    [cell setData:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (PromotionDetailPhotoModel *model in self.listArr) {
        
        [arr addObject:model.img];
    }
    NSMutableArray *datas = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            //            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        } else if ([obj hasSuffix:@".mp4"]) {
            
            // 本地视频
            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL fileURLWithPath:path];
            //            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            //            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            //            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = indexPath.row;
    [browser show];
}
@end
