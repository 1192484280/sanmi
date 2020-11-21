//
//  OpinionStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "OpinionStore.h"
#import "OpinionTypeModel.h"

@implementation OpinionStore

#pragma mark - 获取意见反馈类型
+ (void)getFeedbacktypeSucess:(void(^)(NSArray *theArr))sucess Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"feedbacktype" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [OpinionTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            sucess(arr);
            }else{
            
                failure(error);
            }
        
        } failure:^(NSError *error) {
            
        failure(error);
    }];
}

#pragma mark - 提交反馈
+ (void)feedbackWithUserguid:(NSString *)userguid feedbacktypeid:(NSString *)feedbacktypeid feedbackcontent:(NSString *)feedbackcontent imgurls:(NSString *)imgurls Sucess:(void(^)(void))sucess Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([userguid isValid]) {
        
        [dic setObject:userguid forKey:@"userguid"];
    }
    
    if ([feedbacktypeid isValid]) {
        
        [dic setObject:feedbacktypeid forKey:@"feedbacktypeid"];
    }
    
    if ([feedbackcontent isValid]) {
        
        [dic setObject:feedbackcontent forKey:@"feedbackcontent"];
    }
    
    if ([imgurls isValid]) {
        
        [dic setObject:imgurls forKey:@"imgurls"];
    }
    
    [HttpTool postUrlWithKey:@"feedback" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            sucess();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
