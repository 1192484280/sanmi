//
//  LoginStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "LoginStore.h"
#import "LoginParameters.h"
#import "SAMKeychain.h"

@implementation LoginStore

+(void)loginWithParamters:(LoginParameters *)loginParameters Success:(void(^)(void))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"origintype"];
    
    if ([loginParameters.deviceid isValid]) {
        
        [dic setObject:loginParameters.deviceid forKey:@"deviceid"];
    }
    
    if ([loginParameters.code isValid]) {
        
        [dic setObject:loginParameters.code forKey:@"code"];
    }
    
    if ([loginParameters.openid isValid]) {
        
        [dic setObject:loginParameters.openid forKey:@"openid"];
    }
    
    if ([loginParameters.nickname isValid]) {
        
        [dic setObject:loginParameters.nickname forKey:@"nickname"];
    }
    
    if (loginParameters.sex > 0) {
        
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)loginParameters.sex] forKey:@"sex"];
    }
    
    if ([loginParameters.province isValid]) {
        
        [dic setObject:loginParameters.province forKey:@"province"];
    }
    
    if ([loginParameters.city isValid]) {
        
        [dic setObject:loginParameters.city forKey:@"city"];
    }
    
    if ([loginParameters.country isValid]) {
        
        [dic setObject:loginParameters.country forKey:@"country"];
    }
    
    if ([loginParameters.headimgurl isValid]) {
        
        [dic setObject:loginParameters.headimgurl forKey:@"headimgurl"];
    }
    
    if ([loginParameters.privilege isValid]) {
        
        [dic setObject:loginParameters.privilege forKey:@"privilege"];
    }else{
        
        [dic setObject:@"1" forKey:@"privilege"];
    }
    
    if ([loginParameters.unionid isValid]) {
        
        [dic setObject:loginParameters.unionid forKey:@"unionid"];
    }
    
    [HttpTool postUrlWithKey:@"userlogin" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"AppUserGuid"] forKey:@"user_id"];
            
            if ([responseObject[@"data"][@"Nickname"] isValid]) {
                [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"Nickname"] forKey:@"user_name"];
            }
            
            if ([[dic objectForKey:@"openid"] isValid]) {
                
                if ([responseObject[@"data"][@"HeadImgUrl"] isValid]) {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"HeadImgUrl"] forKey:@"user_Im"];
                }
            }
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
