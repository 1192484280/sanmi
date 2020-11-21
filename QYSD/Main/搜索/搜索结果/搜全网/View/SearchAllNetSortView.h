//
//  SearchAllNetSortView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JTImageButton;

@interface SearchAllNetSortView : UIView

@property (nonatomic, copy) void(^SortBlock) (NSString *str,JTImageButton *sender);
@property (nonatomic, copy) void(^SwitchBlock) (BOOL open);
@end


