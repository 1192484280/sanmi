//
//  RecommendStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "RecommendStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"
#import "FunctionNavigateModel.h"
#import "HomeBannerModel.h"
#import "HomejxwlModel.h"
#import "ActivetyModel.h"
#import "ActiveDetailModel.h"

@implementation RecommendStore

#pragma mark - 获取推荐轮播图
+ (void)getHomeBannerSuccess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"homebanner" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [HomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if ([responseObject[@"path"] isValid]) {
                
                for (HomeBannerModel *model in arr) {
                    
                    if (![model.BannerURL containsString:@"http"]) {
                        
                        model.BannerURL = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.BannerURL];
                        
                        NSLog(@"");
                    }
                }
            }
            
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取推荐菜单按钮
+ (void)getFunctionNavigateSuccess:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"functionnavigate" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [FunctionNavigateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if ([responseObject[@"path"] isValid]) {
                
                for (FunctionNavigateModel *model in arr) {
                    
                    model.PicURL = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PicURL];
                }
            }
            
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取首页精选数据
+(void)getQualityProductWithIdentity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr,NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure{
    
    
    NSDictionary *dic = @{
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          };
    
    [HttpTool postUrlWithKey:@"qualityproduct" parameters:dic success:^(id responseObject) {
        
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

#pragma mark - 获取首页精选物料导航栏目
+(void)getHomejxwlWithParentnavigateid:(NSInteger)parentnavigateid Success:(void(^)(NSArray *theArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{@"parentnavigateid":[NSString stringWithFormat:@"%ld",(long)parentnavigateid]};
    
    [HttpTool postUrlWithKey:@"homejxwl" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [HomejxwlModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if ([responseObject[@"path"] isValid]) {
                
                for (HomejxwlModel *model in arr) {
                    
                    model.PicURL = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PicURL];
                    
                    model.PicURL1 = [NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PicURL1];
                }
            }
            
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 获取精选物料信息（母婴专区/品牌券/大额券/高佣榜）
+(void)getOptimusMaterialWithMaterialid:(NSInteger)materialid identity:(NSInteger)identity Pageno:(NSInteger)pageno Pagesize:(NSInteger)pagesize Success:(void(^)(NSArray *tabArr))success Failure:(void(^)(NSError *error))failure{

    NSDictionary *dic = @{
                          @"materialid":[NSString stringWithFormat:@"%ld",(long)materialid],
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"pageno":[NSString stringWithFormat:@"%ld",(long)pageno],
                          @"pagesize":[NSString stringWithFormat:@"%ld",(long)pagesize],
                          };
    
    [HttpTool postUrlWithKey:@"optimusmaterial" parameters:dic success:^(id responseObject) {
        
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

#pragma mark - 获取首页自定义活动管理数据集
+(void)getHomeActivitySuccess:(void(^)(NSArray *oldArr,NSArray *theArr))success Failure:(void(^)(NSError *error))failure{
    
    [HttpTool postUrlWithKey:@"homeactivity" parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [ActivetyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *marr = [NSMutableArray array];
            for (ActivetyModel *model in arr) {
                
                if (model.ActivityNum == 1) {
                    
                    ActiveDetailModel *amodel = [[ActiveDetailModel alloc] init];
                    amodel.FLnkID = model.FLnkID;
                    amodel.ActivityNum = model.ActivityNum;
                    amodel.ActivityName = model.ActivityName1;
                    amodel.PicUrl = model.PicUrl1;
                    amodel.ActiveType = model.ActiveType1;
                    amodel.RedirectPath = model.RedirectPath1;
                    [marr addObject:amodel];
                }else if (model.ActivityNum == 2){
                    
                    ActiveDetailModel *amodel = [[ActiveDetailModel alloc] init];
                    amodel.FLnkID = model.FLnkID;
                    amodel.ActivityNum = model.ActivityNum;
                    amodel.ActivityName = model.ActivityName1;
                    amodel.PicUrl = model.PicUrl1;
                    amodel.ActiveType = model.ActiveType1;
                    amodel.RedirectPath = model.RedirectPath1;
                    [marr addObject:amodel];
                    
                    ActiveDetailModel *bmodel = [[ActiveDetailModel alloc] init];
                    bmodel.FLnkID = model.FLnkID;
                    bmodel.ActivityNum = model.ActivityNum;
                    bmodel.ActivityName = model.ActivityName2;
                    bmodel.PicUrl = model.PicUrl2;
                    bmodel.ActiveType = model.ActiveType2;
                    bmodel.RedirectPath = model.RedirectPath2;
                    [marr addObject:bmodel];
                    
                }else if (model.ActivityNum == 3){
                    
                    ActiveDetailModel *amodel = [[ActiveDetailModel alloc] init];
                    amodel.FLnkID = model.FLnkID;
                    amodel.ActivityNum = model.ActivityNum;
                    amodel.ActivityName = model.ActivityName1;
                    amodel.PicUrl = model.PicUrl1;
                    amodel.ActiveType = model.ActiveType1;
                    amodel.RedirectPath = model.RedirectPath1;
                    [marr addObject:amodel];
                    
                    ActiveDetailModel *bmodel = [[ActiveDetailModel alloc] init];
                    bmodel.FLnkID = model.FLnkID;
                    bmodel.ActivityNum = model.ActivityNum;
                    bmodel.ActivityName = model.ActivityName2;
                    bmodel.PicUrl = model.PicUrl2;
                    bmodel.ActiveType = model.ActiveType2;
                    bmodel.RedirectPath = model.RedirectPath2;
                    [marr addObject:bmodel];
                    
                    ActiveDetailModel *cmodel = [[ActiveDetailModel alloc] init];
                    cmodel.FLnkID = model.FLnkID;
                    cmodel.ActivityNum = model.ActivityNum;
                    cmodel.ActivityName = model.ActivityName3;
                    cmodel.PicUrl = model.PicUrl3;
                    cmodel.ActiveType = model.ActiveType3;
                    cmodel.RedirectPath = model.RedirectPath3;
                    [marr addObject:cmodel];
                    
                }else if (model.ActivityNum == 4){
                    
                    ActiveDetailModel *amodel = [[ActiveDetailModel alloc] init];
                    amodel.FLnkID = model.FLnkID;
                    amodel.ActivityNum = model.ActivityNum;
                    amodel.ActivityName = model.ActivityName1;
                    amodel.PicUrl = model.PicUrl1;
                    amodel.ActiveType = model.ActiveType1;
                    amodel.RedirectPath = model.RedirectPath1;
                    [marr addObject:amodel];
                    
                    ActiveDetailModel *bmodel = [[ActiveDetailModel alloc] init];
                    bmodel.FLnkID = model.FLnkID;
                    bmodel.ActivityNum = model.ActivityNum;
                    bmodel.ActivityName = model.ActivityName2;
                    bmodel.PicUrl = model.PicUrl2;
                    bmodel.ActiveType = model.ActiveType2;
                    bmodel.RedirectPath = model.RedirectPath2;
                    [marr addObject:bmodel];
                    
                    ActiveDetailModel *cmodel = [[ActiveDetailModel alloc] init];
                    cmodel.FLnkID = model.FLnkID;
                    cmodel.ActivityNum = model.ActivityNum;
                    cmodel.ActivityName = model.ActivityName2;
                    cmodel.PicUrl = model.PicUrl2;
                    cmodel.ActiveType = model.ActiveType2;
                    cmodel.RedirectPath = model.RedirectPath2;
                    [marr addObject:cmodel];
                    
                    ActiveDetailModel *dmodel = [[ActiveDetailModel alloc] init];
                    dmodel.FLnkID = model.FLnkID;
                    dmodel.ActivityNum = model.ActivityNum;
                    dmodel.ActivityName = model.ActivityName4;
                    dmodel.PicUrl = model.PicUrl4;
                    dmodel.ActiveType = model.ActiveType4;
                    dmodel.RedirectPath = model.RedirectPath4;
                    [marr addObject:dmodel];
                }
            }
            
            for (ActiveDetailModel *model in marr) {
                
                if (![model.PicUrl containsString:@"http"]) {
                    
                    model.PicUrl =[NSString stringWithFormat:@"%@%@",responseObject[@"path"],model.PicUrl];
                }
            }
            success(arr,marr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
