//
//  RecommendFourCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/12.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendFourCell.h"
#import "HomejxwlModel.h"

@interface RecommendFourCell()

@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *desLa;
@property (nonatomic, strong) UIImageView *im;
@property (nonatomic, strong) UILabel *goLa;

@end

@implementation RecommendFourCell

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont boldSystemFontOfSize:20];
        _titleLa.textColor = FontColor;
    }
    return _titleLa;
}

- (UILabel *)desLa{
    
    if (!_desLa) {
        
        _desLa = [[UILabel alloc] init];
        _desLa.font = [UIFont systemFontOfSize:10];
        _desLa.textColor = FontColor;
    }
    return _desLa;
}

- (UIImageView *)im{
    
    if (!_im) {
        
        _im = [[UIImageView alloc] init];
        _im.image = [UIImage imageNamed:@"img_festivalStore_06"];
    }
    return _im;
}

- (UILabel *)goLa{
    
    if (!_goLa) {
        
        _goLa = [[UILabel alloc] init];
        _goLa.text = @"Go>";
        _goLa.font = [UIFont systemFontOfSize:12];
        _goLa.textColor = UIColor.whiteColor;
        _goLa.backgroundColor = UIColor.redColor;
        _goLa.layer.cornerRadius = 5;
        _goLa.layer.masksToBounds = YES;
        _goLa.textAlignment = NSTextAlignmentCenter;
    }
    return _goLa;
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
    
//    [self addSubview:self.titleLa];
//    [self addSubview:self.desLa];
//    [self addSubview:self.im];
//    [self addSubview:self.goLa];
//
//    [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.mas_equalTo(20);
//    }];
//
//    [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.top.equalTo(self.titleLa.mas_bottom).offset(5);
//    }];
//
//    CGFloat im_h = self.height - 20 *2;
//    CGFloat im_scale = 0.8;
//    CGFloat im_w = im_h * im_scale;
//
//    [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-8);
//        make.centerY.equalTo(self);
//        make.top.mas_equalTo(20);
//        make.width.mas_equalTo(im_w);
//    }];
//
//    [self.goLa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.bottom.mas_equalTo(-10);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(18);
//    }];
    
    [self addSubview:self.im];
    [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setModel:(HomejxwlModel *)model{
    
//    self.titleLa.text = model.NavigateName;
//    self.desLa.text = model.des;
//    self.goLa.backgroundColor = [UIColor colorWithHexString:model.colorStr];
    [self.im sd_setImageWithURL:model.PicURL.mj_url placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
