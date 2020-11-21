//
//  FootPrintStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/25.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "FootPrintStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation FootPrintStore

#pragma mark - 添加足迹
+(void)addBrowseproductUserguid:(NSString *)userguid identity:(NSInteger)identity itemid:(NSString *)itemid title:(NSString *)title Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"userguid":userguid,
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"itemid":itemid,
                          @"title":title,
                          };
    
    [HttpTool postUrlWithKey:@"browseproduct" parameters:dic success:^(id responseObject) {
        
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

#pragma mark - 足迹列表
+(void)getFootPrintListWithUserguid:(NSString *)userguid identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"userguid":userguid,
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          };
    
    [HttpTool postUrlWithKey:@"browseproductrecord" parameters:dic success:^(id responseObject) {
        
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

@end
