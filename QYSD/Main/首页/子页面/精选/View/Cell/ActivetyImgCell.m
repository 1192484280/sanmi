//
//  ActivetyImgCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ActivetyImgCell.h"

@interface ActivetyImgCell ()


@end

@implementation ActivetyImgCell

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
//        _im.layer.cornerRadius = 10;
        _im.layer.masksToBounds = YES;
    }
    return _im;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.im];
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

@end
