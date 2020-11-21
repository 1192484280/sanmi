//
//  RecommendViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCollectionReusableView.h"
#import "RecommendTopBgView.h"
#import "HeaderList.h"
#import "ProductDetailViewController.h"
#import "HeaderRefreshHeader.h"
#import "RecommendStore.h"
#import "GoodsCell.h"
#import "GoodsCellLayout.h"
#import "SliderCell.h"
#import "WuLiaoCell.h"
#import "ActivetyCell.h"
#import "ActivetyModel.h"
#import "RecomendFourYouCell.h"
#import "MenueCell.h"

#import "FunctionNavigateModel.h"

@interface RecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger pageno;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *listArr;
@property (nonatomic, copy) NSArray *sliderArr;
@property (nonatomic, copy) NSArray *wuliaoArr;
@property (nonatomic, copy) NSArray *activeArr;
@property (nonatomic, copy) NSArray *activeOldArr;
@property (nonatomic, copy) NSArray *menueArr;

@property (nonatomic, strong) RecommendTopBgView *topBgView;
@property (nonatomic, strong) UIButton *goTopBtn;
@property (nonatomic, weak) RecommendCollectionReusableView *headerView;

@end

@implementation RecommendViewController

- (UIButton *)goTopBtn{
    
    if (!_goTopBtn) {
        
        _goTopBtn = [[UIButton alloc] init];
        _goTopBtn.hidden = YES;
        [_goTopBtn setImage:[UIImage imageNamed:@"img_goTop"] forState:UIControlStateNormal];
        [_goTopBtn addTarget:self action:@selector(goTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goTopBtn;
}

- (void)goTop{
    
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (RecommendTopBgView *)topBgView{
    
    if (!_topBgView) {
        
        _topBgView = [[RecommendTopBgView alloc] init];
    }
    return _topBgView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.pagingEnabled = NO;
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            
            [_collectionView registerClass:[SliderCell class] forCellWithReuseIdentifier:@"SliderCell"];
            
            [_collectionView registerClass:[MenueCell class] forCellWithReuseIdentifier:@"MenueCell"];
            
            [_collectionView registerClass:[WuLiaoCell class] forCellWithReuseIdentifier:@"WuLiaoCell"];
            
            [_collectionView registerClass:[ActivetyCell class] forCellWithReuseIdentifier:@"ActivetyCell"];
            
            [_collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"GoodsCell"];
            
            [_collectionView registerClass:[RecomendFourYouCell class] forCellWithReuseIdentifier:@"RecomendFourYouCell"];
            
            MJWeakSelf
            HeaderRefreshHeader *header = [HeaderRefreshHeader headerWithRefreshingBlock:^{
                
                self->pageno = 1;
                [weakSelf loadData];
            }];
            
            _collectionView.mj_header = header;
            
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                self->pageno ++;
                [weakSelf loadData];
            }];
            _collectionView.mj_footer = footer;
            
        }
        return _collectionView;
    }
    return _collectionView;
}

//- (void)viewDidAppear:(BOOL)animated{
//
//    [super viewDidAppear:animated];
//    DLog(@"已经出现");
//    if ( [HeaderList sharedInstance].recommendTop == NO) {
//
//        return;
//    }
//    [HeaderList sharedInstance].recommendPage = YES;
//    [self postNotiOne];
//}
//
//- (void)postNotiOne{
//
//    if ([HeaderList sharedInstance].currentColorr.length <= 0) {
//
//        return;
//    }
//    NSDictionary *dic =@{
//                         @"color":[HeaderList sharedInstance].currentColorr,
//                         };
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADSCROLL" object:nil userInfo:dic];
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageno = 1;
    
    [self setUI];
    
    [self showLottie];
    
    [self loadData];
}

- (void)setUI{
    
    [self.view insertSubview:self.topBgView atIndex:0];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(KScreenWidth * 0.213);
    }];

    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.goTopBtn];
    [self.goTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - 刷新数据
- (void)loadData{
    

    dispatch_queue_t queue = dispatch_queue_create("com.task.gcd", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    MJWeakSelf
    //获取轮播图
    dispatch_group_enter(group);
    [RecommendStore getHomeBannerSuccess:^(NSArray *theArr) {

        weakSelf.sliderArr = theArr;
//        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        dispatch_group_leave(group);
    } Failure:^(NSError *error) {

        [weakSelf showToastWithError:error];
        dispatch_group_leave(group);
    }];
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    if ( ![version isEqualToString:@"1.0"]) {
        
        //获取菜单
        dispatch_group_enter(group);
        [RecommendStore getFunctionNavigateSuccess:^(NSArray *theArr) {
            
            weakSelf.menueArr = theArr;
//            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            dispatch_group_leave(group);
            
        } Failure:^(NSError *error) {
            [weakSelf showToastWithError:error];
            dispatch_group_leave(group);
        }];
        
        //活动
        dispatch_group_enter(group);
        [RecommendStore getHomeActivitySuccess:^(NSArray *oldArr, NSArray *theArr) {
            
            weakSelf.activeArr = theArr;
            weakSelf.activeOldArr = oldArr;
//            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            dispatch_group_leave(group);
            
        } Failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }

    //物料专区
    dispatch_group_enter(group);
    [RecommendStore getHomejxwlWithParentnavigateid:-1 Success:^(NSArray *theArr) {

        weakSelf.wuliaoArr = theArr;
//        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:3]];
        dispatch_group_leave(group);
        
    } Failure:^(NSError *error) {
        [weakSelf showToastWithError:error];
        dispatch_group_leave(group);
    }];
    
    //获取列表数据
    dispatch_group_enter(group);
    [RecommendStore getQualityProductWithIdentity:IDENTITY Pageno:pageno Pagesize:PAGESIZE Success:^(NSArray *tabArr, NSArray *collectionArr) {
        
        if (self->pageno == 1) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:collectionArr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:collectionArr];
        }
//        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:5]];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        dispatch_group_leave(group);
        
    } Failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf showToastWithError:error];
        dispatch_group_leave(group);
    }];
    
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"全部执行完毕");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf hidenLottie];
            [weakSelf.collectionView reloadData];
        });
    });
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.sliderArr.count >0? 1 : 0;
    }else if (section == 1) {
        
        return self.menueArr.count > 0? 1 : 0;
    }else if (section == 2) {
        
        return self.activeArr.count > 0? 1 : 0;
    }else if (section == 3) {
        
        return self.wuliaoArr.count > 0? 1 : 0;
    }else if (section == 4) {
        
        return 1;
    }else{
        
        return self.listArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SliderCell *cell = (SliderCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SliderCell" forIndexPath:indexPath];
        [cell setData:self.sliderArr];
        return cell;
    }else  if (indexPath.section == 1) {
        
        MenueCell *cell = (MenueCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MenueCell" forIndexPath:indexPath];
        cell.dataArr = self.menueArr;
        
        return cell;
    }else  if (indexPath.section == 2) {
        
        ActivetyCell *cell = (ActivetyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ActivetyCell" forIndexPath:indexPath];
        cell.dataArr = self.activeArr;
        
        return cell;
    }else  if (indexPath.section == 3) {
        
        WuLiaoCell *cell = (WuLiaoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WuLiaoCell" forIndexPath:indexPath];
        cell.dataArr = self.wuliaoArr;
        return cell;
    }else  if (indexPath.section == 4) {
        
        RecomendFourYouCell *cell = (RecomendFourYouCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RecomendFourYouCell" forIndexPath:indexPath];
        return cell;
    }else {
        
        GoodsCellLayout *layout = self.listArr[indexPath.row];
        GoodsCell *cell = (GoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
        [cell setLayout:layout];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 5) {
        
        GoodsCellLayout *layout = self.listArr[indexPath.row];
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
        vc.goodsModel = layout.data;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//设置每个item的尺寸 这个才是背景为黄色的item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CGFloat banner_w = KScreenWidth - 20;
        CGFloat banner_scale = 0.35;
        CGFloat banner_h = banner_w * banner_scale;
        return CGSizeMake(banner_w, banner_h);
        
    }else if(indexPath.section == 1){
        
//        CGFloat itemW = (kScreenWidth - 20) / 5;
        CGFloat oneItemH = 142 / 2 + 10;
        CGFloat menue_w = KScreenWidth - 20;
        if (self.wuliaoArr.count <= 0) {
            
            return CGSizeZero;
        }else if (self.menueArr.count <=  5) {
            
            return CGSizeMake(menue_w, oneItemH);
            
        }else  {
            
            return CGSizeMake(menue_w, oneItemH * 2);
        }
    
//        return CGSizeMake(menue_w, oneItemH *2 + 20);
        
    }else if(indexPath.section == 2){
        
        CGFloat height = 0;
        CGFloat ac1_w = KScreenWidth - 20;
        CGFloat ac2_w = (KScreenWidth - 25)/2;
        CGFloat ac3_w = (KScreenWidth - 30)/3;
        CGFloat ac4_w = (KScreenWidth - 35)/4;
        for (ActivetyModel *model in self.activeOldArr) {
            
            if (model.ActivityNum == 1) {
                
                height += ac1_w * 0.4;
            }else if (model.ActivityNum == 2){
                
                height += ac2_w * 0.4 + 5;
            }else if (model.ActivityNum == 3){
                
                height += ac3_w * 0.4 + 10;
            }else if (model.ActivityNum == 4){
                
                height += ac4_w * 0.4 + 20;
            }
        }
        return CGSizeMake(KScreenWidth-20, height);
    }else if(indexPath.section == 3){
        
        NSInteger num = ceilf(self.wuliaoArr.count/2);
        CGFloat fourType_w = KScreenWidth- 20;
        CGFloat fourType_scale = 0.6;
        CGFloat itemW = (fourType_w - 0.5) / 2;
        CGFloat itemH = itemW * fourType_scale;
        
        if (self.wuliaoArr.count == 1) {
            
            return CGSizeMake(fourType_w, itemH);
        }
        
        return CGSizeMake(fourType_w, itemH * num + 0.5 *(num - 1));
    }else if(indexPath.section == 4){
        
        return self.listArr.count > 0 ? CGSizeMake(KScreenWidth, 30) : CGSizeZero;
        
    }else{
        
        GoodsCellLayout *layout = self.listArr[indexPath.row];
        return CGSizeMake(layout.width,  layout.height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if (section == 0) {
        
        return self.sliderArr.count >0? UIEdgeInsetsMake(5, 10, 5, 10) : UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (section == 1) {
        
        return self.menueArr.count > 0?UIEdgeInsetsMake(5, 10, 5, 10) : UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (section == 2) {
        
        return self.activeArr.count > 0? UIEdgeInsetsMake(5, 10, 5, 10) : UIEdgeInsetsMake(0, 0, 0, 0);
    }else if (section == 3) {
        
        return self.wuliaoArr.count > 0? UIEdgeInsetsMake(5, 10, 5, 10) : UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        
        return UIEdgeInsetsMake(5, 10, 5, 10) ;
    }
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 2) {
//
//        RecommendCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
//        self.headerView = view;
//        return view;
//    }else{
//
//        return nil;
//    }
//}
//
//
//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//    CGSize size = CGSizeMake(KScreenWidth, 40);
//    return size;
//}

#pragma mark - 滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 0) {
        
        self.topBgView.top = -offsetY;
    }
    
    //根据偏移量，显示或隐藏返回顶部按钮
    if (offsetY > 150) {
        
        self.goTopBtn.hidden = NO;
    }else{
        
        self.goTopBtn.hidden = YES;
    }
    
    
    //    //根据滚动距离，修改导航栏颜色
    //    if (offsetY > 172) {
    //
    //        [HeaderList sharedInstance].recommendTop = NO;
    //        NSDictionary *dic =@{
    //                                             @"color":@"F88222"
    //                                             };
    //
    ////        [[NSNotificationCenter defaultCenter] postNotificationName:@"ADSCROLL" object:nil userInfo:dic];
    //    }else{
    //
    //        [HeaderList sharedInstance].recommendTop = YES;
    //        if ([HeaderList sharedInstance].currentColorr.length <= 0) {
    //
    //            return;
    //        }
    //        NSDictionary *dic =@{
    //                             @"color":[HeaderList sharedInstance].currentColorr,
    //                             };
    //
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"ADSCROLL" object:nil userInfo:dic];
    //    }
}

@end
