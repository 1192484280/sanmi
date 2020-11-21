//
//  InvitationCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "InvitationCell.h"
#import "InvitationChildLayout.h"
#import "InvitationChildModel.h"
#import "NewPagedFlowView.h"
#import "WKWebViewController.h"
@interface InvitationCell ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) UIView *sdView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UILabel *ruleLa;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@end

@implementation InvitationCell


- (NewPagedFlowView *)pageFlowView{
    
    if (!_pageFlowView) {
        
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:_sdView.bounds];
        _pageFlowView.backgroundColor = UIColor.whiteColor;
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = NO;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.leftRightMargin = 60;
        _pageFlowView.topBottomMargin = 100;
    }
    return _pageFlowView;
    
}

- (UILabel *)titleLa{
    
    if (!_titleLa) {
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.text =@"邀请规则";
        _titleLa.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLa;
}

- (UILabel *)ruleLa{
    
    if (!_ruleLa) {
        
        _ruleLa = [[UILabel alloc] init];
        _ruleLa.textColor = UIColor.darkGrayColor;
        _ruleLa.font = [UIFont systemFontOfSize:13];
        _ruleLa.numberOfLines = 0;
    }
    return _ruleLa;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BaseBackGroundColor;
        [self addSubview:self.pageFlowView];
        [self addSubview:self.titleLa];
        [self addSubview:self.ruleLa];
    }
    return self;
}

- (void)setLayout:(InvitationChildLayout *)layout{
    
    _layout = layout;
    self.pageFlowView.frame = layout.sdRect;
    self.titleLa.frame = layout.titleRect;
    self.ruleLa.frame = layout.ruleRect;
    
    self.ruleLa.text = layout.data.ruleStr;
    
    [self.pageFlowView reloadData];
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    
    
    CGFloat height = KScreenWidth * 1.2 - 30;
    CGFloat width = height * 0.57;
    return CGSizeMake(width, height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex{
    
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.layout.data.imgs.count;
    
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.layout.data.imgs[index]] placeholderImage:[UIImage imageNamed:@"img_sdPlaceHoder"]];
    
    return bannerView;
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
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
