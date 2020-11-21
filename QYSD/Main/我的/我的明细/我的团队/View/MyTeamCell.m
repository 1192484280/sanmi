//
//  MyTeamCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/30.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyTeamCell.h"

@implementation MyTeamCell

+ (instancetype)tempVithTableView:(UITableView *)tableView{
    
    MyTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
