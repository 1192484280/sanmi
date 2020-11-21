//
//  ChangeNickNameViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ChangeNickNameViewController.h"

@interface ChangeNickNameViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ChangeNickNameViewController

- (UIButton *)btn{
    
    if (!_btn) {
        
        _btn= [[UIButton alloc] init];
        _btn.layer.cornerRadius = 20;
        _btn.layer.masksToBounds = YES;
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        _btn.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
        [_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(onChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)onChangeBtn:(UIButton *)sender{

    if (![self.tf.text isValid]) {
        
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ac1];
    [alert addAction:ac2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UITextField *)tf{
    
    if (!_tf) {
        
        _tf = [[UITextField alloc] init];
        _tf.font = [UIFont systemFontOfSize:15];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.placeholder = @"输入新昵称";
    }
    return _tf;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView addSubview:self.tf];
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bgView).with.insets(UIEdgeInsetsMake(0, 14, 0, 14));
        }];
        
    }
    return _bgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setNavBarWithTitle:@"昵称"];
    
    [self.view addSubview:self.bgView];
    
    [self.view addSubview:self.btn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(45);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.bgView.mas_bottom).offset(45);
    }];
}


@end
