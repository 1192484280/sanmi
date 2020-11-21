//
//  MyFeedBackStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "MyFeedBackStore.h"
#import "MyFeedBackModel.h"
#import "FeedBackLayout.h"

@implementation MyFeedBackStore

#pragma mark - 获取意见反馈数据集
+(void)getFeedbacklistWithUserguid:(NSString *)userguid pageno:(NSInteger)pageno pagesize:(NSInteger)pagesize Sucess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"userguid":userguid,
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize]
                          };
    
    [HttpTool postUrlWithKey:@"getfeedbacklist" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [MyFeedBackModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            //图片、视频拼接路径
            for (MyFeedBackModel *model in arr) {
            
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
            for (MyFeedBackModel *model in arr) {
                
                FeedBackLayout *layout = [[FeedBackLayout alloc] initWithData:model];
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
