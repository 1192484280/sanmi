//
//  CircleStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/16.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CircleStore.h"
#import "MerchandiseRecomendNavModel.h"
#import "MerchandiseModel.h"
#import "MerchandiseChildLayout.h"

@implementation CircleStore

#pragma mark - 商品推荐导航栏目
+(void)getMerchandiseRecomendNavSuccess:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"sptjnavigate" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [MerchandiseRecomendNavModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取营销素材、新手必发,商品推荐
+(void)getFQmaterialWithType:(NSInteger)type andNavigateid:(NSInteger)navigateid pageno:(NSInteger)pageno pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *listArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = [NSDictionary new];
    NSString *path = [NSString new];
    if (type > 0) {
        
        dic = @{
                @"funcarea":[NSString stringWithFormat:@"%ld",(long)type],
                @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize]
                };
        
        path = @"fqmaterial";
        
    }else{
        
        dic = @{
                @"navigateid":[NSString stringWithFormat:@"%ld",(long)navigateid],
                @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize]
                };
        
        path = @"sptjproducts";
    }
    
    [HttpTool postUrlWithKey:path parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [MerchandiseModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            //图片、视频拼接路径
            for (MerchandiseModel *model in arr) {
            
                //头像拼接地址
                if ([responseObject[@"path"] isValid] && ![model.PublisherPicUrl containsString:@"http"]) {
                    
                    model.PublisherPicUrl = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PublisherPicUrl];
                }
                
                //视频拼接地址
                if ([model.VideoUrl isValid] && [responseObject[@"path"] isValid] && ![model.VideoUrl containsString:@"http"]) {
                    
                    model.VideoUrl = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.VideoUrl];
                }
                
                //商品图片拼接地址
                if ([model.ImgUrls isValid]) {
                    
                    NSArray *arr1 = [model.ImgUrls componentsSeparatedByString:@","];
                    
                    NSMutableArray *arr2 = [NSMutableArray array];
                    for (NSString *str in arr1) {
                        
                        if (![str isValid]) break;
                        
                        if ([responseObject[@"path"] isValid] && ![str containsString:@"http"]) {
                            
                            [arr2 addObject:[NSString stringWithFormat:@"%@%@",responseObject[@"path"],str]];
                        }else{
                            
                            arr2 = [NSMutableArray arrayWithArray:arr1];
                        }
                    }
                
                    model.imgArr = arr2;
                }
            }
            
            NSMutableArray *mArr = [NSMutableArray array];
            for (MerchandiseModel *model in arr) {
                
                MerchandiseChildLayout *layout = [[MerchandiseChildLayout alloc] initWithData:model ifCopy:NO];
                [mArr addObject:layout];
            }
            
            success(mArr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

@end
