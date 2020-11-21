//
//  SearchResultHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchResultHeaderView.h"

@interface SearchResultHeaderView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITextField *tf;

@end

@implementation SearchResultHeaderView

- (UITextField *)tf{
    
    if (!_tf) {
        
        _tf = [[UITextField alloc] init];
        _tf.placeholder = @"搜索关键字或标题";
        _tf.font = [UIFont systemFontOfSize:14];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.delegate = self;
        _tf.delegate = self;
        _tf.returnKeyType = UIReturnKeySearch;
    }
    return _tf;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self onSearchBtn];
    return YES;
}

- (UIView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[UIView alloc] init];
        _searchView.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
        _searchView.layer.cornerRadius = 15;
        
        UIImageView *im = [[UIImageView alloc] init];
        im.image = [UIImage imageNamed:@"img_search"];
        [_searchView addSubview:im];
        
        [_searchView addSubview:self.tf];
        
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self->_searchView);
            make.width.height.mas_equalTo(25);
        }];
        
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(im.mas_right);
            make.top.bottom.right.mas_equalTo(0);
        }];
    }
    return _searchView;
}

- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"img_proBack"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)onBackBtn:(UIButton *)sender{
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchBtn addTarget:self action:@selector(onSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

#pragma mark - 点击搜索
- (void)onSearchBtn{
    
    if (![self.tf.text isValid]) {
        return;
    }
    [self.tf resignFirstResponder];
    
    NSDictionary *dic = @{
                          @"keyWord":self.tf.text
                          };
    //发送用户点击搜索通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEARCHKEYWORD" object:nil userInfo:dic];
}

- (instancetype)initWithFrame:(CGRect)frame andKeyWord:(NSString *)keyWord
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.backBtn];
        [self addSubview:self.searchView];
        self.tf.text = keyWord;
        [self addSubview:self.searchBtn];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(STATUS_BAR_HEIGHT + 5);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(35);
        }];
        
        [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
            make.centerY.equalTo(self->_backBtn);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(30);
        }];
        
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backBtn.mas_right);
            make.right.equalTo(self.searchBtn.mas_left).offset(-8);
            make.height.mas_equalTo(30);
            make.centerY.equalTo(self->_backBtn);
        }];
    
    }
    return self;
}

@end
