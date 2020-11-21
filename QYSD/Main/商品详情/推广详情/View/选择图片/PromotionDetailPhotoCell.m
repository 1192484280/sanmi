//
//  PromotionDetailPhotoCell.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/29.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "PromotionDetailPhotoCell.h"
#import "PromotionDetailPhotoModel.h"
#import "PromotionDetailPhotoList.h"

@interface PromotionDetailPhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *im;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation PromotionDetailPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(PromotionDetailPhotoModel *)data{
    
    _model = data;
    self.im.image = [UIImage imageNamed:data.img];
    self.btn.selected = data.selected;
}


- (IBAction)onSelectedBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        if ([PromotionDetailPhotoList sharedInstance].selectedPhotoArr.count <= 1) {
            
            return [self.viewController.view makeToast:@"至少选择1张图片" duration:1.0 position:CSToastPositionCenter];
        }
        
        [[PromotionDetailPhotoList sharedInstance].selectedPhotoArr removeObject:self.model];
    }else{
        
        [[PromotionDetailPhotoList sharedInstance].selectedPhotoArr addObject:self.model];
    }
   
    sender.selected = !sender.selected;
    self.model.selected = !self.model.selected;
}
@end
