//
//  BangDingAlipayViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "BangDingAlipayViewController.h"

@interface BangDingAlipayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipsLa;

@end

@implementation BangDingAlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavBarWithTitle:@"支付宝绑定"];
    
    NSString *str = @"特别提醒：请输入支付宝的真实姓名，否则会影响账户余额的发放";
    self.tipsLa.attributedText = [self getAttributedWithString:str andRedStr:@"特别提醒：" WithLineSpace:2 kern:0.5 font:[UIFont systemFontOfSize:11] color:FontColor];
}

- (NSAttributedString *)getAttributedWithString:(NSString *)string andRedStr:(NSString *)redStr WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font color:(UIColor *)color{
    
    NSRange hightlightTextRange = [string rangeOfString:redStr];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:hightlightTextRange];
    
    [attributedString addAttribute:NSFontAttributeName value:font range:hightlightTextRange];
    
    
    return attributedString;
};
@end
