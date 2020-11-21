//
//  GoodsCell.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsCellLayout;

@interface GoodsCell : UICollectionViewCell

//普通商品cell
- (void)setLayout:(GoodsCellLayout *)layout;

//榜单cell
- (void)setLayout:(GoodsCellLayout *)layout andListflag:(NSInteger)listflag;

@end

