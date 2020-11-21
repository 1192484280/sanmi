//
//  ChangePassWordViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *la1;
@property (nonatomic, strong) UILabel *la2;
@property (nonatomic, strong) UILabel *la3;
@property (nonatomic, strong) UILabel *phoneLa;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UITextField *pwTf;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ChangePassWordViewController

- (UIButton *)getCodeBtn{
    
    if (!_getCodeBtn) {
        
        _getCodeBtn= [[UIButton alloc] init];
        _getCodeBtn.layer.cornerRadius = 14;
        _getCodeBtn.layer.masksToBounds = YES;
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _getCodeBtn.layer.borderWidth = 0.5;
        _getCodeBtn.layer.borderUIColor = [UIColor colorWithHexString:@"FA6400"];
        [_getCodeBtn setTitleColor:[UIColor colorWithHexString:@"FA6400"] forState:UIControlStateNormal];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn addTarget:self action:@selector(onGetCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (void)onGetCodeBtn:(UIButton *)sender{
    
    if (![self.phoneLa.text isValid]) {
        
        return;
    }
    
    //    if (![self.phoneLa.text isVaildMobileNo]) {
    //
    //        [self showFailMsg:@"请输入有效手机号"];
    //        return;
    //    }
}

- (UIButton *)btn{
    
    if (!_btn) {
        
        _btn= [[UIButton alloc] init];
        _btn.layer.cornerRadius = 20;
        _btn.layer.masksToBounds = YES;
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        _btn.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
        [_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btn setTitle:@"验证后绑定新手机号" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(onChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

#pragma mark - 确定修改
- (void)onChangeBtn:(UIButton *)sender{
    
    [self.tf resignFirstResponder];
    [self.pwTf resignFirstResponder];
    
    if (![self.tf.text isValid]) {
        
        [self showFailMsg:@"请输入验证码"];
        return;
    }
    
    if (![self.pwTf.text isValid]) {
        
        [self showFailMsg:@"请输入新密码"];
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

- (UILabel *)la1{
    
    if (!_la1) {
        
        _la1 = [[UILabel alloc] init];
        _la1.text = @"原手机号";
        _la1.font = [UIFont systemFontOfSize:15];
    }
    return _la1;
}

- (UILabel *)la2{
    
    if (!_la2) {
        
        _la2 = [[UILabel alloc] init];
        _la2.text = @"验证码";
        _la2.font = [UIFont systemFontOfSize:15];
    }
    return _la2;
}

- (UILabel *)la3{
    
    if (!_la3) {
        
        _la3 = [[UILabel alloc] init];
        _la3.text = @"新密码";
        _la3.font = [UIFont systemFontOfSize:15];
    }
    return _la3;
}

- (UILabel *)phoneLa{
    
    if (!_phoneLa) {
        
        _phoneLa = [[UILabel alloc] init];
        _phoneLa.font = [UIFont systemFontOfSize:15];
        _phoneLa.text = @"176****7323";
        _phoneLa.textColor = FontColor;
    }
    return _phoneLa;
}


- (UITextField *)tf{
    
    if (!_tf) {
        
        _tf = [[UITextField alloc] init];
        _tf.font = [UIFont systemFontOfSize:15];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.placeholder = @"请输入验证码";
    }
    return _tf;
}

- (UITextField *)pwTf{
    
    if (!_pwTf) {
        
        _pwTf = [[UITextField alloc] init];
        _pwTf.font = [UIFont systemFontOfSize:15];
        _pwTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwTf.placeholder = @"请输入新密码";
    }
    return _pwTf;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BaseBackGroundColor;
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = BaseBackGroundColor;
        
        UIView *line3 = [[UIView alloc] init];
        line3.backgroundColor = BaseBackGroundColor;
        
        [_bgView addSubview:self.la1];
        [_bgView addSubview:self.phoneLa];
        [_bgView addSubview:line];
        [_bgView addSubview:self.la2];
        [_bgView addSubview:self.tf];
        [_bgView addSubview:self.getCodeBtn];
        [_bgView addSubview:line2];
        [_bgView addSubview:self.la3];
        [_bgView addSubview:self.pwTf];
        [_bgView addSubview:line3];
        
        [self.la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(70);
        }];
        
        [self.phoneLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.la1.mas_right).offset(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.la1.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.la2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(line);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(70);
        }];
        
        [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.equalTo(self.la2);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(90);
        }];
        
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.la1.mas_right).offset(10);
            make.right.equalTo(self.getCodeBtn.mas_left);
            make.centerY.equalTo(self.la2);
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.la2.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.la3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(line2);
           make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(70);
        }];
        
        [self.pwTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.la3.mas_right).offset(10);
            make.right.equalTo(self.tf);
            make.centerY.equalTo(self.la3);
        }];
        
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return _bgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"修改密码"];
    
    [self.view addSubview:self.bgView];
    
    [self.view addSubview:self.btn];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(135);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.bgView.mas_bottom).offset(45);
    }];
}

@end
