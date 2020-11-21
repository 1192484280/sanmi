//
//  HeaderSearchCollectionViewCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchCollectionViewCell.h"
#import "HeaderSearchHotCellLayout.h"
#import "HotModel.h"

@interface HeaderSearchCollectionViewCell ()

@property (nonatomic, strong) UILabel *la;

@end

@implementation HeaderSearchCollectionViewCell

- (UILabel *)la{
    
    if (!_la) {
    
        _la = [[UILabel alloc] init];
        _la.textAlignment = NSTextAlignmentCenter;
    
    }
    return _la;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 5;
        [self addSubview:self.la];
        
        [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setLayout:(HeaderSearchHotCellLayout *)layout{
    
    self.la.attributedText = [NSString getAttributedWithString:layout.data.HotKey WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
    self.la.textAlignment = NSTextAlignmentCenter;
    
    if (layout.data.KeyType == 1) {
        
        self.la.textColor = SMOrangeColor;
    }
    
}

@end
