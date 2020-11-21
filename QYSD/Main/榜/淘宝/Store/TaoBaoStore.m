//
//  TaoBaoStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/23.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "TaoBaoStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"

@implementation TaoBaoStore

#pragma mark - 获取榜单栏目热销数据
+(void)getProducthotlistWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize listflag:(NSInteger)listflag navigateid:(NSString *)navigateid Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          @"navigateid":navigateid,
                          @"listflag":[NSString stringWithFormat:@"%ld",(long)listflag]
                          };
    
    [HttpTool postUrlWithKey:@"producthotlist" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *mutArr1 = [NSMutableArray array];
            for (GoodsModel *model in arr) {
                
                GoodsCellLayout *layout1 = [[GoodsCellLayout alloc] initWithTopTabData:model];
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
