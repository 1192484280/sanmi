//
//  AboutSMCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "AboutSMCell.h"

@interface AboutSMCell ()

@property (weak, nonatomic) IBOutlet UILabel *versionLa;


@end

@implementation AboutSMCell

+ (instancetype)tempVithTableView:(UITableView *)tableView{
    
    AboutSMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        
        ClassName
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLa.text = app_Version;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
