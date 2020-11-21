//
//  MySecondPartnerCellTableViewCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/2.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MySecondPartnerCellTableViewCell.h"
#import "MyPartnerMoreDataViewController.h"

@interface MySecondPartnerCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLa;
@property (weak, nonatomic) IBOutlet UILabel *numLa;
@property (weak, nonatomic) IBOutlet UILabel *moneyLa;
@property (weak, nonatomic) IBOutlet UILabel *partnerLa;
@property (weak, nonatomic) IBOutlet UILabel *vipLa;

@end

@implementation MySecondPartnerCellTableViewCell

+(instancetype)tempWithTableView:(UITableView *)tableView{
    
    MySecondPartnerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (IBAction)onMoreBtn:(UIButton *)sender {
    
    MyPartnerMoreDataViewController *vc = [[MyPartnerMoreDataViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
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
