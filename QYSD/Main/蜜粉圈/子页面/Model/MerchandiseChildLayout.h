//
//  MerchandiseChildLayout.h
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/9.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MerchandiseModel;

@interface MerchandiseChildLayout : NSObject

@property (nonatomic, readonly) CGRect logoRect;
@property (nonatomic, readonly) CGRect titleRect;
@property (nonatomic, readonly) CGRect timeRect;
@property (nonatomic, readonly) CGRect downBtnRect;
@property (nonatomic, readonly) CGRect shareBtnRect;
@property (nonatomic, readonly) CGRect desRect;
@property (nonatomic, readonly) CGRect imgsRect;
@property (nonatomic, readonly) CGRect zfNumRect;
@property (nonatomic, readonly) CGRect copysStoreUrlRect;
//@property (nonatomic, readonly) CGRect copysReduceUrlRect;
@property (nonatomic, readonly) CGRect copysStoreBtnRect;
//@property (nonatomic, readonly) CGRect copysReduceBtnRect;
@property (nonatomic, readonly) CGRect copysBgViewRect;
@property (nonatomic, readonly) CGFloat height;

@property (nonatomic, strong) MerchandiseModel *data;

- (instancetype)initWithData:(MerchandiseModel*)data ifCopy:(BOOL)ifCopy;

@end


