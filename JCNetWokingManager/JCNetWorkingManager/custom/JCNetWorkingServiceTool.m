//
//  JCNetWorkingServiceTool.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingServiceTool.h"
#import "JCNetWorkingRequest.h"
#import "JCNetWorkingResponseModel.h"
#import "JCNetWorkingErrorResponseModel.h"
#import "JCNetWorkingClient.h"

#import "NSString+JCNetWoringUtil.h"
#import "NSDictionary+JCNetWoringUtil.h"

@interface JCNetWorkingServiceTool()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation JCNetWorkingServiceTool

- (void)sendRequest:(JCNetWorkingRequest *)request success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    [self sendRequest:request completed:^(JCNetWorkingResponseModel *responseModel, BOOL isCache, BOOL isFail) {
        if (isFail) {
            if (failure) {
                JCNetWorkingErrorResponseModel *errorResponseModel = (JCNetWorkingErrorResponseModel*)responseModel;
                failure(errorResponseModel);
            }
        } else {
            success(responseModel, isCache);
        }
    }];
}

- (void)sendRequest:(JCNetWorkingRequest *)request completed:(void (^)(id, BOOL,BOOL))completed {
    
    if ([self networkError]) {
        [self handleFailResponseModel:nil errorCode:JCNoNetworkConnectError completed:completed];
        return;
    }
    
    if (request.constructingBodyBlock) {
        NSAssert([request.method isEqualToString:@"POST"], @"上传文件必需是POST");
        _dataTask = [[JCNetWorkingClient defaultClient] uploadWithPath:request.path parameters:[request params] constructingBodyWithBlock:request.constructingBodyBlock progress:request.uploadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    } else {
        _dataTask = [[JCNetWorkingClient defaultClient] requestWithMethod:request.method withPath:request.path withParams:[request params] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

            //            #ifdef TEST_ENV
            [self logRequestResponse:responseObject path:request.path params:[request params] isOK:(error?YES:NO)];
            //            #endif
            [self handleURLResponse:response ResponseObect:responseObject error:error request:request completed:completed];
        }];
    }
}

- (void)handleURLResponse:(NSURLResponse *)URLResponse ResponseObect:(id)responseObject error:(NSError *)error request:(JCNetWorkingRequest *)request completed:(void (^)(id, BOOL, BOOL))completed
{
    //      HTML----->json
    if (!responseObject) {
        [self handleFailResponseModel:responseObject errorCode:JCNoNetworkConnectError completed:completed];
        return;
    }
    
    id responseModel = [self.netWorkingModelProtocolClass configModelWithResponseObject:responseObject class:request.responseClass];
    
    if (!responseModel) {
        [self handleFailResponseModel:responseObject errorCode:JCResponseFormatError completed:completed];
        return;
    }
    
    JCNetWorkingResponseModel *tempModel = (JCNetWorkingResponseModel *)responseModel;
    if (tempModel.code.integerValue >= 0) {
        [self.netWorkingCacheTool setCacheObject:responseObject error:&error];
        if (completed) {
            completed(responseModel ,NO ,NO);
        }
    }else{
        if (completed) {
            completed(responseModel ,NO ,YES);
        }
    }
}

- (void)handleFailResponseModel:(id)responseModel errorCode:(JCErrorCode)errorCode completed:(void (^)(id, BOOL, BOOL))completed
{
    
    JCNetWorkingErrorResponseModel *errorModel = nil;
    if (errorCode == JCGeneralError) {
        errorModel = [self.netWorkingModelProtocolClass configModelWithResponseObject:responseModel class:[JCNetWorkingErrorResponseModel class]];
    }else{
        errorModel = [JCNetWorkingErrorResponseModel initWithErrorCode:errorCode];
    }
    if (completed) {
        completed(errorModel,NO,YES);
    }
}

- (void)logRequestResponse:(id)responseObject path:(NSString *)path params:(NSDictionary *)params isOK:(BOOL)isOK
{
    
    if (!responseObject) {
        return;
    }
#if DEBUG
    NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *jsonStatus = isOK ? @"OK" : @"Error";
    NSString *responseJSONString = [requestDic isKindOfClass:[NSDictionary class]] ? [NSString JSONStringForDictionary:requestDic] : responseObject;
    NSLog(@"\nparams\n%@", params);
    NSLog(@"path\n%@", path);
    NSLog(@"\n==============================  Begin  ====================================\n---URLPath:\n%@\n---Response:  (JSON) = \n%@\n==============================   End   ====================================\n----%@", path, responseJSONString,jsonStatus);
#endif
    
}

- (void)cancelAllRequests {
    
    [[JCNetWorkingClient defaultClient].sessionManager.operationQueue cancelAllOperations];
}

- (void)cancelCurrentRequest {
    
    [self.dataTask cancel];
}

- (void)cancelRequestForPath:(NSString *)path {
    
    [[JCNetWorkingClient defaultClient] cancelRequestsForPath:path];
}

- (BOOL)networkError {
    
    return NO;
}

@end
