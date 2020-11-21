//
//  CollectorStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/24.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CollectorStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation CollectorStore

#pragma mark - 收藏/取消收藏
+(void)addCollectorWithUserguid:(NSString *)userguid identity:(NSInteger) identity itemid:(NSString *)itemid title:(NSString *)title Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"userguid":userguid,
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"itemid":itemid,
                          @"title":title,
                          };
    
    [HttpTool postUrlWithKey:@"storeproduct" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
        
            success();
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -  获取收藏列表
+(void)getCollectorListWithUserguid:(NSString *)userguid identity:(NSInteger) identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userguid forKey:@"userguid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)identity] forKey:@"identity"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageno] forKey:@"pageno"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pagesize] forKey:@"pagesize"];
    
    [HttpTool postUrlWithKey:@"storeproductrecord" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            for (GoodsModel *model in arr) {
                
                
                if (![model.PictUrl containsString:@"http"]) {
                    
                    model.PictUrl =[NSString stringWithFormat:@"http:%@",model.PictUrl];
                }
                
                GoodsCellLayout *layout1 = [[GoodsCellLayout alloc] initWithTabData:model];
                
                [mutArr1 addObject:layout1];
            }
            
            success(mutArr1);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 判断商品是否已收藏
+(void)judgeGoodsIfCollectorWithUserguid:(NSString *)userguid identity:(NSInteger) identity itemid:(NSString *)itemid Success:(void(^)(BOOL hadCollector))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userguid forKey:@"userguid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)identity] forKey:@"identity"];
    [dic setObject:@"1" forKey:@"pageno"];
    [dic setObject:@"1" forKey:@"pagesize"];
    
    if ([itemid isValid]) {
        
        [dic setObject:itemid forKey:@"itemid"];
    }
    
    /*
     {
     itemid = 594745303092;
     pageno = 1;
     pagesize = 1;
     userguid = "74985e5e-6467-4381-acc1-dd4466587370";
     }
     */
    [HttpTool postUrlWithKey:@"storeproductrecord" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                
                success(NO);
            }else{
                
                NSInteger a = [responseObject[@"data"] integerValue];
                if (a == 0) {
                    
                    success(NO);
                }else{
                    
                    success(YES);
                }
            }
            
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
