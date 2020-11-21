//
//  GuessYouLikeStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "GuessYouLikeStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation GuessYouLikeStore

#pragma mark - 获取猜你喜欢数据
+(void)getGuessLikeWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          };
    
    [HttpTool postUrlWithKey:@"guesslike" parameters:dic success:^(id responseObject) {
        
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
