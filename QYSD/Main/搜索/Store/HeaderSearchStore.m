//
//  HeaderSearchStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderSearchStore.h"
#import "HeaderSearchHotCellLayout.h"
#import "HotModel.h"
#import "SearchCouponsParamtersModel.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation HeaderSearchStore

#pragma mark -  获取热门检索词条
+ (void)getHotSearchListSuccess:(void(^)(NSArray *hotSearchArr))success Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"queryhotkey" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [HotModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *layoutArr = [NSMutableArray array];
            
            for (HotModel *model in arr) {
                HeaderSearchHotCellLayout *layout = [[HeaderSearchHotCellLayout alloc] initWithData:model];
                [layoutArr addObject:layout];
            }
            success(layoutArr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}

#pragma mark - 获取搜索商品优惠卷信息
+(void)getSearchCouponsWithParamter:(SearchCouponsParamtersModel *)paramters Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:paramters.keyword forKey:@"keyword"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)paramters.identity] forKey:@"identity"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)paramters.pageno] forKey:@"pageno"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)paramters.pagesize] forKey:@"pagesize"];
    
    if ([paramters.sort isValid]) {
        
        [dic setObject:paramters.sort forKey:@"sort"];
    }
    
    if ([paramters.hasCoupon isValid]) {
        
        [dic setObject:paramters.hasCoupon forKey:@"hasCoupon"];
    }
    
    if ([paramters.startprice isValid]) {
        
        [dic setObject:paramters.startprice forKey:@"startprice"];
    }
    
    if ([paramters.endprice isValid]) {
        
        [dic setObject:paramters.endprice forKey:@"endprice"];
    }
    
    [HttpTool postUrlWithKey:@"searchcoupons" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            NSMutableArray *mutArr2 = [NSMutableArray array];
            for (GoodsModel *model in arr) {
                
                GoodsCellLayout *layout1 = [[GoodsCellLayout alloc] initWithTabData:model];
                GoodsCellLayout *layout2 = [[GoodsCellLayout alloc] initWithCollectionData:model];
                
                [mutArr1 addObject:layout1];
                [mutArr2 addObject:layout2];
            }
    
            success(mutArr1,mutArr2);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
