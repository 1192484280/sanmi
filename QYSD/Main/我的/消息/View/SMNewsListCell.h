//
//  SMNewsListCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMNewsListModel;

@interface SMNewsListCell : UITableViewCell

+(instancetype)tempWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SMNewsListModel *model;

@end

