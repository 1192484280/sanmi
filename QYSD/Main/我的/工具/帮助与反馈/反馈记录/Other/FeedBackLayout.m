//
//  FeedBackLayout.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "FeedBackLayout.h"
#import "MyFeedBackModel.h"

@interface FeedBackLayout ()

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect timeRect;
@property (nonatomic, assign) CGRect imgsRect;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGRect huifuTitleRect;
@property (nonatomic, assign) CGRect huifuContentRect;
@property (nonatomic, assign) CGRect huifuTimeRect;

@end
@implementation FeedBackLayout

- (instancetype)initWithData:(MyFeedBackModel*)data{
    
    if (self = [super init]) {
        
        _data = data;
        CGFloat margin = 8;
        CGFloat space = 14;
        
        CGFloat min_x = 0;
        CGFloat min_y = 0;
        CGFloat min_w = 0;
        CGFloat min_h = 0;
        
        min_x = space;
        min_y = space;
        min_w = KScreenWidth - 50;
        min_h = 15;
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        NSAttributedString *attTitle = [NSAttributedString new];
        if ([data.FeedbackContent isValid]) {
            
            attTitle = [NSString getAttributedWithString:[NSString stringWithFormat:@"反馈内容：%@",data.FeedbackContent] WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
        }
        
        min_x = space;
        min_y = CGRectGetMaxY(self.titleRect) + margin;
        min_w =  KScreenWidth - margin * 2;
        min_h = [NSString getAttHeightWithStr:attTitle min_w:min_w];
        
        self.contentRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = space;
        min_y = CGRectGetMaxY(self.contentRect) + margin;
        min_w = KScreenWidth - space * 2;
        
        CGFloat oneImgHeight = (min_w - 20) / 3;
        
        if (data.imgArr.count <= 0) {
            
            min_h = 0;
        }
        
        if (data.imgArr.count >0) {
            
            min_h = oneImgHeight;
        }
        
        self.imgsRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = space;
        min_y  = CGRectGetMaxY(self.imgsRect) + margin;
        min_w = KScreenWidth - margin * 2;
        min_h = 15;
        self.timeRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        if (data.IsReplyed == 0) {
            
            self.height = CGRectGetMaxY(self.timeRect) + margin;
        }else{
            
            min_x = space;
            min_y = CGRectGetMaxY(self.timeRect) + space;
            min_w = KScreenWidth - space * 2;
            min_h = 15;
            self.huifuTitleRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            NSAttributedString *huifuContentStr = [NSAttributedString new];
            if ([data.ReplyContent isValid]) {
                
                huifuContentStr = [NSString getAttributedWithString:data.ReplyContent WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
            }
            
            min_x = space;
            min_y = CGRectGetMaxY(self.huifuTitleRect) + margin;
            min_w =  KScreenWidth - space * 2;
            min_h = [NSString getAttHeightWithStr:attTitle min_w:min_w];
            
            self.huifuContentRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = space;
            min_y = CGRectGetMaxY(self.huifuContentRect) + margin;
            min_w = KScreenWidth - space * 2;
            min_h = 15;
            self.huifuTimeRect = CGRectMake(min_x, min_y, min_w, min_h);
            
            self.height = CGRectGetMaxY(self.huifuTimeRect) + margin;
        }
        
    }
    return self;
}

@end
