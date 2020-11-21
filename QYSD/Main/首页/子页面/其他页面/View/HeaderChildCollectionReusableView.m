//
//  HeaderChildCollectionReusableView.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderChildCollectionReusableView.h"

@interface HeaderChildCollectionReusableView ()
{
    NSData *imgData;
    NSData *currentData;
}
@property (nonatomic, strong) UIButton *hostBtn;
@property (nonatomic, strong) UIButton *theNewstBtn;
@property (nonatomic, strong) UIButton *saleBtn;
@property (nonatomic, strong) UIButton *priceBtn;
@property (nonatomic, strong) UIButton *moneyBtn;

@property (nonatomic, copy) NSArray *listArr;

@end

@implementation HeaderChildCollectionReusableView

#pragma mark - 人气排序
- (UIButton *)hostBtn{
    
    if (!_hostBtn) {
        
        _hostBtn = [[UIButton alloc] init];
        [_hostBtn setTitle:@"人气" forState:UIControlStateNormal];
        [_hostBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_hostBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_hostBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_hostBtn addTarget:self action:@selector(onHostBtn:) forControlEvents:UIControlEventTouchUpInside];
        _hostBtn.selected = YES;
    }
    return _hostBtn;
}

- (void)onHostBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;
    
    self.moneyBtn.selected = NO;
    self.theNewstBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.priceBtn.selected = NO;
    
    if (self.sortBlock) {
        
        self.sortBlock(@"1");
    }
}

#pragma mark - 最新排序
- (UIButton *)theNewstBtn{
    
    if (!_theNewstBtn) {
        
        _theNewstBtn = [[UIButton alloc] init];
        [_theNewstBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_theNewstBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_theNewstBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_theNewstBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_theNewstBtn addTarget:self action:@selector(onTheNewBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _theNewstBtn;
}

- (void)onTheNewBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        return;
    }
    sender.selected = !sender.selected;

    self.hostBtn.selected = NO;
    self.moneyBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.priceBtn.selected = NO;
    
    if (self.sortBlock) {
        
        self.sortBlock(@"2");
    }
}

#pragma mark - 销量排序
- (UIButton *)saleBtn{
    
    if (!_saleBtn) {
        
        CGFloat space = 5;// 图片和文字的间距
        NSString *titleString = [NSString stringWithFormat:@"销量"];
        CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        UIImage *btnImage = [UIImage imageNamed:@"img_sortImg"];// 11*6
        CGFloat imageWidth = btnImage.size.width;
        
        _saleBtn = [[UIButton alloc] init];
        [_saleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, imageWidth)];
        [_saleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, -(titleWidth + space*0.5))];
        [_saleBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_saleBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_saleBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
        [_saleBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
        [_saleBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_saleBtn addTarget:self action:@selector(onSaleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saleBtn;
}

- (void)onSaleBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        if ([currentData isEqual:imgData]) {
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
        }else{
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
        }
        return;
    }
    
    sender.selected = !sender.selected;
    currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
    [self.priceBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
    [self.moneyBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
    
    self.hostBtn.selected = NO;
    self.theNewstBtn.selected = NO;
    self.moneyBtn.selected = NO;
    self.priceBtn.selected = NO;
}

- (UIButton *)priceBtn{
    
    if (!_priceBtn) {
        
        CGFloat space = 5;// 图片和文字的间距
        NSString *titleString = [NSString stringWithFormat:@"价格"];
        CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        UIImage *btnImage = [UIImage imageNamed:@"img_sortImg"];// 11*6
        CGFloat imageWidth = btnImage.size.width;
        
        _priceBtn = [[UIButton alloc] init];
        [_priceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, imageWidth)];
        [_priceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, -(titleWidth + space*0.5))];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_priceBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_priceBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
        [_priceBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_priceBtn addTarget:self action:@selector(onPriceBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}

#pragma mark - 点击价格排序
- (void)onPriceBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        if ([currentData isEqual:imgData]) {
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
            if (self.sortBlock) {
                
                self.sortBlock(@"3-2");
            }
            
        }else{
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
            
            if (self.sortBlock) {
                
                self.sortBlock(@"3-1");
            }
        }
        return;
    }
    
    sender.selected = !sender.selected;
    currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
//    [self.saleBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
//    [self.moneyBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
    
    if (self.sortBlock) {
        
        self.sortBlock(@"3-2");
    }
    
    self.hostBtn.selected = NO;
    self.theNewstBtn.selected = NO;
//    self.saleBtn.selected = NO;
//    self.moneyBtn.selected = NO;
    
}

- (UIButton *)moneyBtn{
    
    if (!_moneyBtn) {
        
        CGFloat space = 5;// 图片和文字的间距
        NSString *titleString = [NSString stringWithFormat:@"券金额"];
        CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        UIImage *btnImage = [UIImage imageNamed:@"img_sortImg"];// 11*6
        CGFloat imageWidth = btnImage.size.width;
        
        _moneyBtn = [[UIButton alloc] init];
        [_moneyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth+space*0.5), 0, imageWidth)];
        [_moneyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth, 0, -(titleWidth + space*0.5))];
        [_moneyBtn setTitle:@"券金额" forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [_moneyBtn setImage:[UIImage imageNamed:@"img_sortImg"] forState:UIControlStateNormal];
        [_moneyBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
        [_moneyBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_moneyBtn addTarget:self action:@selector(onMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneyBtn;
}

#pragma mark - 点击券金额排序
- (void)onMoneyBtn:(UIButton *)sender{
    
    if (sender.selected) {
        
        if ([currentData isEqual:imgData]) {
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
        }else{
            
            currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
            [sender setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
        }
        return;
    }
    sender.selected = !sender.selected;
    currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
    [self.saleBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
    [self.priceBtn setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
    
    self.hostBtn.selected = NO;
    self.theNewstBtn.selected = NO;
    self.saleBtn.selected = NO;
    self.priceBtn.selected = NO;
}

- (NSArray *)listArr{
    
    if (!_listArr) {
        
//        _listArr = @[self.hostBtn, self.theNewstBtn, self.saleBtn, self.priceBtn, self.moneyBtn];
         _listArr = @[self.hostBtn, self.theNewstBtn, self.priceBtn];
    }
    return _listArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        imgData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
        
        [self addSubview:self.hostBtn];
        [self addSubview:self.theNewstBtn];
        [self addSubview:self.priceBtn];
        
        [self.listArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [self.listArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
        }];

    }
    return self;
}

- (void)setSort:(NSString *)sort{
    
    if ([sort isEqualToString:@"1"]) {
        
        self.hostBtn.selected = YES;
        self.priceBtn.selected = NO;
        self.theNewstBtn.selected = NO;
    }else if ([sort isEqualToString:@"2"]){
        
        self.theNewstBtn.selected = YES;
        self.hostBtn.selected = NO;
        self.priceBtn.selected = NO;
    }else if ([sort isEqualToString:@"3-1"]){
        
        currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg01"]);
        [self.priceBtn setImage:[UIImage imageNamed:@"img_sortImg01"] forState:UIControlStateSelected];
        self.priceBtn.selected = YES;
        self.theNewstBtn.selected = NO;
        self.hostBtn.selected = NO;
        
    }else if ([sort isEqualToString:@"3-2"]){
        
        currentData = UIImagePNGRepresentation([UIImage imageNamed:@"img_sortImg02"]);
        [self.priceBtn setImage:[UIImage imageNamed:@"img_sortImg02"] forState:UIControlStateSelected];
        self.priceBtn.selected = YES;
        self.theNewstBtn.selected = NO;
        self.hostBtn.selected = NO;
        
    }
}
@end
