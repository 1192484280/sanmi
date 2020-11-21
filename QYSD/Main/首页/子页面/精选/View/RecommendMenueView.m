//
//  RecommendMenueView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/7.
//  Copyright © 2019 qingyun. All rights reserved.
//  顶部菜单按钮

#import "RecommendMenueView.h"
#import "SDCycleScrollView.h"
#import "RecommendMenueCell.h"
#import "WKWebViewController.h"
#import "JuHuaSuanViewController.h"
#import "FunctionNavigateModel.h"

@interface RecommendMenueView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *newsTitleLa;
@property (nonatomic,strong) SDCycleScrollView *sdView;
@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, copy) NSArray *menueTitleArr;
//@property (nonatomic, copy) NSArray *menueImgArr;
@property (nonatomic, copy) NSArray *listArr;

@property (nonatomic, strong) UIView *slideBackView;
@property (nonatomic, strong) UIView *sliderView;

@end

@implementation RecommendMenueView

//- (NSArray *)menueTitleArr{
//
//    if (!_menueTitleArr) {
//
//        _menueTitleArr = @[@"9.9包邮",@"天猫超市",@"签到",@"天猫国际",@"新人有礼",@"聚划算券",@"分享集市",@"拼多多券",@"优惠先锋",@"京东券",@"过夜单",@"福利中心",@"淘宝奖励",@"喵喵说"];
//    }
//    return _menueTitleArr;
//}

-(UIView *)slideBackView{
    if (!_slideBackView) {
        
        UIView *slideBackView=[[UIView alloc] init];
        slideBackView.backgroundColor = [UIColor colorWithHexString:@"D8D8D8"];
        slideBackView.layer.cornerRadius = 2.5;
        _slideBackView = slideBackView;
        
        UIView *sliderView = [[UIView alloc] init];
        sliderView.backgroundColor = UIColor.orangeColor;
        sliderView.layer.cornerRadius = 2.5;
        _sliderView =sliderView;
         [_slideBackView addSubview:_sliderView];
        [sliderView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(35);
        }];
    }
    return _slideBackView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (kScreenWidth - 20) / 5;
            CGFloat itemH = 142/2;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"RecommendMenueCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (SDCycleScrollView *)sdView{
    
    if (!_sdView) {
        
        _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:nil placeholderImage:nil];
        _sdView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _sdView.onlyDisplayText = YES;
        _sdView.autoScrollTimeInterval = 2.0f;
        _sdView.titleLabelTextFont = [UIFont systemFontOfSize:13];
        _sdView.titleLabelTextColor = FontColor;
        _sdView.titleLabelBackgroundColor = UIColor.whiteColor;
        _sdView.userInteractionEnabled = NO;
        _sdView.titlesGroup = @[@"[无印良品] 超柔冰丝三件套 ~ ¥19.8",@"儿童纯棉睡衣套装 ¥ 29.9",@"[波士顿] U盘降价处理 ¥ 49.9"];
        
    }
    return _sdView;
}

- (UILabel *)newsTitleLa{
    
    if (!_newsTitleLa) {
        
        _newsTitleLa = [[UILabel alloc] init];
        _newsTitleLa.text = @"闪蜜快报";
        _newsTitleLa.font = [UIFont boldSystemFontOfSize:15];
    }
    return _newsTitleLa;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        self.layer.cornerRadius = 10;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
//    [self addSubview:self.line];
//    [self addSubview:self.newsTitleLa];
//    [self addSubview:self.sdView];
    [self addSubview:self.collectionView];
    [self addSubview:self.slideBackView];
    
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(-32);
//        make.height.mas_equalTo(0.5);
//    }];

//    [self.newsTitleLa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(14);
//        make.top.equalTo(self.line.mas_bottom);
//        make.bottom.mas_equalTo(0);
//    }];
//
//    [self.sdView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.newsTitleLa.mas_right).offset(10);
//        make.right.equalTo(self).offset(-14);
//        make.top.equalTo(self.line.mas_bottom);
//        make.bottom.mas_equalTo(0);
//    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.equalTo(self.sliderView.mas_top).offset(-5);
    }];
    
    [self.slideBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo( - 10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(5);
    }];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FunctionNavigateModel *model = self.listArr[indexPath.item];
    
    RecommendMenueCell *cell = (RecommendMenueCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.la.text = model.NavigateName;
    [cell.im sd_setImageWithURL:model.PicURL.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FunctionNavigateModel *model = self.listArr[indexPath.item];
    if ([model.NavigateName isEqualToString:@"聚划算券"]) {
        
        [self pushClassVC:@"JuHuaSuanViewController"];
        return;
    }
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    [webVC setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - 滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.listArr.count) return;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGPoint offset = scrollView.contentOffset;

        CGRect frame=self.sliderView.frame;
        frame.origin.x = offset.x * (self.slideBackView.frame.size.width-self.sliderView.frame.size.width)/(scrollView.contentSize.width-scrollView.frame.size.width);
        
        if (frame.origin.x<0) {
            
            frame.origin.x =0;
        }
        
        if (frame.origin.x>(self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width)) {
            
            frame.origin.x = self.slideBackView.bounds.size.width-self.sliderView.bounds.size.width;
        }
        self.sliderView.frame = frame;
        
    }];
    
}

- (void)pushClassVC:(NSString *)classStr{
    
    Class viewControllerClass = NSClassFromString(classStr);
    if (viewControllerClass) {
        UIViewController *targetVC = [[viewControllerClass alloc]init];
        
        if (targetVC) {
            [targetVC setHidesBottomBarWhenPushed:YES];
            [self.viewController.navigationController pushViewController:targetVC animated:true];
        }
    }
}

- (void)setDataArr:(NSArray *)dataArr{
    
    self.listArr = dataArr;
    [self.collectionView reloadData];
    
    if (self.listArr.count <= 10) {
        
        self.slideBackView.hidden = YES;
    }else{
        
        self.slideBackView.hidden = NO;
    }
}
@end
