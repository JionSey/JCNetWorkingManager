//
//  JCNetWorkingRequest.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingRequest.h"

@implementation JCNetWorkingRequest

- (instancetype)init
{
    if (self = [super init]) {
        _method = @"POST";
    }
    return self;
}

- (void)setPath:(NSString *)path
{
    _path = [[JCNetWorkingEnvironmentConfigure showJCEnvironmentConfigure] configPathWithDomainTypeDefault:self.domainType path:path];
}

- (NSDictionary *)params
{
    return [self.netWorkingModelProtocolClass configDictWithResponseModel:_parameter];
}

+ (JCNetWorkingRequest *)requestWithPath:(NSString *)path parameterModel:(JCNetWorkingParameterModel *)parameterModel responseClass:(Class)responseClass
{
    JCNetWorkingRequest *baseRequest = [[JCNetWorkingRequest alloc] init];
    baseRequest.path = path;
    baseRequest.parameter = parameterModel;
    baseRequest.responseClass = responseClass;
    return baseRequest;
};

+ (JCNetWorkingRequest *)requestWithDomainType:(JCDomainType)domainType path:(NSString *)path parameterModel:(JCNetWorkingParameterModel *)parameterModel responseClass:(Class)responseClass
{
    JCNetWorkingRequest *baseRequest = [[JCNetWorkingRequest alloc] init];
    baseRequest.domainType = domainType;
    baseRequest.path = path;
    baseRequest.parameter = parameterModel;
    baseRequest.responseClass = responseClass;
    return baseRequest;
}

+ (JCNetWorkingRequest *)cacheableRequestWithPath:(NSString *)path parameterModel:(JCNetWorkingParameterModel *)parameterModel responseClass:(Class)responseClass customCacheKey:(JCCustomCacheKey)customCacheKey
{
    JCNetWorkingRequest *baseRequest = [[JCNetWorkingRequest alloc] init];
    baseRequest.path = path;
    baseRequest.parameter = parameterModel;
    baseRequest.responseClass = responseClass;
    baseRequest.cacheEnable = YES;
    baseRequest.customCacheKey = customCacheKey;
    return baseRequest;
}

@end
