//
//  CommonStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "CommonStore.h"
#import "UploadfilesModel.h"
#import "UserModel.h"

@implementation CommonStore

//#pragma mark - 获取基础配置信息
+ (void)getBasicinfoSucess:(void(^)(NSString *prefixpath))sucess Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"basicinfo" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSString *prefixpath = responseObject[@"data"][@"prefixpath"];
            sucess(prefixpath);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark -  上传文件
+ (void)getUploadfilesListWithBusstype:(NSInteger)busstype imags:(NSArray *)imags Sucess:(void(^)(NSArray *theArr))sucess Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"busstype":[NSString stringWithFormat:@"%ld",(long)busstype],
                          @"file":@"file"
                          };

    [HttpTool uploadFileWithKey:@"uploadfiles" parameters:dic imgArr:imags name:nil fileName:nil mimeType:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [UploadfilesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            sucess(arr);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
         failure(error);
    }];
    
}

#pragma mark - 获取用户信息
+ (void)getUserInfoWithUserguid:(NSString *)userguid Sucess:(void(^)(UserModel *userModel))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([userguid isValid]) {
        
        [dic setObject:userguid forKey:@"userguid"];
    }
    
    [HttpTool postUrlWithKey:@"getuserinfo" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            UserModel *model = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            success(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取APP下载地址
+ (void)getAPPDownLoadUrlSucess:(void(^)(NSString *url))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"origintype":@"2"
                          };
    
    [HttpTool postUrlWithKey:@"downloadurl" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSString  *url = responseObject[@"data"];
            success(url);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 判断当前app版本
+ (void)getAPPVersionSucess:(void(^)(NSString *version))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSDictionary *dic = @{@"origintype":@"2",@"ver":app_Version};
    [HttpTool postUrlWithKey:@"version" parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"] forKey:@"verson"];
            success(responseObject[@"data"]);
        }else{
            
            NSError *error;
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取版本更新内容
+ (void)getAPPVersionUpInfoSucess:(void (^)(NSAttributedString *upInfo))success Failure:(void (^)(NSError *))failure{
    
    NSDictionary *dic = @{@"origintype":@"2"};
    [HttpTool postUrlWithKey:@"versionUpInfo" parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 200) {
        
            if([responseObject[@"data"] isEqual:[NSNull null]]) return;
            
            if ([responseObject[@"data"][@"VersionLog"] isValid]) {
                
                NSAttributedString *attStr = [NSString getAttStrWithHtml:responseObject[@"data"][@"VersionLog"]];
                
                success(attStr);
            }
            
        }else{
            
            NSError *error;
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
