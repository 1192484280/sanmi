//
//  FeedBackCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "FeedBackCell.h"
#import "MyFeedBackModel.h"
#import "FeedBackLayout.h"
#import "MerchandiseReChildCollectionCell.h"
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <Photos/Photos.h>
#import "ProductDetailViewController.h"
#import "GoodsModel.h"

@interface FeedBackCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *contentLa;
@property (nonatomic, strong) UILabel *timeLa;
@property (nonatomic, strong) UIView *imgsView;

@property (nonatomic, strong) UILabel *huifuTitleLa;
@property (nonatomic, strong) UILabel *huifuContentLa;
@property (nonatomic, strong) UILabel *huifuTimeLa;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *imgArr;

@property (nonatomic, strong) FeedBackLayout *layout;

@end

@implementation FeedBackCell

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 28 - 20) / 3;
            CGFloat itemH = itemW;
            layout.itemSize = CGSizeMake(itemW, itemH);
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[MerchandiseReChildCollectionCell class] forCellWithReuseIdentifier:@"CELL"];
        }
        return _collectionView;
    }
    return _collectionView;
}

- (UIView *)imgsView{
    
    if (!_imgsView) {
        
        _imgsView = [[UIView alloc] init];
        //        _imgsView.backgroundColor = UIColor.redColor;
        [_imgsView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _imgsView;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont systemFontOfSize:14];
        _titleLa.textColor = FontColor;
    }
    return _titleLa;
}

- (UILabel *)contentLa{
    
    if (!_contentLa) {
        
        _contentLa = [[UILabel alloc] init];
        _contentLa.font = [UIFont systemFontOfSize:14];
        _contentLa.textColor = FontColor;
        _contentLa.numberOfLines = 0;
    }
    return _contentLa;
}

- (UILabel *)timeLa{
    
    if (!_timeLa) {
        
        _timeLa = [[UILabel alloc] init];
        _timeLa.textColor = UIColor.lightGrayColor;
        _timeLa.font = [UIFont fontWithName:FONTNAME size:12];
    }
    return _timeLa;
}

- (UILabel *)huifuTitleLa{
    
    if (!_huifuTitleLa) {
        
        _huifuTitleLa = [[UILabel alloc] init];
        _huifuTitleLa.font = [UIFont systemFontOfSize:14];
        _huifuTitleLa.text = @"回复意见：";
        _huifuTitleLa.textColor = FontColor;
    }
    return _huifuTitleLa;
}

- (UILabel *)huifuContentLa{
    
    if (!_huifuContentLa) {
        
        _huifuContentLa = [[UILabel alloc] init];
        _huifuContentLa.font = [UIFont systemFontOfSize:14];
        _huifuContentLa.textColor = FontColor;
    }
    return _huifuContentLa;
}

- (UILabel *)huifuTimeLa{
    
    if (!_huifuTimeLa) {
        
        _huifuTimeLa = [[UILabel alloc] init];
        _huifuTimeLa.textColor = UIColor.lightGrayColor;
        _huifuTimeLa.font = [UIFont fontWithName:FONTNAME size:12];
    }
    return _huifuTimeLa;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.titleLa];
        [self addSubview:self.timeLa];
        [self addSubview:self.contentLa];
        [self addSubview:self.imgsView];
        
         [self addSubview:self.huifuTitleLa];
         [self addSubview:self.huifuContentLa];
         [self addSubview:self.huifuTimeLa];
    }
    return self;
}

- (void)setLayout:(FeedBackLayout *)layout{
    
    _layout = layout;
    self.titleLa.frame = layout.titleRect;
    self.timeLa.frame = layout.timeRect;
    self.contentLa.frame = layout.contentRect;
    self.imgsView.frame = layout.imgsRect;
    
    self.huifuTitleLa.frame = layout.huifuTitleRect;
    self.huifuTimeLa.frame = layout.huifuTimeRect;
    self.huifuContentLa.frame = layout.huifuContentRect;
    
    dispatch_queue_t quent = dispatch_queue_create("com.quent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(quent, ^{
        
        NSAttributedString *attStr1 = [NSString getAttributedWithString:[NSString stringWithFormat:@"反馈内容：%@",layout.data.FeedbackContent] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:14] color:FontColor];
    
        NSAttributedString *attStr2 = [NSString getAttributedWithString:layout.data.ReplyContent WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:14] color:FontColor];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.contentLa.attributedText = attStr1;
            self.huifuContentLa.attributedText = attStr2;
        });
    });
    self.timeLa.text = [NSString stringWithFormat:@"反馈时间：%@",layout.data.FeedbackTime];
    self.titleLa.text = [NSString stringWithFormat:@"反馈类型：%@",layout.data.FeedbackTypeName];
    self.imgArr = layout.data.imgArr;
    self.huifuTimeLa.text = [NSString stringWithFormat:@"回复时间：%@",layout.data.ReplyTime];
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchandiseReChildCollectionCell *cell = (MerchandiseReChildCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.imgUrl =  self.imgArr[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    NSMutableArray *datas = [NSMutableArray array];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObjectsFromArray:self.imgArr];
    
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
            data.imageURL = obj.mj_url;
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
    browser.currentPage = indexPath.item;
    [browser show];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 保存图片
- (void)onDownBtn:(UIButton *)sender{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        
        // 如果状态是不确定的话,block中的内容会等到授权完成再调用
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            // 授权完成就会调用
            if (status == PHAuthorizationStatusAuthorized) {
                
                //调用存储图片的方法
                [self savePhoto];
                
            }
            
        }];
        
        //如果允许访问
        
    } else if (status == PHAuthorizationStatusAuthorized) {
        
        //调用存储图片的方法
        [self savePhoto];
        
        //如果权限是拒绝
        
    } else {
        
        // 使用第三方框架,弹出一个页面提示用户去打开授权
        // [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用->打开允许访问相册开关"];
        
    }
}

#pragma mark - 该方法获取在图库中是否已经创建该App的相册

//该方法的作用,获取系统中所有的相册,进行遍历,若是已有相册,返回该相册,若是没有返回nil,参数为需要创建  的相册名称
- (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle{
    
    // 获取所有的相册
    
    PHFetchResult *result = [PHAssetCollection           fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历相册数组,是否已创建该相册
    
    for (PHAssetCollection *assetCollection in result) {
        
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            
            return assetCollection;
            
        }
        
    }
    
    return nil;
    
}


#pragma mark - 保存图片的方法

- (void)savePhoto{
    
    if (self.layout.data.imgArr.count <= 0) {
        
        return [self makeToast:@"此商品没有图片" duration:2.0 position:CSToastPositionCenter];
    }
    //修改系统相册用PHPhotoLibrary单粒,调用performChanges,否则苹果会报错,并提醒你使用
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // 调用判断是否已有该名称相册
        PHAssetCollection *assetCollection = [self fetchAssetColletion: @"闪蜜"];
        
        //创建一个操作图库的对象
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        
        if (assetCollection) {
            
            // 已有相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            
            // 1.创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"闪蜜"];
        }
        
        // 2.保存你需要保存的图片到系统相册(这里保存的是_imageView上的图片)
        [SVProgressHUD show];
        for (NSString *imgUrl in self.imgArr) {
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *img = [UIImage imageWithData:data];
            
            PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
            PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
            
            [assetCollectionChangeRequest addAssets:@[placeholder]];
        }
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        //弹出一个界面提醒用户是否保存成功
        if (error) {
            
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        } else {
            
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
    }];
}


@end
