//
//  SearchAllNetSortView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchAllNetSortView.h"
#import <UIButton+LXMImagePosition.h>

@interface SearchAllNetSortView ()

@property (nonatomic, strong) UIButton *zhongheBtn;
@property (nonatomic, strong) UIButton *saleBtn;
@property (nonatomic, strong) UIButton *qijianBtn;

@property (nonatomic, strong) UIButton *styleBtn;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, copy) NSArray *listArr1;
@property (nonatomic, copy) NSArray *listArr2;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *couIm;
@property (nonatomic, strong) UILabel *couLa;
@property (nonatomic, strong) UISwitch *couSwitch;

@end

@implementation SearchAllNetSortView

- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = BaseBackGroundColor;
    }
    return _lineView;
}
- (UISwitch *)couSwitch{
    
    if (!_couSwitch) {
        
        _couSwitch = [[UISwitch alloc]init];
        _couSwitch.transform=CGAffineTransformMakeScale(0.85,0.85);
        // 添加事件
        [_couSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        _couSwitch.on = NO;
    }
    return _couSwitch;
}

#pragma mark - 开启优惠券过滤
- (void)switchChange:(UISwitch *)sender{
    
    if (self.SwitchBlock) {
        
        self.SwitchBlock(sender.on);
    }
}

- (UIImageView *)couIm{
    
    if (!_couIm) {
        
        _couIm = [[UIImageView alloc] init];
        _couIm.image = [UIImage imageNamed:@"img_quanSwit"];
    }
    return _couIm;
}

- (UILabel *)couLa{
    
    if (!_couLa) {
        _couLa = [[UILabel alloc] init];
        _couLa.text = @"仅显示优惠券商品";
        _couLa.textColor = FontColor;
        _couLa.font = [UIFont systemFontOfSize:12];
        
    }
    return _couLa;
}

#pragma mark - 综合按钮
- (UIButton *)zhongheBtn{
    
    if (!_zhongheBtn) {
        
        _zhongheBtn = [[UIButton alloc] init];
        [_zhongheBtn setTitle:@"综合" forState:UIControlStateNormal];
        [_zhongheBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_zhongheBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_zhongheBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_zhongheBtn addTarget:self action:@selector(onZhongheBtn:) forControlEvents:UIControlEventTouchUpInside];
        _zhongheBtn.selected = YES;
    }
    return _zhongheBtn;
}

- (void)onZhongheBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.saleBtn.selected = NO;
    self.qijianBtn.selected = NO;
    
    if (self.SortBlock) {
        
        self.SortBlock(@"综合",nil);
    }
}

#pragma mark - 销量按钮
- (UIButton *)saleBtn{
    
    if (!_saleBtn) {
        
        _saleBtn = [[UIButton alloc] init];
        [_saleBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_saleBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_saleBtn addTarget:self action:@selector(onSaleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saleBtn;
}

- (void)onSaleBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.zhongheBtn.selected = NO;
    self.qijianBtn.selected = NO;
    
    if (self.SortBlock) {
        
        self.SortBlock(@"销量",nil);
    }
}

#pragma mark - 价格按钮
- (UIButton *)qijianBtn{
    
    if (!_qijianBtn) {
        
        _qijianBtn = [[UIButton alloc] init];
        [_qijianBtn setTitle:@"旗舰" forState:UIControlStateNormal];
        [_qijianBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_qijianBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_qijianBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_qijianBtn addTarget:self action:@selector(onQiJianBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qijianBtn;
}

- (void)onQiJianBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.zhongheBtn.selected = NO;
    self.saleBtn.selected = NO;
    
    if (self.SortBlock) {
        
        self.SortBlock(@"旗舰",nil);
    }
}

#pragma mark - cell风格按钮
- (UIButton *)styleBtn{
    
    if (!_styleBtn) {
        
        _styleBtn = [[UIButton alloc] init];
        [_styleBtn setImage:[UIImage imageNamed:@"img_cellStyleTable"] forState:UIControlStateNormal];
        [_styleBtn setImage:[UIImage imageNamed:@"img_cellStyleCollection"] forState:UIControlStateSelected];
        [_styleBtn addTarget:self action:@selector(onStyleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _styleBtn;
}

- (void)onStyleBtn:(UIButton *)sender{
    
    if (self.SortBlock) {
        
        NSString *str = @"cellStyleCollection";
        if (sender.selected) {
            
            str = @"cellStyleTable";
        }
        self.SortBlock(str,nil);
    }
    sender.selected = !sender.selected;
    
}

#pragma mark - 筛选按钮
- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"img_godSelected"] forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - _selectBtn.imageView.frame.origin.x - _selectBtn.imageView.frame.size.width, 0, 0);
//        _selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(_selectBtn.frame.size.width - _selectBtn.titleLabel.frame.size.width), 0, 0);
        [_selectBtn setImagePosition:LXMImagePositionRight spacing:0];
        [_selectBtn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (void)onSelectBtn:(JTImageButton *)sender{
    
    NSString *str = @"打开筛选";
    if (sender.selected) {
        
        str = @"关闭筛选";
    }
    
    sender.selected = !sender.selected;
    
    if (self.SortBlock) {
        
        self.SortBlock(str,sender);
    }

}

- (NSArray *)listArr1{
    
    if (!_listArr1) {
        
        _listArr1 = @[self.zhongheBtn, self.saleBtn, self.qijianBtn];
    }
    return _listArr1;
}

- (NSArray *)listArr2{
    
    if (!_listArr2) {
        
        _listArr2 = @[self.styleBtn, self.selectBtn];
    }
    return _listArr2;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
                
        UIView *view1 = [[UIView alloc] init];
        [self addSubview:view1];
        
        UIView *view2 = [[UIView alloc] init];
        [self addSubview:view2];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(45);
        }];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.equalTo(view2.mas_left);
            make.height.mas_equalTo(45);
        }];
        
        [view1 addSubview:self.zhongheBtn];
        [view1 addSubview:self.saleBtn];
        [view1 addSubview:self.qijianBtn];
    
        [view2 addSubview:self.styleBtn];
        [view2 addSubview:self.selectBtn];
        
        [self.listArr2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [self.listArr2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        
        [self.listArr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:0 tailSpacing:0];
        [self.listArr1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        
        [self addSubview:self.lineView];
        [self addSubview:self.couIm];
        [self addSubview:self.couLa];
        [self addSubview:self.couSwitch];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(view1.mas_bottom);
        }];
        
        [self.couIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lineView.mas_bottom).offset(10);
            make.height.with.mas_equalTo(20);
        }];
        
        [self.couLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couIm.mas_right).offset(5);
            make.centerY.equalTo(self.couIm);
        }];
        
        [self.couSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- 14);
            make.centerY.equalTo(self.couIm);
//            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

@end
