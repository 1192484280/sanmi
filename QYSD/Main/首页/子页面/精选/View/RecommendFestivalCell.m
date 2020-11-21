//
//  RecommendFestivalCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/7.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendFestivalCell.h"

@interface RecommendFestivalCell ()

@property (nonatomic, strong) UIImageView *im;

@end

@implementation RecommendFestivalCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
    }
    return _im;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.im];
    [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}

- (void)setImg:(NSString *)img{
    
    self.im.image = [UIImage imageNamed:img];
}
@end
