//
//  SMNewsCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "SMNewsCell.h"
#import "SMNewsModel.h"

@interface SMNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *im;
@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UILabel *desLa;

@end

@implementation SMNewsCell

+(instancetype)tempWithTableView:(UITableView *)tableView{
    
    SMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return cell;
    
}

- (void)setModel:(SMNewsModel *)model{
    
    self.im.image = [UIImage imageNamed:model.img];
    self.titleLa.text = model.title;
    self.desLa.text = model.des;
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
