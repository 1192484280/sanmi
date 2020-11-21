//
//  SMNewsListCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMNewsListCell.h"
#import "SMNewsListModel.h"

@interface SMNewsListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UIImageView *im;
@property (weak, nonatomic) IBOutlet UILabel *desLa;
@property (weak, nonatomic) IBOutlet UILabel *timeLa;


@end

@implementation SMNewsListCell

+(instancetype)tempWithTableView:(UITableView *)tableView{
    
    SMNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        cell = [self cell];
        cell.backgroundColor = BaseBackGroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (void)setModel:(SMNewsListModel *)model{
    
    self.im.image = [UIImage imageNamed:model.img];
    self.titleLa.text = model.title;
    self.desLa.text = model.des;
    self.timeLa.text = model.time;
}

+ (instancetype)cell{
    
    ClassName
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
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
