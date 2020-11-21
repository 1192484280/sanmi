//
//  InvitationChildLayout.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InvitationChildModel;

@interface InvitationChildLayout : NSObject

@property (nonatomic, strong) InvitationChildModel *data;
@property (nonatomic, readonly) CGRect sdRect;
@property (nonatomic, readonly) CGRect titleRect;
@property (nonatomic, readonly) CGRect ruleRect;
@property (nonatomic, readonly) CGFloat height;

- (instancetype)initWithData:(InvitationChildModel *)data;

@end

