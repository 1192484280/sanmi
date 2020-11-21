//
//  SearchResultSelectedView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SearchResultSelectedView.h"

@interface SearchResultSelectedView ()

@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, strong) UIView *xibView;
@end

@implementation SearchResultSelectedView

- (UIView *)xibView{
    
    if (!_xibView) {
        
        ClassName
        _xibView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return _xibView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
        
        _tf1.keyboardType = UIKeyboardTypeNumberPad;
        _tf2.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.resetBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [self.sureBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    }
    return self;
}

#pragma mark - 点击重置
- (IBAction)onResetBtn:(UIButton *)sender {
    
    self.tf1.text = @"";
    self.tf2.text = @"";
}

#pragma mark - 点击确认
- (IBAction)onSureBtn:(UIButton *)sender {
    
    if (self.sureBlock) {
        
        self.sureBlock(self.tf1.text, self.tf2.text);
    }
}
@end
