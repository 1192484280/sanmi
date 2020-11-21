//
//  HeaderSearchNavView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchNavView.h"
#import "ZJScrollPageView.h"
#import "HeaderSearchImgView.h"

@interface HeaderSearchNavView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITextField *tf;
@property (strong, nonatomic) ZJScrollSegmentView *segmentView;
@property (nonatomic, copy) NSArray *titlesArr;
@property (nonatomic, strong) HeaderSearchImgView *searchImgView;
@end

@implementation HeaderSearchNavView

- (NSArray *)titlesArr{
    
    if (!_titlesArr) {
        
        _titlesArr = @[@"淘宝",@"拼多多",@"京东"];
    }
    return _titlesArr;
}
- (HeaderSearchImgView *)searchImgView{
    
    if (!_searchImgView) {
        
        _searchImgView = [[HeaderSearchImgView alloc] init];
    }
    return _searchImgView;
}

- (UITextField *)tf{
    
    if (!_tf) {
        
        _tf = [[UITextField alloc] init];
        _tf.placeholder = @"搜索关键字或标题";
        _tf.font = [UIFont systemFontOfSize:14];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.delegate = self;
        _tf.returnKeyType = UIReturnKeySearch;
        [_tf becomeFirstResponder];
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
    
    [self.tf resignFirstResponder];
    
    if (self.searchBlock) {
        
        self.searchBlock(self.tf.text);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.backBtn];
        [self addSubview:self.searchView];
        [self addSubview:self.searchBtn];
//        [self setupSegmentView];
        [self addSubview:self.searchImgView];
        
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
        
        [self.searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.segmentView.mas_bottom);
            make.top.equalTo(self.searchView.mas_bottom).offset(10);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setupSegmentView{
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.adjustCoverOrLineWidth = YES;
    style.gradualChangeTitleColor = YES;
    style.scrollTitle = NO;
    style.scrollLineColor = [UIColor colorWithRGB:0xFA6400];
    style.normalTitleColor = [UIColor colorWithRGB:0x000000];
    style.selectedTitleColor = [UIColor colorWithRGB:0xFA6400];
    style.segmentViewBounces = NO;
    style.scaleTitle = YES;
    // 注意: 一定要避免循环引用!!
    ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top, KScreenWidth, 45.0) segmentStyle:style delegate:nil titles:self.titlesArr titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        
        
    }];
    
    self.segmentView = segment;
    self.segmentView.backgroundColor = UIColor.whiteColor;
    [self addSubview:segment];
    
}
@end
