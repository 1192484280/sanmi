//
//  IncomeRankingCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IncomeRankingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLa;
@property (weak, nonatomic) IBOutlet UILabel *phoneLa;
@property (weak, nonatomic) IBOutlet UILabel *moneyLa;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
