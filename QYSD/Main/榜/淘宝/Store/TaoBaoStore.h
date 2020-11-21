//
//  TaoBaoStore.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaoBaoStore : NSObject


/**
 获取榜单栏目热销数据

 @param identity 用户标识（1：合伙人 2：团长 3：超级团长）
 @param pageno 第几页，示例：１
 @param pagesize  页大小，示例：20，1~100
 @param listflag  榜单标识（1：两小时疯抢 2：全天榜单）
 @param navigateid  导航ID（示例美妆 ：1801,50010788,50023282）
 */
+(void)getProducthotlistWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize listflag:(NSInteger)listflag navigateid:(NSString *)navigateid Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure;

@end


