//
//  MerchandiseReChildCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MerchandiseReChildCell.h"
#import "MerchandiseModel.h"
#import "MerchandiseChildLayout.h"
#import "MerchandiseReChildCollectionCell.h"
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <Photos/Photos.h>
#import "ProductDetailViewController.h"
#import "GoodsModel.h"

@interface MerchandiseReChildCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *logoIm;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *timeLa;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *desLa;
@property (nonatomic, strong) UILabel *zfLa;
@property (nonatomic, strong) UIView *imgsView;
@property (nonatomic, strong) UILabel *copysStoreUrlLa;
@property (nonatomic, strong) UILabel *copysRaduceUrlLa;
@property (nonatomic, strong) UIButton *copysStoreUrlBtn;
@property (nonatomic, strong) UIButton *copysRaduceUrlBtn;
@property (nonatomic, strong) UIView *copysBgView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *imgArr;

@property (nonatomic, strong) MerchandiseChildLayout *layout;

@end

@implementation MerchandiseReChildCell

- (UIButton *)copysStoreUrlBtn{
    
    if (!_copysStoreUrlBtn) {
        
        _copysStoreUrlBtn = [[UIButton alloc] init];
        [_copysStoreUrlBtn setImage:[UIImage imageNamed:@"img_copyComment"] forState:UIControlStateNormal];
        [_copysStoreUrlBtn addTarget:self action:@selector(onCopyStoreUrlBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copysStoreUrlBtn;
}

- (void)onCopyStoreUrlBtn:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.imgArr.firstObject forKey:@"TKLIMG"];
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = [NSString stringWithFormat:@"【购买步骤】长按识别二维码—复制淘口令—点开手机【淘宝】领券下单   復→制此评论，%@，开启【淘宝】即可够买and%@and%@",self.layout.data.ProductTKL,self.layout.data.ItemId,self.layout.data.Title];
    [self.viewController.view makeToast:@"复制成功" duration:1.0 position:CSToastPositionCenter];
}

- (UIButton *)copysRaduceUrlBtn{
    
    if (!_copysRaduceUrlBtn) {
        
        _copysRaduceUrlBtn = [[UIButton alloc] init];
        [_copysRaduceUrlBtn setImage:[UIImage imageNamed:@"img_copyComment"] forState:UIControlStateNormal];
        [_copysRaduceUrlBtn addTarget:self action:@selector(onCopyRaduceUrlBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copysRaduceUrlBtn;
}

- (void)onCopyRaduceUrlBtn:(UIButton *)sender{
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.layout.data.ProductTKL;
    [self.viewController.view makeToast:@"复制成功" duration:1.0 position:CSToastPositionCenter];
}

- (UIView *)copysBgView{
    
    if (!_copysBgView) {
        
        _copysBgView = [[UIView alloc] init];
        _copysBgView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    }
    return _copysBgView;
}

- (UILabel *)copysStoreUrlLa{
    
    if (!_copysStoreUrlLa) {
        
        _copysStoreUrlLa = [[UILabel alloc] init];
        _copysStoreUrlLa.numberOfLines = 0;
        _copysStoreUrlLa.textColor = UIColor.grayColor;
        _copysStoreUrlLa.font = [UIFont systemFontOfSize:15];
    }
    return _copysStoreUrlLa;
}

- (UILabel *)copysRaduceUrlLa{
    
    if (!_copysRaduceUrlLa) {
        
        _copysRaduceUrlLa = [[UILabel alloc] init];
        _copysRaduceUrlLa.numberOfLines = 0;
        _copysRaduceUrlLa.textColor = UIColor.grayColor;
        _copysRaduceUrlLa.font = [UIFont systemFontOfSize:15];
    }
    return _copysRaduceUrlLa;
}

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

- (UIImageView *)logoIm{
    
    if (!_logoIm) {
        
        _logoIm = [[UIImageView alloc] init];
    }
    return _logoIm;
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont systemFontOfSize:15];
    }
    return _titleLa;
}
- (UILabel *)timeLa{
    
    if (!_timeLa) {
        
        _timeLa = [[UILabel alloc] init];
        _timeLa.textColor = UIColor.lightGrayColor;
        _timeLa.font = [UIFont fontWithName:FONTNAME size:12];
    }
    return _timeLa;
}

- (UIButton *)downBtn{
    
    if (!_downBtn) {
        
        _downBtn = [[UIButton alloc] init];
        [_downBtn setImage:[UIImage imageNamed:@"icon_download"] forState:UIControlStateNormal];
        [_downBtn addTarget:self action:@selector(onDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downBtn;
}

- (UIButton *)shareBtn{
    
    if (!_shareBtn) {
        
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(onSharedBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

#pragma mark - 分享
- (void)onSharedBtn:(UIButton *)sender{
    
    if ([self.layout.data.ProductTKL isValid]) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params SSDKSetupShareParamsByText:[NSString stringWithFormat:@"【推荐好物】%@\n【购买步骤】长按识别二维码—复制淘口令—点开手机【淘宝】领券下单   復→制此评论，%@，开启【淘宝】即可够买",self.layout.data.Title,self.layout.data.ProductTKL]
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil
                           customItems:nil
                           shareParams:params
                    sheetConfiguration:nil
                        onStateChanged:^(SSDKResponseState state,
                                         SSDKPlatformType platformType,
                                         NSDictionary *userData,
                                         SSDKContentEntity *contentEntity,
                                         NSError *error,
                                         BOOL end)
         {
             
             switch (state) {
                     
                 case SSDKResponseStateSuccess:
                     NSLog(@"成功");//成功
                     break;
                 case SSDKResponseStateFail:
                 {
                     NSLog(@"--%@",error.description);
                     //失败
                     break;
                 }
                 case SSDKResponseStateCancel:
                     break;
                 default:
                     break;
             }
         }];
    }else{
        
        if (self.layout.data.imgArr.count <= 0) {
            
            return;
        }
        
        NSMutableArray *chaArr = [NSMutableArray array];
        for (NSString *a in self.layout.data.imgArr) {
            
            [chaArr addObject:[a mj_url]];
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params SSDKSetupShareParamsByText:nil
                                    images:chaArr
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeAuto];
        
        [ShareSDK showShareActionSheet:nil
                           customItems:nil
                           shareParams:params
                    sheetConfiguration:nil
                        onStateChanged:^(SSDKResponseState state,
                                         SSDKPlatformType platformType,
                                         NSDictionary *userData,
                                         SSDKContentEntity *contentEntity,
                                         NSError *error,
                                         BOOL end)
         {
             
             switch (state) {
                     
                 case SSDKResponseStateSuccess:
                     NSLog(@"成功");//成功
                     break;
                 case SSDKResponseStateFail:
                 {
                     NSLog(@"--%@",error.description);
                     //失败
                     break;
                 }
                 case SSDKResponseStateCancel:
                     break;
                 default:
                     break;
             }
         }];
    }
    
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        
        //        _desLa.font = [UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightThin];
        //        _desLa.lineBreakMode = NSLineBreakByWordWrapping;
        //        _desLa.textColor = UIColor.darkGrayColor;
        _desLa.numberOfLines = 0;
    }
    return _desLa;
}

- (UILabel *)zfLa{
    if (!_zfLa) {
        
        _zfLa = [[UILabel alloc] init];
        _zfLa.font = [UIFont systemFontOfSize:13];
        _zfLa.textColor = UIColor.lightGrayColor;
    }
    return _zfLa;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.logoIm];
        [self addSubview:self.titleLa];
        [self addSubview:self.timeLa];
        [self addSubview:self.downBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.desLa];
        [self addSubview:self.imgsView];
        [self addSubview:self.zfLa];
        [self addSubview:self.copysStoreUrlLa];
        [self addSubview:self.copysRaduceUrlLa];
        [self addSubview:self.copysStoreUrlBtn];
        [self addSubview:self.copysRaduceUrlBtn];
        [self insertSubview:self.copysBgView atIndex:0];
    }
    return self;
}

- (void)setLayout:(MerchandiseChildLayout *)layout{
    
    _layout = layout;
    self.logoIm.frame = layout.logoRect;
    self.titleLa.frame = layout.titleRect;
    self.timeLa.frame = layout.timeRect;
    self.downBtn.frame = layout.downBtnRect;
    self.shareBtn.frame = layout.shareBtnRect;
    self.desLa.frame = layout.desRect;
    self.imgsView.frame = layout.imgsRect;
    self.zfLa.frame = layout.zfNumRect;
    self.copysStoreUrlLa.frame = layout.copysStoreUrlRect;
    self.copysBgView.frame = layout.copysBgViewRect;
    self.copysStoreUrlBtn.frame = layout.copysStoreBtnRect;
    
    [self.logoIm sd_setImageWithURL:layout.data.PublisherPicUrl.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    
    dispatch_queue_t quent = dispatch_queue_create("com.quent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(quent, ^{
        
        NSAttributedString *attStr1 = [NSString getAttributedWithString:layout.data.PublisherName WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
        
        NSAttributedString *attStr2 = [NSString getAttStrWithHtml:layout.data.ContentHtml];
        
        NSString *zfNum = [NSString stringWithFormat:@"%ld",(long)layout.data.ForwardsNumber];
        if (layout.data.ForwardsNumber >= 10000) {
            
            CGFloat a = layout.data.ForwardsNumber / 10000.0;
            zfNum = [NSString stringWithFormat:@"%.1f万",a];
        }
        
        NSAttributedString *attStr3 = [NSString getAttributedWithString:[NSString stringWithFormat:@"%@次转发",zfNum] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:13] color:UIColor.lightGrayColor];
        
        NSAttributedString *attStr4 = [[NSAttributedString alloc] init];
        if ([layout.data.ProductTKL isValid]) {
            
            NSString *koulingStr = [NSString stringWithFormat:@"【购买步骤】长按识别二维码—复制淘口令—点开手机【淘宝】领券下单   復→制此评论，%@，开启【淘宝】即可够买",layout.data.ProductTKL];
            attStr4 = [NSString getAttributedWithString:koulingStr WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:13] color:FontColor];
        }
       
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.titleLa.attributedText = attStr1;
            self.desLa.attributedText = attStr2;
            self.zfLa.attributedText = attStr3;
            
            if ([layout.data.ProductTKL isValid]) {
                
                self.copysStoreUrlLa.attributedText = attStr4;
            }
            
        });
    });
    self.timeLa.text = layout.data.PublishTime;
    
    self.imgArr = layout.data.imgArr;
    
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchandiseReChildCollectionCell *cell = (MerchandiseReChildCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];

    cell.imgUrl =  self.imgArr[indexPath.row];
    
    if (indexPath.row == 0 && [self.layout.data.ProductPrice isValid]) {
        
        cell.price = self.layout.data.ProductPrice;
        cell.priceIm.alpha = 1;
    }else{
        
        cell.priceIm.alpha = 0;
    }
    
    if ([self.layout.data.VideoUrl isValid] && indexPath.row == 0) {
        
        cell.playIm.alpha = 1;
    }else{
        
        cell.playIm.alpha = 0;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.layout.data.ItemId isValid]) {
        
        if (indexPath.row == 0) {
            
            GoodsModel *model = [[GoodsModel alloc] init];
            model.ItemId = self.layout.data.ItemId;
            model.Title = self.layout.data.Title;
            ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
            vc.goodsModel = model;
            [vc setHidesBottomBarWhenPushed:YES];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            return;
        }
    }
    
    NSMutableArray *datas = [NSMutableArray array];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    
    if ([self.layout.data.VideoUrl isValid]) {
        
        [arr addObject:self.layout.data.VideoUrl];
    }
    
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
