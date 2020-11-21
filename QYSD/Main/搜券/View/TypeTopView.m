//
//  TypeTopView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TypeTopView.h"
#import "HeaderSearchViewController.h"

@interface TypeTopView ()

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *desLa;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *searchIm;
@property (nonatomic, strong) UILabel *searchLa;

@end

@implementation TypeTopView

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont boldSystemFontOfSize:25];
        _titleLa.textColor = UIColor.blackColor;
        _titleLa.text = @"搜券入口";
    }
    return _titleLa;
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        _desLa.font = [UIFont systemFontOfSize:15];
        _desLa.textColor = UIColor.blackColor;
        _desLa.text = @"搜索淘宝 / 天猫商品";
    }
    return _desLa;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColor.blackColor;
    }
    return _line;
}

- (UIView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[UIView alloc] init];
        _searchView.backgroundColor = UIColor.whiteColor;
        _searchView.layer.cornerRadius = 15;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSearch)];
        [_searchView addGestureRecognizer:tap];
    }
    return _searchView;
}

- (void)onSearch{
    
    HeaderSearchViewController *vc = [[HeaderSearchViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)searchIm{
    
    if (!_searchIm) {
        
        _searchIm = [[UIImageView alloc] init];
        _searchIm.image = [UIImage imageNamed:@"img_search"];
    }
    return _searchIm;
}

- (UILabel *)searchLa{
    
    if (!_searchLa) {
        
        _searchLa = [[UILabel alloc] init];
        _searchLa.font = [UIFont systemFontOfSize:13];
        _searchLa.textColor = UIColor.lightGrayColor;
        _searchLa.text = @"粘贴宝贝标题，先领券再购买";
    }
    return _searchLa;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [self addSubview:self.titleLa];
        [self addSubview:self.desLa];
        [self addSubview:self.line];
        [self addSubview:self.searchView];
        [self.searchView addSubview:self.searchIm];
        [self .searchView addSubview:self.searchLa];
        
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(14);
            make.right.mas_offset(-14);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(-20);
        }];
        
        [self.searchIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(14);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(30);
        }];
        
        [self.searchLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.searchIm.mas_right).offset(8);
            make.top.bottom.right.mas_equalTo(0);
        }];
        
        [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.bottom.equalTo(self.searchView.mas_top).offset(-14);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLa.mas_right).offset(10);
            make.width.mas_equalTo(2);
            make.height.mas_equalTo(15);
            make.bottom.equalTo(self.searchView.mas_top).offset(-14);
        }];
        
        [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.line.mas_right).offset(10);
            make.bottom.equalTo(self.searchView.mas_top).offset(-14);
        }];
    }
    return self;
}

@end
