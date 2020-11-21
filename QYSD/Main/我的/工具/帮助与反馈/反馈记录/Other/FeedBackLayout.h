//
//  FeedBackLayout.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyFeedBackModel;

@interface FeedBackLayout : NSObject

@property (nonatomic, readonly) CGRect titleRect;
@property (nonatomic, readonly) CGRect contentRect;
@property (nonatomic, readonly) CGRect timeRect;
@property (nonatomic, readonly) CGRect imgsRect;
@property (nonatomic, readonly) CGRect huifuTitleRect;
@property (nonatomic, readonly) CGRect huifuContentRect;
@property (nonatomic, readonly) CGRect huifuTimeRect;

@property (nonatomic, readonly) CGFloat height;

@property (nonatomic, strong) MyFeedBackModel *data;

- (instancetype)initWithData:(MyFeedBackModel*)data;

@end


