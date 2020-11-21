//
//  HeaderChildCollectionCell.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/8.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderChildCollectionCell.h"
#import "HomeNavigateModel.h"

@interface HeaderChildCollectionCell ()

@property (nonatomic, strong) UILabel *la;
@property (nonatomic, strong) UIImageView *im;

@end

@implementation HeaderChildCollectionCell

- (UILabel *)la{
    
    if (!_la) {
        
        _la = [[UILabel alloc] init];
        _la.text = @"name";
        _la.textAlignment = NSTextAlignmentCenter;
        _la.textColor = FontColor;
        _la.font = [UIFont systemFontOfSize:13];
    }
    return _la;
}

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"img_good01"];
    }
    return _im;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.la];
    [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.im];
    [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.equalTo(self.la.mas_top).offset(-10);
        make.width.equalTo(self.im.mas_height);
        make.centerX.equalTo(self);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HomeNavigateModel *)model{
    
    self.la.text = model.NavigateName;
    [self.im sd_setImageWithURL:model.PicURL.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
}
@end
