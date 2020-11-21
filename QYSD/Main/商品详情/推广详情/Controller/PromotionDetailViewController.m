//
//  PromotionDetailViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailViewController.h"
#import "PromotionDetailPhotoView.h"
#import "PromotionDetailCopywritingView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface PromotionDetailViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *diyBtn;
@property (weak, nonatomic) IBOutlet UIButton *faquanBtn;

@property (weak, nonatomic) IBOutlet UITextView *commentTf;

@property (nonatomic, strong) PromotionDetailPhotoView *selectedPhotoView;
@property (nonatomic, strong) PromotionDetailCopywritingView *copywritingView;

@end

@implementation PromotionDetailViewController

- (PromotionDetailCopywritingView *)copywritingView{
    
    if (!_copywritingView) {
        
        _copywritingView = [[PromotionDetailCopywritingView alloc] init];
        
        MJWeakSelf
        _copywritingView.scrollViewEndBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                weakSelf.diyBtn.selected = YES;
                weakSelf.faquanBtn.selected = NO;
            }else{
                
                weakSelf.diyBtn.selected = NO;
                weakSelf.faquanBtn.selected = YES;
            }
        };
    }
    return _copywritingView;
}

- (PromotionDetailPhotoView *)selectedPhotoView{

    if (!_selectedPhotoView) {
        
        _selectedPhotoView = [[PromotionDetailPhotoView alloc] init];
    }
    return _selectedPhotoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.commentTf.delegate = self;
    
    [self setNavBar];
    
    [self setUI];
    
}

- (void)setNavBar{
    
    [self setNavBarWithTitle:@"推广详情"];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"分享说明" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void)setUI{
    
    [self.photoView addSubview:self.selectedPhotoView];
    [self.selectedPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.middleView addSubview:self.copywritingView];
    [self.copywritingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)onRightBtn{
    
    [self showFailMsg:@"分享说明"];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    return NO;
    
}
#pragma mark - 点击自定义文案
- (IBAction)onDiyBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        return;
    }
    
    self.faquanBtn.selected = NO;
    sender.selected = !sender.selected;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.copywritingView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 点击发圈文案
- (IBAction)onFaQuanBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        return;
    }
    
    self.diyBtn.selected = NO;
    sender.selected = !sender.selected;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.copywritingView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 显示闪蜜收益
- (IBAction)onShowProfitBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        self.commentTf.text = @"復→制此评论，￥2wqqYkxBUb2￥，开启【淘#寳】即可够买";
    }else{
        
        self.commentTf.text = @"復→制此评论，￥2wqqYkxBUb2￥，开启【淘#寳】即可够买\n【下载闪蜜下单】可再返8.26元";
    }
    sender.selected = !sender.selected;
}

#pragma mark - 仅复制评论文案
- (IBAction)onCopyCommentBtn:(UIButton *)sender {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.commentTf.text;
    [self.view makeToast:@"复制成功" duration:1.0 position:CSToastPositionCenter];
}

#pragma mark - 分享视频
- (IBAction)onShareVideoBtn:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:@"闪蜜-先领券再购物最高可优惠90%"
                                images:[UIImage imageNamed:@"shareImg.png"]
                                   url:nil
                                 title:@"大家都在用的购物省钱APP"
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

#pragma mark - 规则
- (IBAction)onRuleBtn:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"奖励计算规则" message:@"此处展示的金额由商家设置\n最终以实际计算为准" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:ac1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onShareBtn:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:@"大家都在用的购物省钱APP"
                                images:[UIImage imageNamed:@"shareImg.png"]
                                   url:nil
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
}
@end
