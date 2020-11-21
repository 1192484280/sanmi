//
//  CustomSecretView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/4.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CustomSecretView.h"

@interface CustomSecretView ()

@property (nonatomic, strong) UIView *xibView;

@property (weak, nonatomic) IBOutlet UIButton *theSetBtn;


@end

@implementation CustomSecretView

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
        
        self.theSetBtn.layer.cornerRadius = 10;
        self.theSetBtn.layer.masksToBounds = YES;
        [self.theSetBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FEBF38"],[UIColor colorWithHexString:@"F88222"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
    }
    return self;
}
- (IBAction)onSetBtn:(UIButton *)sender {
    
    NSLog(@"");
}

@end
