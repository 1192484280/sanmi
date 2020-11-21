//
//  ProductImgCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductImgCell.h"

@implementation ProductImgCell

- (UIImageView *)im{
    
    if (!_im) {
        _im = [[UIImageView alloc] init];
    }
    return _im;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.im];
        [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
