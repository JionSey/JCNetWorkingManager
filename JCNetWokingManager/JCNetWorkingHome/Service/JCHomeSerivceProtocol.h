//
//  JCHomeSerivceProtocol.h
//  YXMasterNetWorkingManager
//
//  Created by Jackie on 2018/2/8.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCNetWorkingParameterModel.h"

@protocol JCHomeSerivceProtocol <NSObject>
    
/**
 *
 *  @brief 启动页
 *
 */
- (void)requestStartUpWithParameter:(JCNetWorkingParameterModel *)parameterModel Success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
