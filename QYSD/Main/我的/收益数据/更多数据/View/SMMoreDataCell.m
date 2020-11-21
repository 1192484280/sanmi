//
//  SMMoreDataCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMMoreDataCell.h"
#import "SMMoreDataModel.h"

@interface SMMoreDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLa;

@property (weak, nonatomic) IBOutlet UILabel *orderLa;
@property (weak, nonatomic) IBOutlet UILabel *yuguLa;
@property (weak, nonatomic) IBOutlet UILabel *yuguMoneyLa;

@end

@implementation SMMoreDataCell

+ (instancetype)tempVithTableView:(UITableView *)tableView{
    
    SMMoreDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(SMMoreDataModel *)model andSection:(NSInteger)section{
    
    if (section == 0) {
        
        self.titleLa.text = @"我的概况";
        self.yuguLa.text = @"我的效果预估";
    }else if (section == 1){
        
        self.titleLa.text = @"二当家概况";
        self.yuguLa.text = @"我的预估奖励";
    }else{
        
        self.titleLa.text = @"三当家概况";
        self.yuguLa.text = @"我的预估奖励";
    }
    
    self.orderLa.text = model.order;
    self.yuguMoneyLa.text = model.yugu;
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
