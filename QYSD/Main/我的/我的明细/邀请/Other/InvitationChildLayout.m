//
//  InvitationChildLayout.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "InvitationChildLayout.h"
#import "InvitationChildModel.h"

@interface InvitationChildLayout ()

@property (nonatomic, assign) CGRect sdRect;
@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect ruleRect;
@property (nonatomic, assign) CGFloat height;

@end

@implementation InvitationChildLayout

- (instancetype)initWithData:(InvitationChildModel *)data{
    
    self = [super init];
    if (self) {
        
        _data = data;
        
        CGFloat margin = 8;
        
        CGFloat min_x = 0;
        CGFloat min_y = 0;
        CGFloat min_w = 0;
        CGFloat min_h = 0;
        
        min_w = KScreenWidth;
        min_h  = KScreenWidth * 1.2;
        self.sdRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = 14;
        min_y = CGRectGetMaxY(self.sdRect) + margin;
        min_w = 150;
        min_h = 25;
        
        self.titleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        min_x = 14;
        min_y = CGRectGetMaxY(self.titleRect) + margin;
        min_w = KScreenWidth - min_x *2;
        min_h = [self.data.ruleStr heightForFont:[UIFont systemFontOfSize:13] width:min_w];
        
        self.ruleRect = CGRectMake(min_x, min_y, min_w, min_h);
        
        self.height = CGRectGetMaxY(self.ruleRect) + margin * 3;
    }
    return self;
    
}
@end
