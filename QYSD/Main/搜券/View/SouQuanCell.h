//
//  SouQuanCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SouQuanCell : UITableViewCell

+(instancetype)tempWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *im;

@end

NS_ASSUME_NONNULL_END
