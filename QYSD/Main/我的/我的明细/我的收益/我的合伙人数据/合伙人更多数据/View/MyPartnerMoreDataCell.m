//
//  MyPartnerMoreDataCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyPartnerMoreDataCell.h"

@interface MyPartnerMoreDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *jljsLa;
@property (weak, nonatomic) IBOutlet UILabel *jlygLa;
@property (weak, nonatomic) IBOutlet UILabel *fkdsLa;

@end

@implementation MyPartnerMoreDataCell

+ (instancetype)tempVithTableView:(UITableView *)tableView{
    
    MyPartnerMoreDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
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
