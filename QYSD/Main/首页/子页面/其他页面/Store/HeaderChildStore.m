//
//  HeaderChildStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderChildStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation HeaderChildStore

#pragma mark - 获取首页导航栏目商品数据
+(void)getNavigateproductWithNavigateid:(NSString *)navigateid Identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Sort:(NSString *)sort Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"navigateid":navigateid,
                          @"sort":sort,
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          };
    
    [HttpTool postUrlWithKey:@"navigateproduct" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            NSMutableArray *mutArr2 = [NSMutableArray array];
            for (GoodsModel *model in arr) {
                
                
                if (![model.PictUrl containsString:@"http"]) {
                    
                    model.PictUrl =[NSString stringWithFormat:@"http:%@",model.PictUrl];
                }
                
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
