//
//  MineHeaderDetailedView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderDetailedView.h"
//#import "TypeCollectionViewCell.h"
#import "MineHeaderDetailCell.h"
#import "OrderCenterViewController.h"
#import "MyTeamViewController.h"
#import "MyProfitViewController.h"
#import "WKWebViewController.h"
#import "InvitationViewController.h"
#import "ContactCustomerServiceViewController.h"
#import "WkWebList.h"

@interface MineHeaderDetailedView  ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *titlesArr;
@property (nonatomic, copy) NSArray *imgsArr;
@property (copy, nonatomic) NSArray *vcArr;
@end

@implementation MineHeaderDetailedView

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        MyProfitViewController *vc1 = [[MyProfitViewController alloc] init];
        OrderCenterViewController *vc2 = [[OrderCenterViewController alloc]init];
        MyTeamViewController *vc3 = [[MyTeamViewController alloc] init];
        InvitationViewController *vc4 = [[InvitationViewController alloc] init];
        _vcArr = @[vc1, vc2, vc3, vc4];
    }
    return _vcArr;
}

- (NSArray *)titlesArr{
    
    if (!_titlesArr) {
        
//        _titlesArr = @[@"我的收益",@"我的订单",@"我的团队",@"邀请"];
        _titlesArr = @[@"新手教程",@"专属客服"];
    }
    return _titlesArr;
}

- (NSArray *)imgsArr{
    
    if (!_imgsArr) {
        
//        _imgsArr = @[@"shouyi",@"dingdan",@"tuandui",@"yaoqing"];
         _imgsArr = @[@"新手教程",@"专属客服"];
    }
    return _imgsArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 50) / 2;
            CGFloat itemH = itemW * 0.4;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 10;
//            CGFloat itemW = (KScreenWidth - 20) / 4;
//            CGFloat itemH = 90;
//            layout.itemSize = CGSizeMake(itemW, itemH);
//            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//            layout.minimumLineSpacing = 0;
//            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
//            [_collectionView registerNib:[UINib nibWithNibName:@"TypeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            [_collectionView registerClass:[MineHeaderDetailCell class] forCellWithReuseIdentifier:@"CELL"];
            
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
        _titleLa.backgroundColor = UIColor.whiteColor;
        _titleLa.font = [UIFont boldSystemFontOfSize:15];
        _titleLa.text  = @"贴心服务";
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
            make.top.equalTo(self.titleLa.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
   return self.titlesArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineHeaderDetailCell *cell = (MineHeaderDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
   
    cell.im.image = [UIImage imageNamed:self.imgsArr[indexPath.row]];
//    TypeCollectionViewCell *cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
//    cell.backgroundColor = UIColor.whiteColor;
//    cell.im.image = [UIImage imageNamed:self.imgsArr[indexPath.row]];
//    cell.la.attributedText = [NSString getAttributedWithString:self.titlesArr[indexPath.row] WithLineSpace:0 kern:0.5 font:[UIFont systemFontOfSize:14] color:FontColor];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIViewController *vc = self.vcArr[indexPath.row];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    if (indexPath.row == 0) {
        
        [WkWebList sharedInstance].url = @"http://shanmi.qytimes.cn/H5/Public/";
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        webVC.hadRelod = YES;
        [webVC setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }else if (indexPath.row == 1){
        
        ContactCustomerServiceViewController *vc = [[ContactCustomerServiceViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}
@end
