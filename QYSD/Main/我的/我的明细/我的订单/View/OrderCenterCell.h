//
//  OrderCenterCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderCenterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLa;

+ (instancetype)tempVithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
