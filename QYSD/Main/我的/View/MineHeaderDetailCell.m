//
//  MineHeaderDetailCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MineHeaderDetailCell.h"

@interface MineHeaderDetailCell ()



@end
@implementation MineHeaderDetailCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] initWithFrame:self.bounds];
        _im.layer.cornerRadius = 8;
        _im.layer.masksToBounds = YES;
        
    }
    return _im;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.im];
    }
    return self;
}

@end
