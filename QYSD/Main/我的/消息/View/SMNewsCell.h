//
//  SMNewsCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMNewsModel;

@interface SMNewsCell : UITableViewCell

+(instancetype)tempWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SMNewsModel *model;

@end

