//
//  CollectorBottomView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/12.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CollectorBottomView.h"

@interface CollectorBottomView ()

@property (nonatomic, strong)  UIButton *deleteBtn;

@end

@implementation CollectorBottomView

- (UIButton *)selectedBtn{
    
    if (!_selectedBtn) {
        
        _selectedBtn = [[UIButton alloc] init];
        [_selectedBtn setImage:[UIImage imageNamed:@"img_photonormalAll"] forState:UIControlStateNormal];
        [_selectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"img_photoSelectedAll"] forState:UIControlStateSelected];
        [_selectedBtn setTitle:@"全选" forState:UIControlStateSelected];
        [_selectedBtn setTitleColor:FontColor forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_selectedBtn addTarget:self action:@selector(onSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectedBtn;
}

#pragma mark - 点击全选
- (void)onSelectedBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (self.selectedBlock) {
        
        self.selectedBlock(sender.selected);
    }
}

- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_deleteBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"E0204E"],[UIColor colorWithHexString:@"FA6400"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _deleteBtn.layer.cornerRadius = 14;
        _deleteBtn.layer.masksToBounds = YES;
        [_deleteBtn addTarget:self action:@selector(onDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteBtn;
}

#pragma mark - 点击删除
- (void)onDeleteBtn:(UIButton *)sender{
    
    if (self.deleteBlock) {
        
        self.deleteBlock();
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.selectedBtn];
        [self addSubview:self.deleteBtn];
        
        [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (10);
            make.top.mas_equalTo(8);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo (-10);
            make.centerY.equalTo(self.selectedBtn);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(28);
        }];
    }
    return self;
}

@end
