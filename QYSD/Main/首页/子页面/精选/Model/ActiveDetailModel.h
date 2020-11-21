//
//  ActiveDetailModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveDetailModel : NSObject

@property (nonatomic, copy) NSString *FLnkID;
@property (nonatomic, assign) NSInteger ActivityNum;

@property (nonatomic, copy) NSString *ActivityName;
@property (nonatomic, copy) NSString *PicUrl;
@property (nonatomic, assign) NSInteger ActiveType;
@property (nonatomic, copy) NSString *RedirectPath;

@end


