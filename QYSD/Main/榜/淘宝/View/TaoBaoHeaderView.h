//
//  TaoBaoHeaderView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/13.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnOneBlock)(void);
typedef void(^BtnTwoBlock)(void);

@interface TaoBaoHeaderView : UIView

@property (nonatomic, copy) BtnOneBlock btnOneBlock;
@property (nonatomic, copy) BtnTwoBlock btnTwoBlock;

@property (nonatomic, copy) NSString *btnOneTitle;
@property (nonatomic, copy) NSString *btnTwoTitle;

@end


