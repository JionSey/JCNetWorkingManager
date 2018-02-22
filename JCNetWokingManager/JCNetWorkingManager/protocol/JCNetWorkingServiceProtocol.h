//
//  JCNetWorkingServiceProtocol.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCNetWorkingParameterModel.h"
#import "JCNetWorkingResponseModel.h"
#import "JCNetWorkingErrorResponseModel.h"

@class JCNetWorkingRequest;

typedef void(^RequestSuccess)(id responseModel, BOOL isCache);
typedef void(^RequestFailure)(JCNetWorkingErrorResponseModel *responseModel);

@protocol JCNetWorkingServiceProtocol <NSObject>

/**
 *  请求方法
 *
 *  @param request FNBaseRequest 或其子类
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
- (void)sendRequest:(JCNetWorkingRequest *)request success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 *  取消所有请求
 */
- (void)cancelAllRequests;

/**
 *  取消当前请求
 */
- (void)cancelCurrentRequest;

/**
 *  取消指定路径请求
 */
- (void)cancelRequestForPath:(NSString *)path;

/**
 *  检查网络状态，如果网络不可用返回YES
 *
 */
- (BOOL)networkError;

@end
