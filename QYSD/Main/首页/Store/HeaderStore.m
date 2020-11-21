//
//  HeaderStore.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "HeaderStore.h"
#import "RecommendCellModel.h"
#import "RecommendCellLayout.h"
#import "HomeNavigateModel.h"

@implementation HeaderStore

#pragma mark - 获取首页数据
+ (void)getHeaderInfoSuccess:(void(^)(NSArray *styleOneArr,NSArray *styleTwoArr))success Failure:(void(^)(NSError *error))failure{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"recomond" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *videoList = [rootDict objectForKey:@"list"];
        for (NSDictionary *dataDic in videoList) {
            RecommendCellModel *model = [[RecommendCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            RecommendCellLayout *layout = [[RecommendCellLayout alloc] initWithData:model];
            [arr addObject:layout];
        }
        
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dataDic in videoList) {
            RecommendCellModel *model = [[RecommendCellModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            RecommendCellLayout *layout = [[RecommendCellLayout alloc] initWithTableData:model];
            [arr2 addObject:layout];
        }
        
        success(arr,arr2);
    });
    
}

#pragma mark - 获取首页导航栏目
+ (void)getHomeNavigateWithParentnavigateid:(NSString *)parentnavigateid Success:(void(^)(NSArray *modelArr,NSArray *textArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"parentnavigateid":parentnavigateid
                          };
    [HttpTool postUrlWithKey:@"homenavigate" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *modelArr = [HomeNavigateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if ([responseObject[@"path"] isValid]) {
                
                for (HomeNavigateModel *model in modelArr) {
                    
                    model.PicURL = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PicURL];
                }
            }
            
            NSMutableArray *textArr = [NSMutableArray array];
            for (HomeNavigateModel *model in modelArr) {
                
                [textArr addObject:model.NavigateName];
            }
            success(modelArr, textArr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
