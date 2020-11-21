//
//  InvitationViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "InvitationViewController.h"
#import "ZJScrollPageView.h"
#import "RecommendViewController.h"
#import "InvitationChildViewController.h"
#import "InvitationChildModel.h"
#import "InvitationChildLayout.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface InvitationViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *vcArr;
@property (nonatomic, strong) UIView *xibView;

@end

@implementation InvitationViewController

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"InvitationBottomBar" owner:self options:nil] lastObject];
        
    }
    return _xibView;
}

- (NSMutableArray *)vcArr{
    
    if (!_vcArr) {
        
        _vcArr = [NSMutableArray array];
    }
    return _vcArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self setUI];
    
    [self loadData];
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"分享"];

}

#pragma mark - 刷新数据
- (void)loadData{
    
    self.vcArr = [NSMutableArray array];
    
    MJWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        weakSelf.titles = @[@"通用",
                            @"宝妈",
                            @"微商",
                            @"学生",
                            @"兼职",
                            @"新手必备"
                            ];
        
        InvitationChildModel *model = [[InvitationChildModel alloc] init];
        model.imgs = @[@"http://lc-4cjyhep8.cn-n1.lcfile.com/b559d94cc7137d044567/img_yaoqing1.jpg",@"http://lc-4cjyhep8.cn-n1.lcfile.com/ee5430ba7e9462069bf5/img_yaoqing2.jpg",@"http://lc-4cjyhep8.cn-n1.lcfile.com/28fc26c757d45cf098df/img_yaoqing3.jpg"];
        model.ruleStr = @"1 复制注册口令包含您的邀请码信息\n2 好友通过您的注册口令注册或者二维码可以直接下载进行闪蜜APP的注册\n \n重要提示：分享单张海报可能会被朋友圈屏蔽，点击海报预览下载后，增加配图和海报一起分享就能避免屏蔽哦！";;
        
        InvitationChildLayout *layout = [[InvitationChildLayout  alloc] initWithData:model];
        
        for (NSString *a in weakSelf.titles) {
            
            InvitationChildViewController *childVc = [[InvitationChildViewController alloc] init];
            childVc.layout = layout;
            [weakSelf.vcArr addObject:childVc];
        }
        
        [weakSelf.segmentView reloadTitlesWithNewTitles:self.titles];
        [weakSelf.contentView reload];
    });
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController *childVc = reuseViewController;
    childVc = self.vcArr[index];
    return childVc;
}

- (void)setUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupSegmentView];
    
    [self.view addSubview:self.xibView];
    [self.xibView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(TAB_BAR_HEIGHT);
    }];
    
    [self setupContentView];
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    //    style.titleMargin = 10;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = ThemColor;
    style.normalTitleColor = FontColor;
    style.selectedTitleColor = ThemColor;
    style.segmentViewBounces = NO;
    
    style.scaleTitle = YES;
    //    style.titleMargin = 35;
    //    style.showExtraButton = YES;
    //    style.extraBtnBackgroundImageName = @"img_more";
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
    }];
    
    // 自定义标题的样式
    //    segment.layer.cornerRadius = 14.0;
    //    segment.backgroundColor = [UIColor clearColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    //    self.navigationItem.titleView = self.segmentView;
    [self.view addSubview:segment];
    
}

- (void)setupContentView{
    
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, 40, kScreenWidth, KScreenHeight - iPhoneX_Top  - 40 - TAB_BAR_HEIGHT) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];

}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    
    return NO;
}

#pragma mark - 复制淘口令
- (IBAction)onCopyBtn:(UIButton *)sender {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = @"淘口令";
    [self.view makeToast:@"复制成功" duration:1.0 position:CSToastPositionCenter];
}

#pragma mark - 分享邀请海报
- (IBAction)onShareBtn:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:@"test"
                                images:[UIImage imageNamed:@"shareImg.png"]
                                   url:[NSURL URLWithString:@"http://www.mob.com/"]
                                 title:@"title"
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

@end
