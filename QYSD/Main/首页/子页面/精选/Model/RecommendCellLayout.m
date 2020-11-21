//
//  RecommendCellLayout.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendCellLayout.h"
#import "RecommendCellModel.h"

@interface RecommendCellLayout ()

@property (nonatomic, assign) CGRect imgRect;
//@property (nonatomic, assign) CGRect storeLogoRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect oldPriceRect;
@property (nonatomic, assign) CGRect nowPriceRect;
@property (nonatomic, assign) CGRect peopleRect;
@property (nonatomic, assign) CGRect couponRect;
@property (nonatomic, assign) CGRect rewardRect;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@end

@implementation RecommendCellLayout

- (instancetype)initWithData:(RecommendCellModel *)data {
    
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
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.imgRect) + margin;
        min_w = 20;
        min_h = 20;
//        self.storeLogoRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = min_view_w - margin *2;
        min_h = 45;
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.titleRect);
        min_w = [[NSString stringWithFormat:@"¥ %@",data.oldPrice] widthForFont:[UIFont systemFontOfSize:11]];
        min_h = 20;
        self.oldPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.oldPriceRect) + 5;
        min_w = [[NSString stringWithFormat:@"¥ %@",data.nowPrice] widthForFont:[UIFont boldSystemFontOfSize:18]] ;
        min_h = 20;
        self.nowPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = self.oldPriceRect.origin.y;
        min_w = [[NSString stringWithFormat:@"%@人已抢",data.people] widthForFont:[UIFont systemFontOfSize:11]] ;
        min_x = min_view_w - 5 - min_w;
        min_h = 20;
        self.peopleRect = CGRectMake(min_x, min_y, min_w, min_h);
    
        min_y = self.nowPriceRect.origin.y;
        min_w = [[NSString stringWithFormat:@"%@元券",data.coupon] widthForFont:[UIFont systemFontOfSize:11]] + 20 ;
        min_h = 20;
        min_x = min_view_w - 5 - min_w;
        self.couponRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = margin;
        min_y = CGRectGetMaxY(self.nowPriceRect) + margin;
        min_w = [[NSString stringWithFormat:@"平台奖励 ¥ %@",data.reward] widthForFont:[UIFont systemFontOfSize:11]] + 25;
        min_h = 22;
        self.rewardRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = CGRectGetMaxY(self.rewardRect) + margin;
        self.width = min_view_w;
    }
    return self;
}

- (instancetype)initWithTableData:(RecommendCellModel *)data {
    
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
        
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_w = KScreenWidth - margin * 2 - min_w - margin;
        min_h = 45;
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.titleRect) + 5;
        min_w = [[NSString stringWithFormat:@"%@元券",data.coupon] widthForFont:[UIFont systemFontOfSize:11]] + 20 ;
        min_h = 20;
        self.couponRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_y = CGRectGetMaxY(self.couponRect) + margin;
        min_w = [[NSString stringWithFormat:@"¥ %@",data.nowPrice] widthForFont:[UIFont boldSystemFontOfSize:18]] ;
        min_h = 20;
        self.nowPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = CGRectGetMaxX(self.nowPriceRect) + margin;
        min_w = [[NSString stringWithFormat:@"¥ %@",data.oldPrice] widthForFont:[UIFont systemFontOfSize:11]];
        min_h = 20;
        self.oldPriceRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_w = [[NSString stringWithFormat:@"%@人已抢",data.people] widthForFont:[UIFont systemFontOfSize:11]] ;
        min_x = min_view_w - 5 - min_w;
        min_h = 20;
        self.peopleRect = CGRectMake(min_x, min_y, min_w, min_h);
    
        min_x = CGRectGetMaxX(self.imgRect) + margin;
        min_y = CGRectGetMaxY(self.nowPriceRect) + margin;
        min_w = [[NSString stringWithFormat:@"平台奖励 ¥ %@",data.reward] widthForFont:[UIFont systemFontOfSize:11]] + 25;
        min_h = 22;
        self.rewardRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = CGRectGetMaxY(self.rewardRect) + margin;
        self.width = min_view_w;
    }
    return self;
}
@end
