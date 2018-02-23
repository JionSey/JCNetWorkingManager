//
//  JCNetWorkingRequest.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCNetWorkingServiceTool.h"
#import "JCNetWorkingClient.h"
#import "JCNetWorkingEnvironmentConfigure.h"

#import "JCNetWorkingParameterModel.h"
#import "JCNetWorkingResponseModel.h"
#import "JCNetWorkingErrorResponseModel.h"

#import "JCNetWorkingModelProtocol.h"
#import "JCNetWorkingCacheProtocol.h"

typedef void(^JCConstructingBodyBlock)(id <AFMultipartFormData> formData);
typedef void(^JCProgress)(NSProgress *progress);
typedef NSString *(^JCCustomCacheKey)(NSString *path, id parameter);

@interface JCNetWorkingRequest : NSObject

// 生成一个普通请求的实例
+ (JCNetWorkingRequest *)requestWithPath:(NSString *)path
                    parameterModel:(JCNetWorkingParameterModel *)parameterModel
                     responseClass:(Class)responseClass;

+ (JCNetWorkingRequest *)requestWithDomainType:(JCDomainType)domainType
                                    path:(NSString *)path
                          parameterModel:(JCNetWorkingParameterModel *)parameterModel
                           responseClass:(Class)responseClass;

// 生成一个可缓存的请求实例
+ (JCNetWorkingRequest *)cacheableRequestWithPath:(NSString *)path
                             parameterModel:(JCNetWorkingParameterModel *)parameterModel
                              responseClass:(Class)responseClass
                             customCacheKey:(JCCustomCacheKey)customCacheKey;

@property (nonatomic, copy) Class <JCNetWorkingModelProtocol> netWorkingModelProtocolClass;
@property (nonatomic, strong) id <JCNetWorkingCacheProtocol> netWorkingCacheTool;

// Domain
@property (nonatomic,assign) JCDomainType domainType;
//请求地址
@property (nonatomic, copy) NSString *path;
//请求参数Model
@property (nonatomic, strong) JCNetWorkingParameterModel *parameter;

//解析的ResponseModelClass
@property (nonatomic, copy) Class responseClass;
//请求方式
@property (nonatomic, copy) NSString *method;

// 是否开启缓存
@property (nonatomic, assign) BOOL cacheEnable;

// 自定义缓存Key, 默认使用 Path 作为缓存Key
@property (nonatomic, copy) JCCustomCacheKey customCacheKey;

// 上传
@property (nonatomic, copy) JCConstructingBodyBlock constructingBodyBlock;

@property (nonatomic, copy) JCProgress uploadProgress;

// service 获取参数方法
- (NSDictionary *)params;

@end
