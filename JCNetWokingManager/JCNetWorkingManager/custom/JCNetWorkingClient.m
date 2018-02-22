//
//  JCNetWorkingClient.m
//  JCNetWokingManager
//
//  Created by Jackie on 2018/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingClient.h"

@implementation JCNetWorkingClient

+ (JCNetWorkingClient *)defaultClient
{
    static JCNetWorkingClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[JCNetWorkingClient alloc] init];
    });
    return client;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 20.f;
        configuration.timeoutIntervalForResource = 20.f;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        // _sessionManger.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json; charset=utf-8", @"text/html;charset=utf-8", @"application/json;charset=utf-8",nil];
        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (NSURLSessionDataTask *)requestWithMethod:(NSString*)method
                                   withPath:(NSString*)path
                                 withParams:(NSDictionary*)params
                          completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
    NSError *error;
    NSURLRequest *request = [_sessionManager.requestSerializer requestWithMethod:method URLString:path parameters:params error:&error];
    if (error) {
        return nil;
    }
    NSURLSessionDataTask *dataTask = [_sessionManager dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
    return dataTask;
}


- (NSURLSessionDataTask *)uploadWithPath:(NSString *)path
                              parameters:(id)parameters
               constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                progress:(void (^)(NSProgress *))uploadProgress
                                 success:(void (^)(NSURLSessionDataTask *, id))success
                                 failure:(void (^)(NSURLSessionDataTask *, NSError *))failure

{
    NSURLSessionDataTask *dataTask = [_sessionManager POST:path parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
    [dataTask resume];
    return dataTask;
}

- (NSURLSessionDownloadTask *)downloadWithPath:(NSString *)path
                                      progress:(void (^)(NSProgress *))downloadProgressBlock
                                   destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination
                             completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    [downloadTask resume];
    return downloadTask;
}

- (void)cancelRequestsForPath:(NSString *)path
{
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURLSessionDataTask *task = obj;
        if ([task.currentRequest.URL.relativePath hasSuffix:path]) {
            [task cancel];
        }
    }];
}

@end
