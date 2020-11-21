//
//  PromotionDetailCopywritingCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailCopywritingCell.h"

@implementation PromotionDetailCopywritingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - 点击去除淘宝口令
- (IBAction)onRaduceBtn:(UIButton *)sender {
}

#pragma mark - 复制分享文案
- (IBAction)onCopyBtn:(UIButton *)sender {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.tf.text;
    [self.viewController.view makeToast:@"复制成功" duration:1.0 position:CSToastPositionCenter];
}
@end
