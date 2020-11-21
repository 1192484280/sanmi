//
//  RecommendSliderView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//  广告轮播图

#import "RecommendSliderView.h"
#import "SDCycleScrollView.h"
#import "HeaderList.h"
#import "HomeBannerModel.h"
#import "GoodsModel.h"
#import "ProductDetailViewController.h"
#import "WkWebList.h"
#import "WKWebViewController.h"

@interface RecommendSliderView ()<SDCycleScrollViewDelegate>
{
    NSInteger currentIndex;
    NSInteger nextIndex;
}

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, copy) NSArray *imgArr;
@property (nonatomic, copy) NSArray *imgColorArr;


@end

@implementation RecommendSliderView

- (SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
        _cycleScrollView.pageDotColor = UIColor.whiteColor;
        _cycleScrollView.currentPageDotColor =ThemColor;
        _cycleScrollView.layer.cornerRadius = 10;
        _cycleScrollView.layer.masksToBounds = YES;
//        _cycleScrollView.imageURLStringsGroup = self.imgArr;
        _cycleScrollView.autoScrollTimeInterval = 5;
    }
    return _cycleScrollView;
}
- (NSArray *)imgColorArr{
    
    if (!_imgColorArr) {
        
        _imgColorArr = @[@"F88222",@"D136B6",@"EAA15C",@"C4D1DA"];
    }
    return _imgColorArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.2f;
        self.layer.shadowRadius = 4.f;
        self.layer.shadowOffset = CGSizeMake(1,1);

        currentIndex = 0;
        [self setUI];
        
    }
    return self;
}

- (void)setUI{
    
//    self.imgArr = @[@"http://lc-4cjyhep8.cn-n1.lcfile.com/6b8ccd30b7b3be385699/reslider01.jpg",@"http://lc-4cjyhep8.cn-n1.lcfile.com/e3ff0772809e26ce12fe/reslider02.jpg",@"http://lc-4cjyhep8.cn-n1.lcfile.com/a1d7a71ee8462b1a0892/reslider03.jpg",@"http://lc-4cjyhep8.cn-n1.lcfile.com/d0cc8338b177fa0a50f5/reslider04.jpg"];
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
//    cycleScrollView.pageDotColor = UIColor.whiteColor;
//    cycleScrollView.currentPageDotColor =ThemColor;
//    cycleScrollView.layer.cornerRadius = 10;
//    cycleScrollView.layer.masksToBounds = YES;
//    cycleScrollView.imageURLStringsGroup = self.imgArr;
//    cycleScrollView.autoScrollTimeInterval = 5;
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
//    cycleScrollView.scrollProgress = ^(CGFloat progress, BOOL ifLeft) {
    
//        if (ifLeft) {
//
//            DLog(@"向左滑动%f",progress);
//            self->nextIndex = self->currentIndex +1;
//            if(self->currentIndex == self.imgColorArr.count - 1){
//
//                self->nextIndex = 0;
//            }
//
//
//        }else{
//
//            self->nextIndex = self->currentIndex -1;
//            if(self->currentIndex == 0){
//
//                self->nextIndex = self.imgColorArr.count - 1;
//            }
//        }
//
//        NSString *currentColor = self.imgColorArr[self->currentIndex];
//        NSString *nextColor = self.imgColorArr[self->nextIndex];
//        NSDictionary *dic = @{
//                                                @"progress":[NSString stringWithFormat:@"%f",progress],
//                                                @"currentColor":currentColor,
//                                                @"nextColor":nextColor
//                                                };
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SDPROGRESS" object:nil userInfo:dic];
//    };
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    HomeBannerModel *hmodel = self.dataArr[index];
    
    if (hmodel.RedirectContentType == 1) {
        
        [WkWebList sharedInstance].url = hmodel.RedirectPath;
        WKWebViewController *webVC = [[WKWebViewController alloc] init];
        [webVC setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }else{
        
        GoodsModel *model = [[GoodsModel alloc] init];
        model.ItemId = hmodel.ItemID;
        model.Title = hmodel.Title;
        ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
        vc.goodsModel = model;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    currentIndex = index;
    
    UIImageView *bgImg;
//    [bgImg sd_cancelCurrentAnimationImagesLoad];
    [bgImg sd_setImageWithURL:nil];
    
//    NSDictionary *dic =@{
//                         @"color":self.imgColorArr[index],
//                         };
//    [HeaderList sharedInstance].currentColorr = self.imgColorArr[index];
//    
//    if (![HeaderList sharedInstance].recommendPage) {
//        
//        return;
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADSCROLL" object:nil userInfo:dic];
}

- (void)setData:(NSArray *)data{
    
    _dataArr = data;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (HomeBannerModel *model in data) {
        
        [arr addObject:[model.BannerURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    }
    
    self.cycleScrollView.imageURLStringsGroup = arr;
}

@end
