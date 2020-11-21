//
//  ChangeUrlModelCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ChangeUrlModelCell.h"
#import "ChangUrlModel.h"

@interface ChangeUrlModelCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn;


@end

@implementation ChangeUrlModelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setModel:(ChangUrlModel *)model{
    
    [self.btn setTitle:model.name forState:UIControlStateNormal];
    
    if ([model.name isEqualToString:@"换行"]) {
        
        self.btn.layer.borderUIColor = FontColor;
        [self.btn setTitleColor:FontColor forState:UIControlStateNormal];
        [self.btn setImage:nil forState:UIControlStateNormal];
        return;
    }
    
    self.btn.layer.borderUIColor = model.selected?UIColor.redColor:FontColor;
    [self.btn setTitleColor:model.selected?UIColor.redColor:FontColor forState:UIControlStateNormal];
    [self.btn setImage:model.selected?[UIImage imageNamed:@"img_urlselected"]:nil forState:UIControlStateNormal];
}
@end
