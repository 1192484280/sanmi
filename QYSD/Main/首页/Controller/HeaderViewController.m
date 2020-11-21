//
//  HeaderViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderViewController.h"
#import "HeaderTopView.h"
#import "ZJScrollPageView.h"
#import "RecommendViewController.h"
#import "HeaderChildBaseViewController.h"
#import "UIView+AZGradient.h"
#import "HeaderList.h"
#import "ColorArrManager.h"
#import "ExtraView.h"
#import "HeaderStore.h"
#import "GuessYouLikeViewController.h"
#import "HomeNavigateModel.h"
#import<CoreTelephony/CTCellularData.h>
#import "CommonStore.h"
#import "VersionUpdateView.h"

@interface HeaderViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) HeaderTopView *topView;
@property (nonatomic, strong) UIView *topBgColorView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *navModelArr;
@property (nonatomic, copy) NSArray *vcArr;

@property (nonatomic, strong) ExtraView *extraView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) VersionUpdateView *versionUpdateView;

@property (nonatomic, copy) NSAttributedString *upInfo;//版本更新内容

@end

@implementation HeaderViewController

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgView)]];
    }
    
    return _bgView;
}

- (void)didBgView{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        
        self.extraView.top = -1000;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
    }];
    
}

- (ExtraView *)extraView{
    
    if (!_extraView) {
        
        NSArray *arr = self.navModelArr;
        if (self.navModelArr.count > 2) {
            
            arr = [self.navModelArr subarrayWithRange:NSMakeRange(2, self.navModelArr.count - 2)];
        }
        NSInteger row = arr.count/4;
        if (arr.count%4 != 0) {
            
            row +=1;
        }
        
        CGFloat height = 10+20+ (KScreenWidth / 4) *row;
        _extraView = [[ExtraView alloc] initWithFrame:CGRectMake(0, -1000, KScreenWidth, height) modelArr:arr];
        
        MJWeakSelf
        _extraView.typeBlock = ^(NSInteger index) {
          
            [weakSelf didBgView];
            if (index == 1000) {
                
                return ;
            }
            
            if (self.navModelArr.count > 2) {
                
                [weakSelf.segmentView setSelectedIndex:index + 2 animated:YES];
            }else{
                
                [weakSelf.segmentView setSelectedIndex:index animated:YES];
            }
            
        };
    }
    return _extraView;
}

- (UIView *)topBgColorView{
    
    if (!_topBgColorView) {
        
        _topBgColorView = [[UIView alloc] init];
//        _topBgColorView.backgroundColor = [UIColor colorWithHexString:@"F88222"];
        [_topBgColorView az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    }
    return _topBgColorView;
}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (HomeNavigateModel *model in self.navModelArr) {
            
            if ([model.NavigateID isEqualToString:@"1"]) {
                
                [arr addObject:[[RecommendViewController alloc] init]];
            }else if ([model.NavigateID isEqualToString:@"2"]){
                
                [arr addObject:[[GuessYouLikeViewController alloc] init]];
            }else{
                
                HeaderChildBaseViewController *childVc = [[HeaderChildBaseViewController alloc] init];
                childVc.navigateid = model.NavigateID;
                [arr addObject:childVc];
            }
        }
        _vcArr = arr;
    }
    return _vcArr;
}

- (HeaderTopView *)topView{
    
    if (!_topView) {
        
        _topView = [[HeaderTopView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, iPhoneX_Top)];
        
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setUI];
    
    [self loadData];

    MJWeakSelf
    [HttpTool netWorkState:^(NSInteger status) {
        
        switch(status) {
            
            case 2:
                
                if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
                    
                    [weakSelf loadData];
                    //第一次启动
                }
                // [weakSelf showFailMsg:@"当前Wi-Fi网络"];
                break;
                
            case 1:
                
                if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
                    
                    [weakSelf loadData];
                }
                // [weakSelf showFailMsg:@"当前蜂窝移动网络"];
                break;
            default:
                break;
        }
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScroll:) name:@"ADSCROLL" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNotic:) name:@"SDPROGRESS" object:nil];
    
    //APP版本更新提示
    //当前版本号
    NSString *current_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //线上版本号
    NSString *new_version = [[NSUserDefaults standardUserDefaults] objectForKey:@"verson"];
    
    if ( ![current_version isEqualToString:new_version] && ![new_version isEqualToString:@"1.0"]) {
        
        [CommonStore getAPPVersionUpInfoSucess:^(NSAttributedString *upInfo) {
            
            [self popUpdateView:upInfo];
        } Failure:^(NSError *error) {
            
        }];
        
    }

}

#pragma mark - 弹出版本更新
- (void)popUpdateView:(NSAttributedString *)upInfo{
    
    self.upInfo = upInfo;
    
    UIWindow *topView = [UIApplication sharedApplication].keyWindow;
    [topView addSubview:self.versionUpdateView];
    [self.versionUpdateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (VersionUpdateView *)versionUpdateView{
    
    if (!_versionUpdateView) {
        
        _versionUpdateView = [[VersionUpdateView alloc] initWithFrame:CGRectZero withTitle:self.upInfo];
        _versionUpdateView.tag = 1212;
        MJWeakSelf
        _versionUpdateView.closeBlock = ^{
            
            weakSelf.versionUpdateView = nil;
            [[[UIApplication sharedApplication].keyWindow viewWithTag:1212] removeFromSuperview];
        };
        
//        _versionUpdateView.searchBlock = ^(NSString *text) {
//
//
//        };
    }
    return _versionUpdateView;
}
#pragma mark - 接收通知，刷新顶部topBgColorView的背景色
//- (void)onScroll:(NSNotification *)noti{
//
//    if ( [HeaderList sharedInstance].recommendTop == NO) {
//
//        self.topBgColorView.backgroundColor = [UIColor colorWithHexString:@"F88222"] ;
//
//        return;
//    }
//
//    NSDictionary *dic = noti.userInfo;
//    NSString *colorStr = [dic objectForKey:@"color"];
//    self.topBgColorView.backgroundColor = [UIColor colorWithHexString:colorStr];
//}

//颜色渐变
//- (void)onNotic:(NSNotification*)noti{
//
//    NSDictionary *dic = noti.userInfo;
//    NSString *pro = [dic objectForKey:@"progress"];
//    NSString *currentColor = [dic objectForKey:@"currentColor"];
//    NSString *nextColor = [dic objectForKey:@"nextColor"];
//    CGFloat progress = [pro floatValue];
//    DLog(@"滑动进度:%@，当前颜色:%@，即将呈现颜色：%@",pro,currentColor,nextColor);
//
//    NSArray *normalColorRGBA = [ColorArrManager getColorRGBA:[UIColor colorWithHexString:currentColor]];
//    NSArray *selectedColorRGBA = [ColorArrManager getColorRGBA:[UIColor colorWithHexString:nextColor]];
//
//    NSArray *deltaRGBA;
//    if (normalColorRGBA && selectedColorRGBA) {
//        CGFloat deltaR = [normalColorRGBA[0] floatValue] - [selectedColorRGBA[0] floatValue];
//        CGFloat deltaG = [normalColorRGBA[1] floatValue] - [selectedColorRGBA[1] floatValue];
//        CGFloat deltaB = [normalColorRGBA[2] floatValue] - [selectedColorRGBA[2] floatValue];
//        CGFloat deltaA = [normalColorRGBA[3] floatValue] - [selectedColorRGBA[3] floatValue];
//        deltaRGBA = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
//
//    }
//
//    self.topBgColorView.backgroundColor = [UIColor
//                                    colorWithRed:[normalColorRGBA[0] floatValue] - [deltaRGBA[0] floatValue] * progress
//                                    green:[normalColorRGBA[1] floatValue] - [deltaRGBA[1] floatValue] * progress
//                                    blue:[normalColorRGBA[2] floatValue] - [deltaRGBA[2] floatValue] * progress
//                                    alpha:[normalColorRGBA[3] floatValue] - [deltaRGBA[3] floatValue] * progress];
//
//}

#pragma mark - 刷新数据
- (void)loadData{
    
    MJWeakSelf
    [HeaderStore getHomeNavigateWithParentnavigateid:@"0" Success:^(NSArray *modelArr, NSArray *textArr) {
        
        weakSelf.titles = textArr;
        weakSelf.navModelArr = modelArr;
        [weakSelf.segmentView reloadTitlesWithNewTitles:textArr];
        [weakSelf.contentView reload];
        
        [weakSelf.view insertSubview:weakSelf.extraView belowSubview:weakSelf.topView];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showToastWithError:error];
    }];
    
    
    //获取基础配置接口
    [CommonStore getBasicinfoSucess:^(NSString *prefixpath) {
        
        [[NSUserDefaults standardUserDefaults] setObject:prefixpath forKey:@"BasePath"];
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)setUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat topBgColorView_h = STATUS_BAR_HEIGHT + iPhoneX_Top + 28;
    [self.view insertSubview:self.topBgColorView atIndex:0];
    [self.topBgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(topBgColorView_h);
    }];


    [self.view addSubview:self.topView];
    
    [self setupSegmentView];
    [self setupContentView];
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = YES;
    style.titleMargin = 2;
    
    UIColor *color = [UIColor colorWithRGB:0x000000];
    style.scrollLineColor = color;
    style.normalTitleColor = color;
    style.selectedTitleColor = color;
    style.segmentViewBounces = YES;
    style.showExtraButton = YES;
    style.extraBtnBackgroundImageName = @"img_more";
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top - 5, KScreenWidth, 40.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];

    segment.extraBtnOnClick = ^(UIButton *extraBtn) {
        
        [weakSelf.view insertSubview:self.bgView belowSubview:self.extraView];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.extraView.top = iPhoneX_Top;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            
        } completion:nil];
    };

    self.segmentView = segment;
    [self.view insertSubview:segment atIndex:1];

}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, iPhoneX_Top + 40, kScreenWidth, KScreenHeight - iPhoneX_Top - TAB_BAR_HEIGHT - 40) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view insertSubview:content atIndex:1];
//    [self.view addSubview:self.contentView];

}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = reuseViewController;
    childVc = self.vcArr[index];
    return childVc;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
