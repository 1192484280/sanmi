//
//  HeaderSearchImgView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchImgView.h"
//#import "WKWebViewController.h"

@interface HeaderSearchImgView ()

@property (nonatomic, strong) UILabel *la;
@property (nonatomic, strong) UIImageView *im1;
@property (nonatomic, strong) UIImageView *im2;
@property (nonatomic, strong) UIImageView *im3;
@property (nonatomic, strong) UILabel *la1;
@property (nonatomic, strong) UILabel *la2;
@property (nonatomic, strong) UILabel *la3;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation HeaderSearchImgView

- (UILabel *)la{
    
    if (!_la) {
        
        _la = [[UILabel alloc] init];
       
        _la.attributedText = [NSString getAttributedWithString:@"点我查看详情>" WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:12] color:SMOrangeColor];
    }
    return _la;
}

- (UIImageView *)im1{
    
    if (!_im1) {
        
        _im1 = [[UIImageView alloc] init];
        _im1.image = [UIImage imageNamed:@"icon_taobao"];
    }
    return _im1;
}

- (UILabel *)la1{
    
    if (!_la1) {
        
        _la1 = [[UILabel alloc] init];
        _la1.attributedText = [NSString getAttributedWithString:@"在淘宝复制\n商品标题" WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
        _la1.numberOfLines = 0;
        
    }
    return _la1;
}

- (UIImageView *)im2{
    
    if (!_im2) {
        
        _im2 = [[UIImageView alloc] init];
        _im2.image = [UIImage imageNamed:@"smlogo"];
        _im2.layer.cornerRadius = 2;
        _im2.layer.masksToBounds = YES;
    }
    return _im2;
}

- (UILabel *)la2{
    
    if (!_la2) {
        
        _la2 = [[UILabel alloc] init];
        _la2.attributedText = [NSString getAttributedWithString:@"打开闪蜜出\n现搜索弹窗" WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
        _la2.numberOfLines = 0;
    }
    return _la2;
}

- (UIImageView *)im3{
    
    if (!_im3) {
        
        _im3 = [[UIImageView alloc] init];
        _im3.image = [UIImage imageNamed:@"icon_shangpin"];
    }
    return _im3;
}

- (UILabel *)la3{
    
    if (!_la3) {
        
        _la3 = [[UILabel alloc] init];
        _la3.attributedText = [NSString getAttributedWithString:@"选择对应搜索按钮\n搜索对应商品优惠" WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
        _la3.numberOfLines = 0;
        
    }
    return _la3;
}

- (UIView *)line1{
    
    if (!_line1){
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
    }
    return _line1;
}

- (UIView *)line2{
    
    if (!_line2){
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"FA6400"];
    }
    return _line2;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self addSubview:self.la];
        [self addSubview:self.im1];
        [self addSubview:self.im2];
        [self addSubview:self.im3];
        [self addSubview:self.la1];
        [self addSubview:self.la2];
        [self addSubview:self.la3];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        
        CGFloat spading = 10;
//        [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.im3);
//            make.top.mas_equalTo(spading);
//            make.height.mas_equalTo(15);
//        }];
        
        [self.im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spading * 3);
            make.top.mas_equalTo(spading);
            make.height.width.mas_equalTo(40);
        }];
        
        [self.im2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.im1);
            make.height.width.mas_equalTo(32);
        }];
        
        [self.im3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- spading * 3);
            make.centerY.equalTo(self.im1);
            make.height.width.mas_equalTo(40);
        }];
        
        [self.la1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.im1.mas_bottom).offset(2);
            make.left.equalTo(self.im1);
            make.height.mas_equalTo(40);
        }];
        
        [self.la2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.la1);
            make.centerX.equalTo(self.im2);
            make.height.mas_equalTo(40);
        }];
        
        [self.la3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.la1);
            make.right.equalTo(self.im3);
            make.height.mas_equalTo(40);
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.im1.mas_right).offset(spading);
            make.right.equalTo(self.im2.mas_left).offset(-spading);
            make.centerY.equalTo(self.im1);
            make.height.mas_equalTo(1);
        }];
        
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.im2.mas_right).offset(spading);
            make.right.equalTo(self.im3.mas_left).offset(-spading);
            make.centerY.equalTo(self.im1);
            make.height.mas_equalTo(1);
        }];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

//- (void)onTap{
//    
//    WKWebViewController *VC = [[WKWebViewController alloc]init];
//    [self.viewController.navigationController pushViewController:VC animated:YES];
//}
@end
