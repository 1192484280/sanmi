//
//  SMMoreDataCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMMoreDataModel;

@interface SMMoreDataCell : UITableViewCell

+ (instancetype)tempVithTableView:(UITableView *)tableView;

- (void)setModel:(SMMoreDataModel *)model andSection:(NSInteger)section;

@end


