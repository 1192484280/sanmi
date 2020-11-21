//
//  ProductNewsListView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/20.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductNewsListView.h"
#import "SGAdvertScrollView.h"
#import "TheModel.h"

@interface ProductNewsListView ()

@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, strong) SGAdvertScrollView *newsListView;

@end

@implementation ProductNewsListView

- (SGAdvertScrollView *)newsListView{
    
    if (!_newsListView) {
        
        _newsListView = [[SGAdvertScrollView alloc] init];
    }
    return _newsListView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.layer.cornerRadius = 12;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i< 10; i ++) {
        
        TheModel *model = [[TheModel alloc] init];
        model.title = [NSString stringWithFormat:@"李%d   五分钟前领券购买了该商品",i];
        model.img = @"img_smalHeader";
        [arr addObject:model];
    }
    [self addSubview:self.newsListView];
    self.newsListView.listArr = arr;
    [self.newsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.bottom.right.mas_equalTo(0);
    }];
}

- (void)setListArr:(NSArray *)listArr{
    
    _datas = listArr;
}
@end
