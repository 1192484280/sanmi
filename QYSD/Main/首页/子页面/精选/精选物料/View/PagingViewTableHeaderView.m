//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewTableHeaderView.h"

@interface PagingViewTableHeaderView()

@end

@implementation PagingViewTableHeaderView

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
        
        [self addSubview:self.im];
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

@end
