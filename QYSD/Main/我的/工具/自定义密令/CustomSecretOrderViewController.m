//
//  CustomSecretOrderViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/4.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CustomSecretOrderViewController.h"
#import "CustomSecretView.h"

@interface CustomSecretOrderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *theCopySercetBtn;
@property (weak, nonatomic) IBOutlet UIButton *setCustomSercetBtn;
@property (nonatomic, strong) CustomSecretView *customSecretView;
@property (strong, nonatomic) UIView *bgView;

@end

@implementation CustomSecretOrderViewController

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgView)]];
    }
    return _bgView;
}

- (void)didBgView{
    
    [self.view endEditing:YES];
    
    MJWeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        
        self.customSecretView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.customSecretView.alpha = 0;
        weakSelf.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finished) {
        
        [weakSelf.bgView removeFromSuperview];
    }];
    
}

- (CustomSecretView *)customSecretView{
    
    if (!_customSecretView) {
        
        //300/370
        _customSecretView = [[CustomSecretView alloc] init];
        _customSecretView.alpha = 0;
    }
    return _customSecretView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setNavBarWithTitle:@"自定义密令"];
    
    [self.theCopySercetBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    
    [self.setCustomSercetBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];

    [self.view addSubview:self.customSecretView];
    CGFloat width = 276;
    CGFloat height = 357;
    [self.customSecretView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo((width));
        make.height.mas_equalTo(height);
//        make.centerX.equalTo(self.view);
    }];
    self.customSecretView.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (IBAction)startCustomSecret:(UIButton *)sender {
}
- (IBAction)onSetCustomSecretBtn:(UIButton *)sender {
    
     [self.view insertSubview:self.bgView belowSubview:self.customSecretView];
//    self.customSecretView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.5f animations:^{
        
        self.customSecretView.alpha = 1;
        self.customSecretView.transform = CGAffineTransformIdentity;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }];
//    [self.view insertSubview:self.bgView belowSubview:self.customSecretView];
//
//    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
//
//        self.setOneView.centerY = self.view.centerY - 80;
//        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//
//    } completion:nil];
    
}

@end
