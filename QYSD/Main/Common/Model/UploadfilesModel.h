//
//  UploadfilesModel.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadfilesModel : NSObject

//FileGuid:文件Guid, FileName:文件名称, RelativePath:文件相对路径
@property (nonatomic, copy) NSString *FileGuid;
@property (nonatomic, copy) NSString *FileName;
@property (nonatomic, copy) NSString *RelativePath;


@end


