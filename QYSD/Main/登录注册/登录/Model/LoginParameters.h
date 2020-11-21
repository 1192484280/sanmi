//
//  LoginParameters.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParameters : NSObject

@property (nonatomic, copy) NSString *deviceid;//设备号，无值传空字符串
@property (nonatomic, copy) NSString *code;//调起微信后拿到的授权临时票据
@property (nonatomic, copy) NSString *openid;//授权用户唯一标识
@property (nonatomic, copy) NSString *nickname;//用户昵称
@property (nonatomic, assign) NSInteger sex; //普通用户性别，1 为男性，2 为女性
@property (nonatomic, copy) NSString *province;// 普通用户个人资料填写的省份
@property (nonatomic, copy) NSString *city;// 普通用户个人资料填写的城市
@property (nonatomic, copy) NSString *country;// 国家，如中国为 CN
@property (nonatomic, copy) NSString *headimgurl;//用户头像，最后一个数值代表正方形头像大小（有 0、46、64、96、132 数值可选，0 代表 640*640 正方形头像），用户没有头像时该项为空
@property (nonatomic, copy) NSString *privilege;// 用户特权信息，逗号隔开（微信为数组，需转换），如微信沃卡用户为（chinaunicom）
@property (nonatomic, copy) NSString *unionid;// 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的 unionid 是唯一的 

@end


