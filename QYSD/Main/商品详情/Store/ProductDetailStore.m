//
//  ProductDetailStore.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/18.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ProductDetailStore.h"
#import "GoodsModel.h"
#import "GoodsCellLayout.h"
#import "ProductDetailModel.h"
#import "TFHpple.h"

@implementation ProductDetailStore

#pragma mark - 获取商品详情相关推荐商品信息
+(void)getProductRecommendWithIdentity:(NSInteger)identity itemid:(NSString *)itemid title:(NSString *)title count:(NSInteger)count Success:(void(^)(NSArray *collectionArr))success Failure:(void(^)(NSError *error))failure{
    
    NSDictionary *dic = @{
                          @"identity":[NSString stringWithFormat:@"%ld",(long)identity],
                          @"itemid":itemid,
                          @"title":title,
                          @"count":[NSString stringWithFormat:@"%ld",(long)count],
                          };
    
    [HttpTool postUrlWithKey:@"productrecommend" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            NSArray *arr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            NSMutableArray *mutArr2 = [NSMutableArray array];
            for (GoodsModel *model in arr) {
                
                if (![model.PictUrl containsString:@"http"]) {
                    
                    model.PictUrl =[NSString stringWithFormat:@"http:%@",model.PictUrl];
                }
                
                GoodsCellLayout *layout2 = [[GoodsCellLayout alloc] initWithCollectionData:model];
                
                [mutArr2 addObject:layout2];
            }
            
            success(mutArr2);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取商品详情接口
+(void)getProductDetailWithIdentity:(NSInteger)identity itmeid:(NSString *)itmeid title:(NSString *)title Success:(void(^)(ProductDetailModel *detailModel))success Failure:(void(^)(NSError *error))failure{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)identity] forKey:@"identity"];
    
    if ([itmeid isValid]) {
        
        [dic setObject:itmeid forKey:@"itmeid"];
    }
    
    if ([title isValid]) {
        
        [dic setObject:title forKey:@"title"];
    }
    
    [HttpTool postUrlWithKey:@"getproductdetail" parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
        
            ProductDetailModel *model = [ProductDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            NSMutableArray *arr = [NSMutableArray array];
            
            if ([model.PictUrl containsString:@"http"]) {
                
                [arr addObject:model.PictUrl];
            }else{
                
                [arr addObject: [NSString stringWithFormat:@"http:%@",model.PictUrl]];
            }
            
            
            NSArray *ims = [model.SmallImageUrls componentsSeparatedByString:@","];
            
            for (NSString *a in ims) {
                
                if ([a isValid]) {
                    
                    if ([a containsString:@"http"]) {
                        
                        [arr addObject:a];
                    }else{
                        
                        [arr addObject:[NSString stringWithFormat:@"http:%@",a]];
                    }
                    
                }
            }
            model.imgArr = arr;
            success(model);
            
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

 #pragma mark - 获取商品店铺评价、用户评论数据
- (void)getProductOtherInfoWothItemNumId:(NSString *)itemNumId Success:(void(^)(NSString *baobeiScore, NSString *maijiaServiceScore, NSString *wuliuScore, NSString *commentCount, NSString *commentUserName, NSString *commentUserIcon, NSString *commentContent))success Failure:(void(^)(NSError *error))failure{

    NSString *str = [NSString stringWithFormat:@"{\"data\":\"%@\"}",itemNumId];

    NSString *url = [NSString stringWithFormat:@"http://h5api.m.taobao.com/h5/mtop.taobao.detail.getdetail/6.0/?data=%@",[str URLEncodedString]];

    [HttpTool postUrl:url parameters:nil success:^(id responseObject) {
        
        NSString *baobeiScore = [NSString new];
        NSString *maijiaServiceScore = [NSString new];
        NSString *wuliuScore = [NSString new];
        NSString *commentCount = [NSString new];
        NSString *commentUserName = [NSString new];
        NSString *commentUserIcon = [NSString new];
        NSString *commentContent = [NSString new];
        
        NSDictionary *rootDict = responseObject;
        
        if (rootDict.count < 1) {
            
            return ;
        }
        NSArray *arr = rootDict[@"data"][@"seller"][@"evaluates"];
        for (NSDictionary *dic1 in arr) {
            
            if ([[dic1 objectForKey:@"title"] isEqualToString:@"宝贝描述"]) {
                
                baobeiScore = [dic1 objectForKey:@"score"];
            }else if ([[dic1 objectForKey:@"title"] isEqualToString:@"卖家服务"]){
                
                maijiaServiceScore = [dic1 objectForKey:@"score"];
                
            }else if ([[dic1 objectForKey:@"title"] isEqualToString:@"物流服务"]){
                
                wuliuScore = [dic1 objectForKey:@"score"];
            }
        }
        
        if ([rootDict[@"data"][@"item"][@"commentCount"] isValid]) {
            
            commentCount = rootDict[@"data"][@"item"][@"commentCount"];
        }
        
        NSArray *rateList = rootDict[@"data"][@"rate"][@"rateList"];
        NSDictionary *comDic = rateList.firstObject;
        if ([comDic[@"content"] isValid]) {
            
            commentContent = comDic[@"content"];
        }
        
        if ([comDic[@"userName"] isValid]) {
            
            commentUserName = comDic[@"userName"];
        }
        
        if ([comDic[@"headPic"] isValid]) {
            
            commentUserIcon = comDic[@"headPic"];
        }
        
        if (![baobeiScore isValid]) {
            
            baobeiScore = [self getRanScore];
        }
        
        if (![maijiaServiceScore isValid]) {
            
            maijiaServiceScore = [self getRanScore];
        }
        
        if (![wuliuScore isValid]) {
            
            wuliuScore = [self getRanScore];
        }
        success(baobeiScore,maijiaServiceScore,wuliuScore,commentCount,commentUserName,commentUserIcon,commentContent);
    } failure:^(NSError *error) {

        failure(error);
    }];
}
//-(void)getProductOtherInfoWothItemNumId:(NSString *)itemNumId Success:(void(^)(NSString *baobeiScore, NSString *maijiaServiceScore, NSString *wuliuScore, NSString *commentCount, NSString *commentUserName, NSString *commentUserIcon, NSString *commentContent))success Failure:(void(^)(NSError *error))failure{
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        NSString *baobeiScore = [NSString new];
//        NSString *maijiaServiceScore = [NSString new];
//        NSString *wuliuScore = [NSString new];
//        NSString *commentCount = [NSString new];
//        NSString *commentUserName = [NSString new];
//        NSString *commentUserIcon = [NSString new];
//        NSString *commentContent = [NSString new];
//
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//        if (rootDict.count < 1) {
//
//            return ;
//        }
//        NSArray *arr = rootDict[@"data"][@"seller"][@"evaluates"];
//        for (NSDictionary *dic1 in arr) {
//
//            if ([[dic1 objectForKey:@"title"] isEqualToString:@"宝贝描述"]) {
//
//                baobeiScore = [dic1 objectForKey:@"score"];
//            }else if ([[dic1 objectForKey:@"title"] isEqualToString:@"卖家服务"]){
//
//                maijiaServiceScore = [dic1 objectForKey:@"score"];
//
//            }else if ([[dic1 objectForKey:@"title"] isEqualToString:@"物流服务"]){
//
//                wuliuScore = [dic1 objectForKey:@"score"];
//            }
//        }
//
//        if ([rootDict[@"data"][@"item"][@"commentCount"] isValid]) {
//
//            commentCount = rootDict[@"data"][@"item"][@"commentCount"];
//        }
//
//        NSArray *rateList = rootDict[@"data"][@"rate"][@"rateList"];
//        NSDictionary *comDic = rateList.firstObject;
//        if ([comDic[@"content"] isValid]) {
//
//            commentContent = comDic[@"content"];
//        }
//
//        if ([comDic[@"userName"] isValid]) {
//
//            commentUserName = comDic[@"userName"];
//        }
//
//        if ([comDic[@"headPic"] isValid]) {
//
//            commentUserIcon = comDic[@"headPic"];
//        }
//
//        if (![baobeiScore isValid]) {
//
//            baobeiScore = [self getRanScore];
//        }
//
//        if (![maijiaServiceScore isValid]) {
//
//            maijiaServiceScore = [self getRanScore];
//        }
//
//        if (![wuliuScore isValid]) {
//
//            wuliuScore = [self getRanScore];
//        }
//        success(baobeiScore,maijiaServiceScore,wuliuScore,commentCount,commentUserName,commentUserIcon,commentContent);
//    });
//
//}

- (NSString *)getRanScore{
    
    BOOL run = YES;
    float r = 4.8;
    while (run) {
        
        r = (float)(arc4random()%100) / 100 + 4.0;
        
        if (r>=4.6 && r<=5.0) {
            
            run = NO;
        }
    }
    return [NSString stringWithFormat:@"%.1f",r];
}

#pragma mark - 商品详情图片集合
- (void)getProductPicsWothItemNumId:(NSString *)itemNumId Success:(void(^)(NSString *htmlStr))success Failure:(void(^)(NSError *error))failure{
    
    NSString *str = [NSString stringWithFormat:@"{\"id\":\"%@\"}",itemNumId];
    
    NSString *url = [NSString stringWithFormat:@"http://h5api.m.taobao.com/h5/mtop.taobao.detail.getdesc/6.0?data=%@",[str URLEncodedString]];
    
    [HttpTool postUrl:url parameters:nil success:^(id responseObject) {
        
        if ([responseObject[@"data"][@"pcDescContent"] isValid]) {
        
//            NSArray *imgs = [self getImageurlFromHtml:responseObject[@"data"][@"pcDescContent"]];
    
            NSString *htmlStr = [self adaptWebViewForHtml:responseObject[@"data"][@"pcDescContent"]];
            NSString *httpStr = [htmlStr stringByReplacingOccurrencesOfString:@"//"withString:@"http://"];//替换
            success(httpStr);
        }
        
    } failure:^(NSError *error) {

        failure(error);
    }];
}

//HTML适配图片文字
- (NSString *)adaptWebViewForHtml:(NSString *) htmlStr
{
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    [headHtml appendString : @"<html>" ];
    
    [headHtml appendString : @"<head>" ];
    
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];
    
    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    
    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];

    //适配图片宽度，让图片宽度等于屏幕宽度
    //[headHtml appendString : @"<style>img{width:100%;}</style>" ];
    //[headHtml appendString : @"<style>img{height:auto;}</style>" ];
    
     //适配图片宽度，让图片宽度最大等于屏幕宽度
//    [headHtml appendString : @"<style>img{max-width:100%;width:auto;height:auto;}</style>"];

    
   //适配图片宽度，如果图片宽度超过手机屏幕宽度，就让图片宽度等于手机屏幕宽度，高度自适应，如果图片宽度小于屏幕宽度，就显示图片大小
    [headHtml appendString : @"<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var maxwidth=document.body.clientWidth;\n" //屏幕宽度
     "for(i=0;i <document.images.length;i++){\n"
     "var myimg = document.images[i];\n"
     "if(myimg.width > maxwidth){\n"
     "myimg.style.width = '100%';\n"
     "myimg.style.height = 'auto'\n;"
     "}\n"
     "}\n"
     "}\n"
     "</script>\n"];
    
    [headHtml appendString : @"<style>table{width:100%;}</style>" ];
    [headHtml appendString : @"<title>webview</title>" ];
    NSString *bodyHtml;
    bodyHtml = [NSString stringWithString:headHtml];
    bodyHtml = [bodyHtml stringByAppendingString:htmlStr];
    return bodyHtml;
    
}

//获取webView中的所有图片URL
- (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [webString substringWithRange:range];
        
        if (![subString isEqualToString:@"<img>"]) {
            
            //从图片中的标签中提取ImageURL
            NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"//(.*?)\"" options:0 error:NULL];
            NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
            NSTextCheckingResult * subRes = match[0];
            NSRange subRange = [subRes range];
            subRange.length = subRange.length -1;
            NSString * imagekUrl = [subString substringWithRange:subRange];
            
            //将提取出的图片URL添加到图片数组中
            if (![imagekUrl containsString:@".gif"]) {
                
                if (imagekUrl.length >= 8) {
                    
                    if ([[imagekUrl substringFromIndex:imagekUrl.length - 6] containsString:@"."]) {
                        
                         [imageurlArray addObject:[NSString stringWithFormat:@"http:%@",imagekUrl]];
                    }
                }
              
            }

            
        }
    }
    
    
    return imageurlArray;
}


/*
 
 {
 "api": "wdetail",
 "v": "6.0",
 "ret": ["SUCCESS::调用成功"],
 "data": {
 "apiStack": [{
 "name": "esi",
 "value": "{\"feature\":{\"makeup\":\"false\",\"isVirtualRechargeItem\":\"false\",\"isDonateItem\":\"false\",\"bSeller\":\"true\",\"useMeiLiHuiPrice\":\"false\",\"o2O\":\"false\",\"showCommonBanner\":\"false\",\"guessYouLike\":\"false\",\"isJuPinTuan\":\"false\",\"sellCountAntiCreep\":\"true\",\"nabundleItem\":\"false\",\"hasSku\":\"true\",\"bundleItem\":\"false\",\"wygProtect\":\"true\",\"hasCartRecommend\":\"false\",\"hasBrandScene\":\"false\",\"fmcgRecommend\":\"false\",\"superActTime\":\"false\",\"isXinxuan\":\"false\",\"notUseVip95CardBar\":\"false\",\"hasApparelIcon\":\"false\",\"openGradient\":\"false\",\"isCloudChanger\":\"false\",\"overSeaBuy\":\"false\",\"wygItem\":\"false\",\"hasIntervalPrice\":\"true\",\"isDamai\":\"false\",\"waitForStart\":\"false\",\"newAddress\":\"true\",\"hideSMww\":\"false\",\"renovation\":\"false\",\"hasAddCartCoudan\":\"false\",\"showCuntaoTag\":\"false\",\"recommendReason\":\"false\",\"switchToOldApp\":\"false\",\"isNewShareGift\":\"false\",\"hideShopDsr\":\"false\",\"pricedCoupon\":\"false\",\"hasCoupon\":\"false\",\"buhuo\":\"false\",\"cainiaoNoramal\":\"true\",\"showSku\":\"true\",\"showShopCard\":\"false\",\"showYaoDai\":\"false\",\"isXXSale\":\"false\",\"enableDpbModule\":\"false\",\"showLiteAppRec\":\"false\",\"showTmallApp\":\"false\",\"hasNewCombo\":\"false\",\"noShareGroup\":\"true\",\"showSkuProRate\":\"false\",\"hasAddTmallCartCoudan\":\"false\",\"multistage\":\"false\",\"hasQualification\":\"false\",\"isTspace\":\"false\",\"series\":\"false\",\"isTTSale\":\"false\",\"shareGroup\":\"false\",\"showSMww\":\"false\",\"isShopVipMember\":\"false\",\"includeSkuData\":\"true\"},\"trade\":{\"tradeParams\":{},\"buyParam\":{\"areaId\":\"320100\"},\"cartConfirmEnable\":\"true\",\"cartEnable\":\"true\",\"isWap\":\"false\",\"buyEnable\":\"true\",\"useWap\":\"false\",\"cartParam\":{\"areaId\":\"320100\"},\"outerCartParam\":{}},\"item\":{\"title\":\"汉萱本草面膜旗舰店正品酵母卵壳面纱霜睡眠面膜\",\"descType\":\"2\",\"infoText\":{},\"itemId\":\"586774343772\",\"spuId\":\"1129452439\",\"sellCount\":\"336\",\"vagueSellCount\":\"336\",\"skuText\":\"请选择化妆品净含量\",\"videos\":[],\"showShopActivitySize\":\"2\"},\"buyer\":{\"tmallMemberLevel\":\"0\"},\"price\":{\"newExtraPrices\":[{\"priceText\":\"238\",\"priceTitle\":\"价格\",\"showTitle\":\"true\",\"lineThrough\":\"true\",\"sugProm\":\"false\"}],\"extraPrices\":[{\"priceText\":\"238\",\"priceTitle\":\"价格\",\"showTitle\":\"true\",\"lineThrough\":\"true\",\"sugProm\":\"false\"}],\"price\":{\"priceText\":\"138\",\"sugProm\":\"false\"},\"transmitPrice\":{\"priceText\":\"138\",\"sugProm\":\"false\"},\"shopPromTitle\":\"促销\",\"superMarketShopProm\":[],\"shopProm\":[{\"activityId\":\"7455560057\",\"groupId\":\"7455560057\",\"iconText\":\"促销\",\"title\":\"蛋蛋面膜\",\"period\":\"2019.08.05-2019.09.30\",\"content\":[\"满276元,省118元\"],\"uuid4Cal\":\"7455560057\",\"type\":\"3\"},{\"activityId\":\"0\",\"iconText\":\"积分\",\"title\":\"购买可得69积分\",\"content\":[\"购买可得69积分\"],\"type\":\"5\"}],\"priceTag\":[{\"text\":\"抢购价\",\"bigmarkdownTag\":\"false\"}]},\"consumerProtection\":{\"passValue\":\"none\",\"items\":[{\"serviceId\":\"3838\",\"title\":\"假一赔四\",\"desc\":\"正品保障，假一赔四\",\"type\":\"0\",\"priority\":\"12900\"},{\"serviceId\":\"5309\",\"title\":\"过敏包退\",\"desc\":\"签收60天内，使用商品过敏并提供有效凭证的，商家48小时内响应并退货退款，诚信用户享极速退款\",\"type\":\"0\",\"priority\":\"8000\"},{\"serviceId\":\"2979\",\"title\":\"极速退款\",\"desc\":\"诚信用户在退货寄出后，享受极速退款到账\",\"type\":\"0\",\"priority\":\"6505\"},{\"serviceId\":\"3851\",\"title\":\"退货运费险\",\"desc\":\"卖家投保退货运费险，负担一定金额退货运费（保单生效以下单显示为准）\",\"type\":\"0\",\"priority\":\"6504\"},{\"serviceId\":\"2973\",\"title\":\"七天无理由退换\",\"desc\":\"满足相应条件时，消费者可申请 “七天无理由退换货”\",\"type\":\"0\",\"priority\":\"5130\"}],\"displayService\":{\"id\":\"155\",\"name\":\"基础保障\",\"icon\":\"//gw.alicdn.com/tfs/TB1oaTwKhTpK1RjSZR0XXbEwXXa-466-64.png\",\"wyg\":\"false\",\"services\":[{\"serviceId\":\"3839\",\"name\":\"假一赔四\",\"desc\":[\"正品保障，假一赔四\"],\"icon\":\"//gw.alicdn.com/tfs/TB1.8myOVzqK1RjSZFCXXbbxVXa-64-64.png\",\"priority\":\"12900\"},{\"serviceId\":\"5309\",\"name\":\"过敏包退\",\"desc\":[\"签收60天内，使用商品过敏并提供有效凭证的，商家48小时内响应并退货退款，诚信用户享极速退款\"],\"icon\":\"//gw.alicdn.com/tfs/TB1.8myOVzqK1RjSZFCXXbbxVXa-64-64.png\",\"link\":\"//pages.tmall.com/wow/fuwu/act/wyg-new?serviceCode=mzgmwy&wyg=false\",\"priority\":\"8000\"},{\"serviceId\":\"2966\",\"name\":\"极速退款\",\"desc\":[\"诚信用户在退货寄出后，享受极速退款到账\"],\"icon\":\"//gw.alicdn.com/tfs/TB1.8myOVzqK1RjSZFCXXbbxVXa-64-64.png\",\"priority\":\"6505\"},{\"serviceId\":\"3852\",\"name\":\"退货运费险\",\"desc\":[\"卖家投保退货运费险，负担一定金额退货运费（保单生效以下单显示为准）\"],\"icon\":\"//gw.alicdn.com/tfs/TB1.8myOVzqK1RjSZFCXXbbxVXa-64-64.png\",\"priority\":\"6504\"},{\"serviceId\":\"2972\",\"name\":\"七天无理由退换\",\"desc\":[\"满足相应条件时，消费者可申请 “七天无理由退换货”\"],\"icon\":\"//gw.alicdn.com/tfs/TB1.8myOVzqK1RjSZFCXXbbxVXa-64-64.png\",\"priority\":\"5130\"}]},\"params\":\"155:3838,5309,2979,3851,2973\",\"strength\":\"normal\"},\"resource\":{\"entrances\":{},\"tmallAppActivities\":[],\"taobaoAppActivities\":[],\"entrancesBizsContent\":\"\",\"promsCalcInfo\":{\"cheapestMoney\":\"0\",\"hasCoupon\":\"false\",\"needReqCouDan\":\"false\"},\"coupon\":{}},\"vertical\":{\"cuntao\":{},\"askAll\":{\"title\":\"问大家(17)\",\"questNum\":\"17\",\"modelList\":[{\"askText\":\"好用吗？会不会刺激\",\"answerCountText\":\"2个回答\"},{\"askText\":\"一次最好敷多久呀\",\"answerCountText\":\"3个回答\"}],\"showNum\":\"2\",\"askIcon\":\"https://img.alicdn.com/tps/TB1tVU6PpXXXXXFaXXXXXXXXXXX-102-60.png\",\"askText\":\"好用吗？会不会刺激\",\"linkUrl\":\"//h5.m.taobao.com/wendajia/question2017.html?refId=586774343772\"},\"freshFood\":{\"nationalFlag\":\"//g.alicdn.com/mui/flag-img/circle@2x/CN.png\"},\"tmallLeaseData\":{\"rentOfficialPriceFen\":\"0\",\"rentGuaranteePriceFen\":\"0\",\"zhiMaSigned\":\"false\"},\"degrade\":\"Sugar\"},\"delivery\":{\"areaId\":\"320100\",\"to\":\"南京市\",\"areaSell\":\"false\",\"from\":\"广东广州\",\"completedTo\":\"江苏省 南京市\",\"overseaContraBandFlag\":\"false\",\"postage\":\"快递: 0.00\"},\"skuBase\":{\"skus\":[{\"skuId\":\"4151897598898\",\"propPath\":\"122216906:75367020\"}],\"props\":[{\"pid\":\"122216906\",\"name\":\"化妆品净含量\",\"values\":[{\"vid\":\"75367020\",\"name\":\"30g\",\"sortOrder\":\"0\"}]}]},\"skuCore\":{\"skuItem\":{\"showAddress\":\"false\",\"hideQuantity\":\"false\",\"location\":\"南京市\"},\"sku2info\":{\"0\":{\"price\":{\"priceMoney\":\"13800\",\"priceText\":\"138\",\"showTitle\":\"false\",\"sugProm\":\"false\"},\"quantity\":\"9714\"},\"4151897598898\":{\"price\":{\"priceMoney\":\"13800\",\"priceText\":\"138\",\"showTitle\":\"false\",\"sugProm\":\"false\"},\"quantity\":\"9714\"}}},\"skuVertical\":{\"installment\":{\"title\":\"花呗分期（可选）\",\"enable\":\"true\",\"period\":[{\"count\":\"3\",\"ratio\":\"0.023\",\"couponPrice\":\"0\"},{\"count\":\"6\",\"ratio\":\"0.045\",\"couponPrice\":\"0\"},{\"count\":\"12\",\"ratio\":\"0.075\",\"couponPrice\":\"0\"}]}},\"params\":{\"trackParams\":{\"shop_id\":\"62572383\",\"bizParams_V2\":\"shopActivity_current\",\"detailabtestdetail\":\"10861_7981\"},\"umbParams\":{\"aliBizName\":\"其他\",\"aliBizCode\":\"b000\"}},\"extendedData\":{},\"otherInfo\":{\"bucketId\":\"14\",\"systemTime\":\"1569221506208\"},\"rate\":{},\"layout\":{},\"modules\":[]}"
 }],
 "item": {
 "itemId": "586774343772",
 "title": "汉萱本草面膜旗舰店正品酵母卵壳面纱霜睡眠面膜",
 "subtitle": "两瓶更划算",
 "images": ["http://img.alicdn.com/imgextra/i1/489668278/O1CN01ttZjb82B1NBSZcWOY_!!489668278.jpg", "http://img.alicdn.com/imgextra/i1/489668278/O1CN01YjzIRR2B1N7ziTJTf_!!489668278.jpg", "http://img.alicdn.com/imgextra/i1/489668278/O1CN01LjOGVO2B1N7z5K0ZY_!!489668278.jpg", "http://img.alicdn.com/imgextra/i4/489668278/O1CN01DY1wLI2B1N80TIy2b_!!489668278.jpg"],
 "categoryId": "121474010",
 "rootCategoryId": "1801",
 "brandValueId": "78274752",
 "skuText": "请选择化妆品净含量 ",
 "countMultiple": [],
 "exParams": {},
 "commentCount": "2460",
 "favcount": "4630",
 "taobaoDescUrl": "http://h5.m.taobao.com/app/detail/desc.html?_isH5Des=true#!id=586774343772&type=0&f=TB1tSPJcG61gK0jSZFl8qtDKFla&sellerType=B",
 "tmallDescUrl": "//mdetail.tmall.com/templates/pages/desc?id=586774343772",
 "taobaoPcDescUrl": "http://h5.m.taobao.com/app/detail/desc.html?_isH5Des=true#!id=586774343772&type=1&f=TB18AMDauH2gK0jSZJn8quT1Fla&sellerType=B",
 "moduleDescUrl": "http://hws.m.taobao.com/d/modulet/v5/WItemMouldDesc.do?id=586774343772&f=TB1yPfJcND1gK0jSZFK8qwJrVXa",
 "openDecoration": false,
 "moduleDescParams": {
 "f": "TB1yPfJcND1gK0jSZFK8qwJrVXa",
 "id": "586774343772"
 },
 "h5moduleDescUrl": "//mdetail.tmall.com/templates/pages/itemDesc?id=586774343772",
 "cartUrl": "https://h5.m.taobao.com/awp/base/cart.htm"
 },
 "mockData": "{\"delivery\":{},\"trade\":{\"buyEnable\":true,\"cartEnable\":true},\"feature\":{\"hasSku\":true,\"showSku\":true},\"price\":{\"price\":{\"priceText\":\"238.00\"}},\"skuCore\":{\"sku2info\":{\"0\":{\"price\":{\"priceMoney\":23800,\"priceText\":\"238.00\",\"priceTitle\":\"价格\"},\"quantity\":100},\"4151897598898\":{\"price\":{\"priceMoney\":23800,\"priceText\":\"238.00\",\"priceTitle\":\"价格\"},\"quantity\":100}},\"skuItem\":{\"hideQuantity\":true}}}",
 "params": {
 "trackParams": {
 "brandId": "78274752",
 "BC_type": "B",
 "categoryId": "121474010"
 }
 },
 "props": {
 "groupProps": [{
 "基本信息": [{
 "品牌": "Hanxuan Herbal/汉萱本草 "
 }, {
 "面膜单品": "酵素卵壳面纱霜 "
 }, {
 "产地": "中国 "
 }, {
 "上市时间": "2018年 "
 }, {
 "功效": "水润饱满 提拉紧致 "
 }, {
 "化妆品净含量": "30g "
 }, {
 "规格类型": "正常规格 "
 }, {
 "是否为特殊用途化妆品": "否 "
 }, {
 "限期使用日期范围": "2021-01-28至2021-02-05 "
 }, {
 "化妆品保质期": "36个月 "
 }]
 }]
 },
 "props2": {},
 "propsCut": "品牌 面膜单品 产地 上市时间 功效 化妆品净含量 规格类型 是否为特殊用途化妆品 限期使用日期范围 化妆品保质期 ",
 "rate": {
 "totalCount": "2460",
 "keywords": [{
 "attribute": "620-11",
 "word": "质量很好",
 "count": "38",
 "type": "1"
 }, {
 "attribute": "824-11",
 "word": "保湿滋润",
 "count": "18",
 "type": "1"
 }, {
 "attribute": "520-11",
 "word": "很划算",
 "count": "14",
 "type": "1"
 }, {
 "attribute": "124-11",
 "word": "味道好闻",
 "count": "12",
 "type": "1"
 }, {
 "attribute": "2524-11",
 "word": "清洁度强",
 "count": "12",
 "type": "1"
 }, {
 "attribute": "10120-11",
 "word": "服务不错",
 "count": "11",
 "type": "1"
 }],
 "rateList": [{
 "content": "第二次购买了",
 "userName": "一**了",
 "headPic": "http://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png_80x80.jpg",
 "memberLevel": "4",
 "dateTime": "2019-09-16",
 "skuInfo": "化妆品净含量:30g",
 "tmallMemberLevel": "1",
 "headExtraPic": "",
 "memberIcon": "",
 "isVip": "false",
 "feedId": "1058151584493"
 }]
 },
 "resource": {
 "entrances": {
 "askAll": {
 "icon": "https://gw.alicdn.com/tps/TB1J7X6KXXXXXc4XXXXXXXXXXXX-102-60.png",
 "text": "\"好用吗？会不会刺激\"",
 "link": "//h5.m.taobao.com/wendajia/question2017.html?refId=586774343772"
 }
 }
 },
 "seller": {
 "userId": "489668278",
 "shopId": "62572383",
 "shopName": "汉萱本草旗舰店",
 "shopUrl": "tmall://page.tm/shop?item_id=586774343772&shopId=62572383",
 "taoShopUrl": "//shop.m.taobao.com/shop/shop_index.htm?user_id=489668278&item_id=586774343772",
 "shopIcon": "http://img.alicdn.com/imgextra//07/f8/TB1MVoLjdknBKNjSZKPSut6OFXa.jpg",
 "fans": "5.4万",
 "allItemCount": "22",
 "newItemCount": "1",
 "showShopLinkIcon": false,
 "shopCard": "掌柜近期上新1件宝贝，速览",
 "sellerType": "B",
 "shopType": "B",
 "evaluates": [{
 "title": "宝贝描述",
 "score": "4.8 ",
 "type": "desc",
 "level": "1",
 "levelText": "高",
 "levelTextColor": "#999999",
 "levelBackgroundColor": "#EEEEEE",
 "tmallLevelTextColor": "#999999",
 "tmallLevelBackgroundColor": "#EEEEEE"
 }, {
 "title": "卖家服务",
 "score": "4.8 ",
 "type": "serv",
 "level": "0",
 "levelText": "平",
 "levelTextColor": "#999999",
 "levelBackgroundColor": "#EEEEEE",
 "tmallLevelTextColor": "#999999",
 "tmallLevelBackgroundColor": "#EEEEEE"
 }, {
 "title": "物流服务",
 "score": "4.8 ",
 "type": "post",
 "level": "0",
 "levelText": "平",
 "levelTextColor": "#999999",
 "levelBackgroundColor": "#EEEEEE",
 "tmallLevelTextColor": "#999999",
 "tmallLevelBackgroundColor": "#EEEEEE"
 }],
 "sellerNick": "汉萱本草旗舰店",
 "creditLevel": "16",
 "creditLevelIcon": "//gw.alicdn.com/tfs/TB1QoJUIwmTBuNjy1XbXXaMrVXa-84-36.png?getAvatar=avatar",
 "brandIcon": "//gw.alicdn.com/tfs/TB11YdTrRsmBKNjSZFsXXaXSVXa-263-36.png",
 "brandIconRatio": "7.3",
 "starts": "2010-08-26 13:17:43",
 "goodRatePercentage": "100.00%",
 "fbt2User": "汉萱本草旗舰店",
 "simpleShopDOStatus": "1"
 },
 "skuBase": {
 "skus": [{
 "skuId": "4151897598898",
 "propPath": "122216906:75367020"
 }],
 "props": [{
 "pid": "122216906",
 "name": "化妆品净含量",
 "values": [{
 "vid": "75367020",
 "name": "30g"
 }]
 }]
 },
 "vertical": {
 "askAll": {
 "askText": "好用吗？会不会刺激",
 "askIcon": "https://gw.alicdn.com/tps/TB1J7X6KXXXXXc4XXXXXXXXXXXX-102-60.png",
 "linkUrl": "//h5.m.taobao.com/wendajia/question2017.html?refId=586774343772",
 "title": "问大家(17)",
 "questNum": "17",
 "showNum": "2",
 "modelList": [{
 "askText": "好用吗？会不会刺激",
 "answerCountText": "2个回答"
 }, {
 "askText": "一次最好敷多久呀",
 "answerCountText": "3个回答"
 }],
 "model4XList": [{
 "askText": "好用吗？会不会刺激",
 "answerCountText": "2个回答",
 "askIcon": "//gw.alicdn.com/tfs/TB1lneilZLJ8KJjy0FnXXcFDpXa-36-36.png",
 "askTextColor": "#162B36"
 }, {
 "askText": "一次最好敷多久呀",
 "answerCountText": "3个回答",
 "askIcon": "//gw.alicdn.com/tfs/TB1lneilZLJ8KJjy0FnXXcFDpXa-36-36.png",
 "askTextColor": "#162B36"
 }]
 }
 }
 }
 }
 */

@end
