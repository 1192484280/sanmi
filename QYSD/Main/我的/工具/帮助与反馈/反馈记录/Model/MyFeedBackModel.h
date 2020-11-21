//
//  MyFeedBackModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFeedBackModel : NSObject

/*
FLnkID: 反馈意见主键, FeedbackTypeName: 反馈类型, FeedbackContent: 反馈内容, ImgUrls:逗号隔开 FeedbackTime: 反馈时间, IsReplyed: 是否回复 0-未回复，1-已回复, ReplyContent: 回复意见, ReplyTime: 回复时间, AddTime: 新增时间, UpdateTime:更新时间
 */

@property (nonatomic, copy) NSString *FLnkID;
@property (nonatomic, copy) NSString *FeedbackTypeName;
@property (nonatomic, copy) NSString *FeedbackContent;
@property (nonatomic, copy) NSString *ImgUrls;
@property (nonatomic, assign) NSInteger IsReplyed;
@property (nonatomic, copy) NSString *FeedbackTime;
@property (nonatomic, copy) NSString *ReplyTime;
@property (nonatomic, copy) NSString *AddTime;
@property (nonatomic, copy) NSString *UpdateTime;
@property (nonatomic, copy) NSString *ReplyContent;


@property (nonatomic, copy) NSArray *imgArr;

@end

