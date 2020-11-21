//
//  ActivetyModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/28.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivetyModel : NSObject

@property (nonatomic, copy) NSString *FLnkID;
@property (nonatomic, assign) NSInteger ActivityNum;

@property (nonatomic, copy) NSString *ActivityName1;
@property (nonatomic, copy) NSString *PicUrl1;
@property (nonatomic, assign) NSInteger ActiveType1;
@property (nonatomic, copy) NSString *RedirectPath1;

@property (nonatomic, copy) NSString *ActivityName2;
@property (nonatomic, copy) NSString *PicUrl2;
@property (nonatomic, assign) NSInteger ActiveType2;
@property (nonatomic, copy) NSString *RedirectPath2;

@property (nonatomic, copy) NSString *ActivityName3;
@property (nonatomic, copy) NSString *PicUrl3;
@property (nonatomic, assign) NSInteger ActiveType3;
@property (nonatomic, copy) NSString *RedirectPath3;

@property (nonatomic, copy) NSString *ActivityName4;
@property (nonatomic, copy) NSString *PicUrl4;
@property (nonatomic, assign) NSInteger ActiveType4;
@property (nonatomic, copy) NSString *RedirectPath4;
@property (nonatomic, copy) NSString *OrderID;

@end


