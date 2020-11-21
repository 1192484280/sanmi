//
//  ProductHeaderView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/21.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductHeaderView : UIView

@property (nonatomic, strong) UIButton *baobeiBtn;
@property (nonatomic, strong) UIButton *xiangqingBtn;
@property (nonatomic, strong) UIButton *tuijianBtn;

@property (nonatomic, copy) void(^onBaoBeiBtnBlock)(void);
@property (nonatomic, copy) void(^onXiangQingBtnBlock)(void);
@property (nonatomic, copy) void(^onTuiJianBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
