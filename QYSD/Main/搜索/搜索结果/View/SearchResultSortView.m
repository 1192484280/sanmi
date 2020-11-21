//
//  SearchResultCollectionReusableView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchResultSortView.h"

@interface SearchResultSortView ()
{
    NSData *imgData;
    NSData *currentData;
}
@property (nonatomic, strong) UIButton *zhongheBtn;
@property (nonatomic, strong) UIButton *saleBtn;
@property (nonatomic, strong) UIButton *priceBtn;
@property (nonatomic, strong) UIButton *couponBtn;
@property (nonatomic, strong) UIButton *smBtn;
@property (nonatomic, strong) UIButton *styleBtn;
@property (nonatomic, strong) JTImageButton *selectBtn;

@property (nonatomic, copy) NSArray *listArr1;
@property (nonatomic, copy) NSArray *listArr2;

@end

@implementation SearchResultSortView

#pragma mark - 综合按钮
- (UIButton *)zhongheBtn{
    
    if (!_zhongheBtn) {
        
        _zhongheBtn = [[UIButton alloc] init];
        [_zhongheBtn setTitle:@"综合" forState:UIControlStateNormal];
        [_zhongheBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_zhongheBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_zhongheBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
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
    self.priceBtn.selected = NO;
    self.couponBtn.selected = NO;
    self.smBtn.selected = NO;
    
    [self reSetSmBtn];
    
    if (self.SortBlock) {
        
        self.SortBlock(@"综合排序");
    }
}

#pragma mark - 销量按钮
- (UIButton *)saleBtn{
    
    if (!_saleBtn) {
        
        _saleBtn = [[UIButton alloc] init];
        [_saleBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_saleBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
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
    self.priceBtn.selected = NO;
    self.couponBtn.selected = NO;
    self.smBtn.selected = NO;
   
    [self reSetSmBtn];
    
    if (self.SortBlock) {
        
        self.SortBlock(@"销量排序");
    }
}

#pragma mark - 价格按钮
- (UIButton *)priceBtn{
    
    if (!_priceBtn) {
        
        _priceBtn = [[UIButton alloc] init];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_priceBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_priceBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_priceBtn addTarget:self action:@selector(onPriceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}

- (void)onPriceBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.zhongheBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.couponBtn.selected = NO;
    self.smBtn.selected = NO;
    [self.smBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    [self.smBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
    
    if (self.SortBlock) {
        
        self.SortBlock(@"价格排序");
    }
}

#pragma mark - 券价格按钮
- (UIButton *)couponBtn{
    
    if (!_couponBtn) {
        
        _couponBtn = [[UIButton alloc] init];
        [_couponBtn setTitle:@"券价格" forState:UIControlStateNormal];
        [_couponBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_couponBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_couponBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_couponBtn addTarget:self action:@selector(onCouponBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponBtn;
}

- (void)onCouponBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.zhongheBtn.selected = NO;
    self.priceBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.smBtn.selected = NO;
    
    [self reSetSmBtn];
    
    if (self.SortBlock) {
        
        self.SortBlock(@"券价格排序");
    }
}

#pragma mark - 闪蜜按钮
- (UIButton *)smBtn{
    
    if (!_smBtn) {
        
        CGFloat space = 5;// 图片和文字的间距
        NSString *titleString = [NSString stringWithFormat:@"闪蜜"];
        CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        UIImage *btnImage = [UIImage imageNamed:@"img_sortImg"];// 11*6
        CGFloat imageWidth = btnImage.size.width;
        
        _smBtn = [[UIButton alloc] init];
        [_smBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, imageWidth)];
        [_smBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, -(titleWidth + space*0.5))];
        [_smBtn setTitle:titleString forState:UIControlStateNormal];
        [_smBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_smBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
        [_smBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_smBtn addTarget:self action:@selector(onSMBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smBtn;
}

- (void)onSMBtn:(UIButton *)sender{
    
    if ([currentData isEqual:imgData]) {
        
        currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
        [sender setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateNormal];
        
        if (self.SortBlock) {
            
            self.SortBlock(@"闪蜜降序");
        }
        
    }else{
        
        currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
        [sender setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateNormal];
        
        if (self.SortBlock) {
            
            self.SortBlock(@"闪蜜升序");
        }
    }
    
    self.zhongheBtn.selected = NO;
    self.priceBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.couponBtn.selected = NO;
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
        self.SortBlock(str);
    }
    sender.selected = !sender.selected;

}

#pragma mark - 筛选按钮
- (JTImageButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [[JTImageButton alloc] init];
        [_selectBtn createTitle:@"筛选" withIcon:[UIImage imageNamed:@"img_godSelected"] font:[UIFont systemFontOfSize:13] iconHeight:JTImageButtonIconHeightDefault iconOffsetY:JTImageButtonIconOffsetYNone];
        _selectBtn.borderWidth = 0.0;
        _selectBtn.titleColor = FontColor;
        _selectBtn.iconSide = JTImageButtonIconSideRight;
//        _selectBtn.padding = JTImageButtonPaddingMedium;
        [_selectBtn addTarget:self action:@selector(onSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (void)onSelectBtn:(JTImageButton *)sender{
    
    NSString *str = @"打开筛选";
    if (sender.selected) {
        
        str = @"关闭筛选";
    }
    
    if (self.SortBlock) {
        
        self.SortBlock(str);
    }
    
    sender.selected = !sender.selected;
    
}

- (NSArray *)listArr1{
    
    if (!_listArr1) {
        
        _listArr1 = @[self.zhongheBtn, self.saleBtn, self.priceBtn, self.couponBtn, self.smBtn];
    }
    return _listArr1;
}

- (NSArray *)listArr2{
    
    if (!_listArr2) {
        
        _listArr2 = @[self.styleBtn, self.selectBtn];
    }
    return _listArr2;
}

//闪蜜按钮复原
- (void)reSetSmBtn{
    
    [self.smBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    [self.smBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
    currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        imgData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
        
        UIView *view1 = [[UIView alloc] init];
        [self addSubview:view1];
        
        UIView *view2 = [[UIView alloc] init];
        [self addSubview:view2];
        
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(100);
        }];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.equalTo(view2.mas_left);
        }];
        
        [view1 addSubview:self.zhongheBtn];
        [view1 addSubview:self.saleBtn];
        [view1 addSubview:self.priceBtn];
        [view1 addSubview:self.couponBtn];
        [view1 addSubview:self.smBtn];
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
        
    }
    return self;
}


@end
