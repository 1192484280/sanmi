//
//  UserModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/27.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

/*"AppUserGuid": "0204700D-48DB-48D9-B32D-BEDA1512373E",
"OpenID": "",
"Nickname": "wewed",
"Sex": "1",
"Province": "12342",
"City": "234234",
"Country": "234324",
"HeadImgUrl": ""
*/
@interface UserModel : NSObject

@property (nonatomic, copy) NSString *AppUserGuid;
@property (nonatomic, copy) NSString *OpenID;
@property (nonatomic, copy) NSString *Nickname;
@property (nonatomic, copy) NSString *Sex;
@property (nonatomic, copy) NSString *Province;
@property (nonatomic, copy) NSString *City;
@property (nonatomic, copy) NSString *Country;
@property (nonatomic, copy) NSString *HeadImgUrl;

@end


