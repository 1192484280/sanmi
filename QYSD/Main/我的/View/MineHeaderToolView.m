//
//  MineHeaderToolView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderToolView.h"
#import "TypeCollectionViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LoginMainViewController.h"
#import "CommonStore.h"

@interface MineHeaderToolView  ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *titleLa;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *titlesArr;
@property (nonatomic, copy) NSArray *imgsArr;
@property (nonatomic, copy) NSArray *vcArr;

@end

@implementation MineHeaderToolView

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
//        _vcArr = @[@"WKWebViewController", @"CollectorViewController", @"FootPrintViewController", @"WKWebViewController",@"NoviceStrategyViewController", @"CustomSecretOrderViewController", @"FeedbackViewController", @"AboutSMViewController",@"ContactCustomerServiceViewController"];
        
        _vcArr = @[ @"CollectorViewController", @"FootPrintViewController", @"OpinionViewController", @"AboutSMViewController"];
    }
    return _vcArr;
}

- (NSArray *)titlesArr{
    
    if (!_titlesArr) {
        
//        _titlesArr = @[@"工具",@"闪蜜收藏夹",@"足迹",@"淘宝订单",@"新手攻略",@"自定义密令",@"意见反馈",@"关于闪蜜",@"联系客服"];
        _titlesArr = @[@"我的收藏",@"我的足迹",@"意见反馈",@"分享APP"];
    }
    return _titlesArr;
}

- (NSArray *)imgsArr{
    
    if (!_imgsArr) {
        
//        _imgsArr = @[@"工具",@"收藏夹",@"足迹",@"淘宝订单",@"新手攻略",@"自定义密令",@"意见反馈",@"关于",@"客服"];
        _imgsArr = @[@"收藏夹",@"足迹",@"意见反馈",@"客服"];
    }
    return _imgsArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 20) / 4;
            CGFloat itemH = 80;
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
        _titleLa.text  = @"必备工具";
        _titleLa.backgroundColor = UIColor.whiteColor;
    }
    return _titleLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.titleLa];
        [self insertSubview:self.line belowSubview:self.titleLa];
        
        CGFloat margin = 10.0f;
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(margin);
            make.height.mas_equalTo(30);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.centerY.equalTo(self.titleLa);
            make.height.mas_equalTo(0.5);
        }];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.equalTo(self.titleLa.mas_bottom).offset(margin);
        }];
        
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titlesArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeCollectionViewCell *cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.im.image = [UIImage imageNamed:self.imgsArr[indexPath.row]];
    cell.la.attributedText = [NSString getAttributedWithString:self.titlesArr[indexPath.row] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:13] color:FontColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.titlesArr[indexPath.row] isEqualToString:@"分享APP"]) {
        
        [self shareAPP];
        return;
    }
    
    if ([SMUserGuid isValid]) {
        
        Class viewControllerClass = NSClassFromString(self.vcArr[indexPath.row]);
        if (viewControllerClass) {
            UIViewController *targetVC = [[viewControllerClass alloc]init];
            
            if (targetVC) {
                [targetVC setHidesBottomBarWhenPushed:YES];
                [self.viewController.navigationController pushViewController:targetVC animated:true];
            }
        }
    }else{
        
        LoginMainViewController *vc = [[LoginMainViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:vc animated:YES completion:nil];
    }
    
}

#pragma mark - 分享
- (void)shareAPP{
    
    [CommonStore getAPPDownLoadUrlSucess:^(NSString *url) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params SSDKSetupShareParamsByText:@"大家都在用的购物省钱APP"
                                    images:[UIImage imageNamed:@"smlogo"]
                                       url:[NSURL URLWithString:url]
                                     title:@"闪蜜-先领券再购物最高可优惠90%"
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
        
    } Failure:^(NSError *error) {
        
    }];
}

@end
