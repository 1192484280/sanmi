//
//  ProductInfoLayout.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductInfoLayout.h"
#import "ProductDetailModel.h"

@interface ProductInfoLayout ()

@property (nonatomic, assign) CGRect bgOneRect;
@property (nonatomic, assign) CGRect fuhaoRect;
@property (nonatomic, assign) CGRect priceRect;
@property (nonatomic, assign) CGRect quanhouRect;
@property (nonatomic, assign) CGRect saleNumRect;
@property (nonatomic, assign) CGRect searchBtnRect;
@property (nonatomic, assign) CGRect desRect;

@property (nonatomic, assign) CGRect quanBgViewRect;

@property (nonatomic, assign) CGRect tuijianBgRect;
@property (nonatomic, assign) CGRect tuijianDesRect;

@property (nonatomic, assign) CGRect storeBgRect;

@property (nonatomic, assign) CGRect commentBgRect;
@property (nonatomic, assign) CGRect comontRect;
@property (nonatomic, assign) CGRect comontIconRect;
@property (nonatomic, assign) CGRect comontNameRect;
@property (nonatomic, assign) CGRect comontDesRect;

@property (nonatomic, assign) CGFloat height;

@end

@implementation ProductInfoLayout

- (instancetype)initWithData:(ProductDetailModel *)data{
    
    if (self = [super init]) {
        
        _data = data;
        
        CGFloat margin = 10;
        
        CGFloat min_x = 0;
        CGFloat min_y = 0;
        CGFloat min_w = 0;
        CGFloat min_h = 0;
        
        min_x = margin;
        min_y = 25;
        min_w = 12;
        min_h = 12;
        self.fuhaoRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSString *price = [NSString stringWithFormat:@"%.2f",[data.ZkFinalPrice floatValue] - [data.CouponAmount floatValue]];
        
        min_x = CGRectGetMaxX(self.fuhaoRect);
        min_y = 13;
        min_w = [price widthForFont:[UIFont boldSystemFontOfSize:25]];
        min_h = 25;
        self.priceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = CGRectGetMaxX(self.priceRect) + 5;
        min_y = 25;
        min_h = 12;
        
        min_w = [[NSString stringWithFormat:@"¥ %.2f",[data.ZkFinalPrice floatValue]] widthForFont:[UIFont systemFontOfSize:13]];
        self.quanhouRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSString *xlStr = [NSString stringWithFormat:@"销量%@",data.Volume];
        if ([data.Volume integerValue] >= 10000) {
            
            CGFloat a = [data.Volume integerValue] / 10000.0;
            xlStr = [NSString stringWithFormat:@"销量%.1f万",a];
        }
        
        NSString *sale = xlStr;
        min_y = 25;
        min_w = [sale widthForFont:[UIFont systemFontOfSize:13]];
        min_h = 12;
        min_x = (KScreenWidth - min_w)/2;
        self.saleNumRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = 15;
        min_w = 65;
        min_h = 20;
        min_x = KScreenWidth -margin - min_w;
        self.searchBtnRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:14];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",data.Title] attributes:nil]];
        
        UIImage *image = [UIImage imageNamed:@"天猫logo"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2.5 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text insertAttributedString:attachText atIndex:0];
        text.yy_lineSpacing = 5;
//        text.yy_kern = @0.5;
        text.yy_font = font;
        
        min_x = 10;
        min_y = CGRectGetMaxY(self.priceRect) + margin;
        min_w = KScreenWidth - 20;
        
        // Create text container
        YYTextContainer *container = [YYTextContainer new];
        container.size = CGSizeMake(min_w, CGFLOAT_MAX);
        container.maximumNumberOfRows = 0;
        
        // Generate a text layout.
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];
        
        min_h = layout.textBoundingSize.height;
        self.desRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = 0;
        min_y = 0;
        min_w = KScreenWidth;
        min_h = CGRectGetMaxY(self.desRect);
        self.bgOneRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = 0;
        min_y = CGRectGetMaxY(self.bgOneRect) + margin;
        min_w = KScreenWidth;
        min_h = 100;
        self.quanBgViewRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_h = 0;
        
        if ([data.ItemDescription isValid]) {
            
            NSMutableAttributedString *tuijianText = [NSMutableAttributedString new];
            UIFont *font = [UIFont systemFontOfSize:14];
            [tuijianText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",data.ItemDescription] attributes:nil]];
            
            UIImage *tuiJianImage = [UIImage imageNamed:@"img_godsdetailRec"];
            tuiJianImage = [UIImage imageWithCGImage:tuiJianImage.CGImage scale:2.5 orientation:UIImageOrientationUp];
            
            NSMutableAttributedString *tuijianAttachText = [NSMutableAttributedString yy_attachmentStringWithContent:tuiJianImage contentMode:UIViewContentModeCenter attachmentSize:tuiJianImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [tuijianText insertAttributedString:tuijianAttachText atIndex:0];
            tuijianText.yy_lineSpacing = 5;
//            tuijianText.yy_kern = @0.5;
            tuijianText.yy_font = font;
            
            min_x = 10;
            min_y = CGRectGetMaxY(self.quanBgViewRect) + margin + 5;
            min_w = KScreenWidth - margin *2;
            
            // Create text container
            YYTextContainer *tuijianContainer = [YYTextContainer new];
            tuijianContainer.size = CGSizeMake(min_w, CGFLOAT_MAX);
            tuijianContainer.maximumNumberOfRows = 0;
            
            // Generate a text layout.
            YYTextLayout *tuiJianlayout = [YYTextLayout layoutWithContainer:tuijianContainer text:tuijianText];
            
            min_h = tuiJianlayout.textBoundingSize.height + 20;
            
            self.tuijianDesRect = CGRectMake(min_x, min_y, min_w, min_h);
            
        }
        min_x = 0;
        min_y = CGRectGetMaxY(self.quanBgViewRect);
        min_w = KScreenWidth;
        
        self.tuijianBgRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_h = 100;
//        if ([data.maijiafuwu isValid]) {
//
//            min_h = 100;
//        }
        
        min_x = 0;
        min_y = CGRectGetMaxY(self.tuijianBgRect);
        if (self.tuijianBgRect.size.height == 0) {
            
            min_y -= 8;
        }
        min_w = KScreenWidth;
        self.storeBgRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        //评论
        CGFloat commentHeight = 0;
        if ([data.commentDes isValid]) {
            
            min_x = margin;
            min_y = CGRectGetMaxY(self.storeBgRect) + margin;
            min_w = 200;
            min_h = 20;
            self.comontRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            commentHeight += min_h;
            
            min_x = margin;
            min_y = CGRectGetMaxY(self.comontRect) + 10;
            min_w = 30;
            min_h = 30;
            self.comontIconRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            commentHeight += min_h;
            
            min_x = CGRectGetMaxX(self.comontIconRect) + 5;
            min_y = CGRectGetMaxY(self.comontRect) + 10;;
            min_w = [data.commentName widthForFont:[UIFont systemFontOfSize:11]];
            min_h = 30;
            self.comontNameRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            commentHeight += min_h;
            
//            min_x = margin;
//            min_y = min_y + 10;
//            min_w = KScreenWidth - margin * 2;
//            min_h = [data.commentDes heightForFont:[UIFont systemFontOfSize:12] width:min_w];
            
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            UIFont *font = [UIFont systemFontOfSize:13];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",data.commentDes] attributes:nil]];
            
            text.yy_lineSpacing = 5;
//            text.yy_kern = @0.5;
            text.yy_font = font;
            
            min_x = margin;
            min_y = CGRectGetMaxY(self.comontNameRect) + margin;
            min_w = KScreenWidth - margin *2;
            
            // Create text container
            YYTextContainer *tuijianContainer = [YYTextContainer new];
            tuijianContainer.size = CGSizeMake(min_w, CGFLOAT_MAX);
            tuijianContainer.maximumNumberOfRows = 0;
            
            // Generate a text layout.
            YYTextLayout *tuiJianlayout = [YYTextLayout layoutWithContainer:tuijianContainer text:text];
            
            min_h = tuiJianlayout.textBoundingSize.height + 20;
            
            self.comontDesRect = CGRectMake(min_x, min_y, min_w, min_h);
        
            commentHeight += min_h;
        }
        
        min_x = 0;
        min_y = CGRectGetMaxY(self.storeBgRect);
        min_w = KScreenWidth;
        self.commentBgRect = CGRectMake(min_x, min_y, min_w, commentHeight);
        
        self.height = CGRectGetMaxY(self.commentBgRect);
    }
    return self;
}

@end
