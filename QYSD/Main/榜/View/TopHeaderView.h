//
//  TopHeaderView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TaoBaoBtnClickBlock)(void);
typedef void(^PinDuoDuoBtnClickBlock)(void);

@interface TopHeaderView : UIView

@property (nonatomic, copy) TaoBaoBtnClickBlock taoBaoBtnClickBlock;
@property (nonatomic, copy) PinDuoDuoBtnClickBlock pinDuoDuoBtnClickBlock;

@end


