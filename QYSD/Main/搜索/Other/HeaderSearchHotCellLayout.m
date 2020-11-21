//
//  HeaderSearchHotCellLayout.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchHotCellLayout.h"
#import "HotModel.h"

@interface HeaderSearchHotCellLayout ()

@property (nonatomic, assign) CGSize cellSize;

@end

@implementation HeaderSearchHotCellLayout

#pragma mark - 搜索标签
- (instancetype)initWithData:(HotModel *)data {
    
    self = [super init];
    if (self) {
        
        _data = data;
        
        CGFloat min_w = 0;
        CGFloat min_h = 30;
        
        NSAttributedString *attStr = [NSString getAttributedWithString:data.HotKey WithLineSpace:0 kern:0 font:[UIFont systemFontOfSize:12] color:FontColor];
        
        min_w = [NSString getAttWidthWithStr:attStr min_h:min_h]+ 20;
        self.cellSize = CGSizeMake(min_w, min_h);
    }
    return self;
}

@end
