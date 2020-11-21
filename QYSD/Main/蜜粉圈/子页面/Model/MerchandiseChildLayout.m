//
//  MerchandiseChildLayout.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MerchandiseChildLayout.h"
#import "MerchandiseModel.h"

@interface MerchandiseChildLayout ()

@property (nonatomic, assign) CGRect logoRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect timeRect;
@property (nonatomic, assign) CGRect downBtnRect;
@property (nonatomic, assign) CGRect shareBtnRect;
@property (nonatomic, assign) CGRect desRect;
@property (nonatomic, assign) CGRect imgsRect;
@property (nonatomic, assign) CGRect zfNumRect;
@property (nonatomic, assign) CGRect copysStoreUrlRect;
//@property (nonatomic, assign) CGRect copysReduceUrlRect;
@property (nonatomic, assign) CGRect copysStoreBtnRect;
//@property (nonatomic, assign) CGRect copysReduceBtnRect;
@property (nonatomic, assign) CGRect copysBgViewRect;
@property (nonatomic, assign) CGFloat height;

@end

@implementation MerchandiseChildLayout

- (instancetype)initWithData:(MerchandiseModel*)data ifCopy:(BOOL)ifCopy{
    
    if (self = [super init]) {
    
        _data = data;
        CGFloat margin = 8;
        CGFloat space = 14;
        
        CGFloat min_x = space;
        CGFloat min_y = space;
        CGFloat min_w = 35;
        CGFloat min_h = 35;
        self.logoRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSAttributedString *attTitle = [NSAttributedString new];
        if ([data.PublisherName isValid]) {
            
            attTitle = [NSString getAttributedWithString:data.PublisherName WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
        }
        
        min_x = CGRectGetMaxX(self.logoRect) + margin;
        min_y = space;
        min_h =  20;
        min_w = [NSString getAttHeightWithStr:attTitle min_w:min_h] + 50;
        
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.titleRect);
        min_w = [data.PublishTime widthForFont:[UIFont fontWithName:FONTNAME size:12]];
        min_h =  15;
        self.timeRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = 79.5;
        min_x = KScreenWidth - margin - min_w;
        min_y = 16;
        min_h =  28;
        self.shareBtnRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = 28;
        min_x = min_x - margin - min_w ;
        min_y = 16;
        min_h =  28;
        self.downBtnRect = CGRectMake(min_x, min_y, min_w, min_h);
    
        min_x = space;
        min_y = CGRectGetMaxY(self.logoRect)+ margin;
        min_w = KScreenWidth - space*2;
        NSAttributedString *attStr = [NSString getAttStrWithHtml:data.ContentHtml];
        
        min_h =  [NSString getAttHeightWithStr:attStr min_w:min_w];
        
        self.desRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = space;
        min_y = CGRectGetMaxY(self.desRect) + margin;
        min_w = KScreenWidth - space * 2;
        
        CGFloat oneImgHeight = (min_w - 20) / 3;
        
        if (data.imgArr.count <= 0) {
            
            min_h = 0;
        }else{
            
            NSInteger yushu = (data.imgArr.count % 3);
            if (yushu == 0) {
                
                min_h = ((data.imgArr.count / 3)) * (oneImgHeight + 10) - 10;
            }else{
                
                min_h = ((data.imgArr.count / 3) +1) * oneImgHeight + 10 *(data.imgArr.count / 3);
            }
        }
        
        self.imgsRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSString *zfNum = [NSString stringWithFormat:@"%ld次转发",(long)data.ForwardsNumber];
        if (data.ForwardsNumber >= 10000) {
            
            CGFloat a = data.ForwardsNumber / 10000.0;
            zfNum = [NSString stringWithFormat:@"%.1f万次转发",a];
        }
        
        NSAttributedString *attZfNum = [NSAttributedString new];
        if ([zfNum isValid]) {
            
            attZfNum = [NSString getAttributedWithString:zfNum WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:14] color:FontColor];
        }
        
        min_x = space;
        min_y = CGRectGetMaxY(self.imgsRect) + margin;
        min_h =  20;
        min_w = [NSString getAttWidthWithStr:attZfNum min_h:min_h];
        
        if (data.imgArr.count <= 0) {
            
            self.zfNumRect = CGRectMake(min_x, CGRectGetMaxY(self.desRect), min_w, min_h);
        }else{
            
            self.zfNumRect = CGRectMake(min_x, min_y, min_w, min_h);
        }
        
        self.height = CGRectGetMaxY(self.zfNumRect) + space;
        
        if (![data.ProductTKL isValid]) return self;
        NSString *koulingStr = [NSString stringWithFormat:@"【购买步骤】长按识别二维码—复制淘口令—点开手机【淘宝】领券下单   復→制此评论，%@，开启【淘宝】即可够买",data.ProductTKL];
        
        NSAttributedString *attKouLing = [NSString getAttributedWithString:koulingStr WithLineSpace:2 kern:0 font:[UIFont systemFontOfSize:13] color:FontColor];

        min_x = space + margin;
        min_y = CGRectGetMaxY(self.zfNumRect) + margin * 2;
        min_w = KScreenWidth - space * 2 - margin*2;
        min_h =  [NSString getAttHeightWithStr:attKouLing min_w:min_w];
        
        self.copysStoreUrlRect = CGRectMake(min_x, min_y, min_w, min_h);
        self.copysStoreBtnRect = CGRectMake(KScreenWidth - space - margin - 95, CGRectGetMaxY(self.copysStoreUrlRect) + margin, 95, 28);
        self.copysBgViewRect = CGRectMake(space, min_y - margin, KScreenWidth - space * 2, min_h + self.copysStoreBtnRect.size.height + margin * 2 +space);
        self.height = CGRectGetMaxY(self.copysBgViewRect) + space;
        
        
    }
    return self;
}
@end
