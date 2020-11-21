//
//  GoodsCellLayout.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "GoodsCellLayout.h"
#import "GoodsModel.h"

@interface GoodsCellLayout ()

@property (nonatomic, assign) CGRect imgRect;
@property (nonatomic, assign) CGRect storeNameRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect topTitleRect;
@property (nonatomic, assign) CGRect oldPriceRect;
@property (nonatomic, assign) CGRect nowPriceRect;
@property (nonatomic, assign) CGRect peopleRect;
@property (nonatomic, assign) CGRect couponRect;
//@property (nonatomic, assign) CGRect rewardRect;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@end

@implementation GoodsCellLayout

- (instancetype)initWithCollectionData:(GoodsModel *)data{
    
    self = [super init];
    if (self) {
        
        _data = data;
        
        CGFloat min_x = 0;
        CGFloat min_y = 0;
        CGFloat min_w = 0;
        CGFloat min_h = 0;
        CGFloat min_view_w = (KScreenWidth - 30) / 2;
        CGFloat margin = 10;
        
        self.imgRect = CGRectMake(min_x, min_y, min_view_w, min_view_w);
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:13];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" 随随便便打出两行以上字，以便出现一行文字的影响整体布局随随便便打出两行以上字，以便出现一行文字的影响整体布局随随便便打出两行以上字，以便出现一行文字的影响整体布局" attributes:nil]];
        
        UIImage *image = [UIImage imageNamed:@"天猫logo"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text insertAttributedString:attachText atIndex:0];
        text.yy_lineSpacing = 2;
//        text.yy_kern = @0.5;
        text.yy_font = font;
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.imgRect) + 5;
        min_w = min_view_w - margin *2;
        
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(min_w, CGFLOAT_MAX);
        container.maximumNumberOfRows = 2;
        
        // Generate a text layout.
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        min_h = layout.textBoundingSize.height;
        
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.titleRect) + 8;
        min_w = [data.ShopTitle widthForFont:[UIFont systemFontOfSize:12]];
        min_h = 15;
        self.storeNameRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.storeNameRect) + 5;
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue]] widthForFont:[UIFont systemFontOfSize:13]];
        min_h = 15;
        self.oldPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSString *nowStr = [NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue] - [data.CouponAmount floatValue]];
        min_x = margin;
        min_y = CGRectGetMaxY(self.oldPriceRect) + margin;
        min_w = [nowStr widthForFont:[UIFont boldSystemFontOfSize:18]] ;
        min_h = [nowStr heightForFont:[UIFont boldSystemFontOfSize:18] width:min_w];
        self.nowPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = self.oldPriceRect.origin.y;
        min_w = [[NSString stringWithFormat:@"%@人已抢",data.Volume] widthForFont:[UIFont systemFontOfSize:13]] ;
        min_x = min_view_w - 5 - min_w;
        min_h = 15;
        self.peopleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = self.nowPriceRect.origin.y;
        min_w = [[NSString stringWithFormat:@"%@元",data.CouponAmount] widthForFont:[UIFont systemFontOfSize:11]] + 10  + 20;
        min_h = 20;
        min_x = min_view_w - 5 - min_w;
        self.couponRect = CGRectMake(min_x, min_y, min_w, min_h);
        
//        min_x = margin;
//        min_y = CGRectGetMaxY(self.nowPriceRect) + margin;
//        min_w = [[NSString stringWithFormat:@"平台奖励 ¥ %.2f",[data.PlatFormBonus floatValue]] widthForFont:[UIFont systemFontOfSize:11]] + 25;
//        min_h = 22;
//        self.rewardRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = CGRectGetMaxY(self.couponRect) + margin;
        self.width = min_view_w;
    }
    return self;
}

- (instancetype)initWithTabData:(GoodsModel *)data{
    
    self = [super init];
    if (self) {
        
        _data = data;
        
        CGFloat min_view_w = (KScreenWidth - 20);
        CGFloat margin = 10;
        
        CGFloat min_x = margin;
        CGFloat min_y = margin;
        CGFloat min_w = 132;
        CGFloat min_h = 132;
        
        self.imgRect = CGRectMake(min_x, min_y, min_w, min_h);
        
//        min_x = CGRectGetMaxX(self.imgRect) + margin;;
//        min_w = 30;
//        min_h = 15;
//        self.storeLogoRect = CGRectMake(min_x, min_y, min_w, min_h);
//
//        min_w = KScreenWidth - margin * 3 - 132 - 20;
//        min_h = [@"一行字" heightForFont:[UIFont systemFontOfSize:13] width:min_w] * 2 + 15;
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:13];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",data.Title] attributes:nil]];
        
        UIImage *image = [UIImage imageNamed:@"天猫logo"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text insertAttributedString:attachText atIndex:0];
        text.yy_lineSpacing = 2;
//        text.yy_kern = @0.5;
        text.yy_font = font;
        
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_w = KScreenWidth - margin * 3 - 132 - 20;
        
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(min_w, CGFLOAT_MAX);
        container.maximumNumberOfRows = 2;
        
        // Generate a text layout.
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        min_h = layout.textBoundingSize.height;
        
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.titleRect) + margin;
        min_w = [[NSString stringWithFormat:@"%@元",data.CouponAmount] widthForFont:[UIFont systemFontOfSize:11]] + 10  + 20;
        min_h = 20;
        self.couponRect = CGRectMake(min_x, min_y, min_w, min_h);
        
//        min_x = CGRectGetMaxX(self.imgRect) + margin;
//        min_y = CGRectGetMaxY(self.imgRect) - 22;
//        min_w = [[NSString stringWithFormat:@"平台奖励 ¥ %.2f",[data.PlatFormBonus floatValue]] widthForFont:[UIFont systemFontOfSize:11]] + 25;
//        min_h = 22;
//        self.rewardRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.imgRect) - 20;;
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue] - [data.CouponAmount floatValue]] widthForFont:[UIFont boldSystemFontOfSize:18]];
        min_h = 20;
        self.nowPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = self.nowPriceRect.origin.y - margin - 15;
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue]] widthForFont:[UIFont systemFontOfSize:13]];
        min_h = 15;
        self.oldPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = [[NSString stringWithFormat:@"%@人已抢",data.Volume] widthForFont:[UIFont systemFontOfSize:13]] ;
        min_x = min_view_w - margin - min_w;
        min_h = 15;
        if (![data.Volume isValid]) {
            
            min_h = 0;
        }
        self.peopleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        
        min_y = self.couponRect.origin.y;
        min_w = [data.ShopTitle widthForFont:[UIFont systemFontOfSize:12]];
        min_x = min_view_w - margin - min_w;
        min_h = 20;
        self.storeNameRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = 132 + margin * 2;
        self.width = min_view_w;
    }
    return self;
}

#pragma mark - 实时榜单
- (instancetype)initWithTopTabData:(GoodsModel *)data{
    
    self = [super init];
    if (self) {
        
        _data = data;
        
        CGFloat min_view_w = (KScreenWidth - 20);
        CGFloat margin = 10;
        
        CGFloat min_x = margin;
        CGFloat min_y = margin;
        CGFloat min_w = 132;
        CGFloat min_h = 132;
        
        self.imgRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSMutableAttributedString *topText = [NSMutableAttributedString new];
        [topText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"近两小时成交 %@ ",data.Volume] attributes:nil]];
        topText.yy_font = [UIFont systemFontOfSize:14];
        
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_w = KScreenWidth - margin * 3 - 132 - 20;
        // Create text container
        YYTextContainer *topContainer = [YYTextContainer new];
        topContainer.size = CGSizeMake(min_w, CGFLOAT_MAX);
        topContainer.maximumNumberOfRows = 1;
        
        // Generate a text layout.
        YYTextLayout *topLayout = [YYTextLayout layoutWithContainer:topContainer text:topText];
        
        min_h = topLayout.textBoundingSize.height;
        
        min_h = 15;
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_w = KScreenWidth - margin * 3 - 132 - 20;
        self.topTitleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:13];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",data.Title] attributes:nil]];
        
        UIImage *image = [UIImage imageNamed:@"天猫logo"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text insertAttributedString:attachText atIndex:0];
        text.yy_lineSpacing = 2;
        text.yy_font = font;
        
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_w = KScreenWidth - margin * 3 - 132 - 20;
        min_y = CGRectGetMaxY(self.topTitleRect) + margin;
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(min_w, CGFLOAT_MAX);
        container.maximumNumberOfRows = 2;
        
        // Generate a text layout.
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        min_h = layout.textBoundingSize.height;
        
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
    
        //        min_x = CGRectGetMaxX(self.imgRect) + margin;
        //        min_y = CGRectGetMaxY(self.imgRect) - 22;
        //        min_w = [[NSString stringWithFormat:@"平台奖励 ¥ %.2f",[data.PlatFormBonus floatValue]] widthForFont:[UIFont systemFontOfSize:11]] + 25;
        //        min_h = 22;
        //        self.rewardRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.imgRect) - 20;;
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue] - [data.CouponAmount floatValue]] widthForFont:[UIFont boldSystemFontOfSize:18]];
        min_h = 20;
        self.nowPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue]] widthForFont:[UIFont systemFontOfSize:13]];
        min_h = 15;
        min_y = self.nowPriceRect.origin.y - min_h - 8;
        self.oldPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
//        min_w = [[NSString stringWithFormat:@"%@人已抢",data.Volume] widthForFont:[UIFont systemFontOfSize:11]] ;
//        min_x = min_view_w - margin - min_w;
//        min_h = 15;
//        self.peopleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = [[NSString stringWithFormat:@"%@元",data.CouponAmount] widthForFont:[UIFont systemFontOfSize:11]] + 10  + 20;
        min_h = 20;
        min_y = self.nowPriceRect.origin.y;
        min_x = min_view_w - margin - min_w;
        self.couponRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.titleRect) + 8;
        min_w = [data.ShopTitle widthForFont:[UIFont systemFontOfSize:12]];
        min_x = min_view_w - margin - min_w;
        min_h = 15;
        self.storeNameRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = 132 + margin * 2;
        self.width = min_view_w;
    }
    return self;
}
@end
