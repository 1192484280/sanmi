//
//  ContactCustomerServiceViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ContactCustomerServiceViewController.h"
#import "FeedbackViewController.h"

@interface ContactCustomerServiceViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (weak, nonatomic) IBOutlet UIImageView *im;

@end

@implementation ContactCustomerServiceViewController

#pragma mark - 跳转投诉与建议
- (IBAction)goComplainVC:(UIButton *)sender {
    
    FeedbackViewController *vc = [[FeedbackViewController alloc] init];
    vc.selectedIndex = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.fd_prefersNavigationBarHidden = YES;
    

    if (iPhoneX) {
        
        self.topMargin.constant = 0;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@/res_files/zskf.png",[[NSUserDefaults standardUserDefaults] objectForKey:@"BasePath"]];
    
    [self.im sd_setImageWithURL:url.mj_url placeholderImage:[UIImage imageNamed:@"img_serce"] options:SDWebImageRefreshCached];
}


- (IBAction)onBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onCopyBtn:(UIButton *)sender {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = @"kefudaoshi";
    
    [self showSuccessMsg:@"微信号已复制"];
}


@end
