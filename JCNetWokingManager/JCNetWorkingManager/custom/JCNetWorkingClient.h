//
//  JCNetWorkingClient.h
//  JCNetWokingManager
//
//  Created by Jackie on 2018/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface JCNetWorkingClient : NSObject

/**
 *  AFHTTPSessionManager 实例
 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

//@property (nonatomic, readonly) MNReachability *networkReachablity;

//@property (nonatomic, readonly) AFNetworkReachabilityManager *networkReachablity;
/**
 *  获取 FNNetworkClient 实例
 *
 *  @return FNNetworkClient 实例, 此方法返回单例
 */
+ (JCNetWorkingClient *)defaultClient;

/**
 *  发送 API 请求
 *
 *  @param method  请求方式, @"GET", @"POST"...
 *  @param path    API 地址, 如果传入 pathHandle, 则会通过 pathHandle 处理 path, 并返回最终地址
 *  @param params  参数
 *  @return 发送此次请求的 NSURLSessionDataTask 实例
 */
- (NSURLSessionDataTask *)requestWithMethod:(NSString *)method
                                   withPath:(NSString *)path
                                 withParams:(NSDictionary *)params
                          completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
/**
 *  上传文件
 *
 *  @param path           API 地址, 如果传入 pathHandle, 则会通过 pathHandle 处理 path, 并返回最终地址
 *  @param parameters     请求参数
 *  @param block          文件处理block
 *  @param uploadProgress 上传进度回调
 *  @param success        成功回调
 *  @param failure        失败回调
 *
 *  @return 发送此次请求的 NSURLSessionDataTask 实例
 */
- (NSURLSessionDataTask *)uploadWithPath:(NSString *)path
                              parameters:(id)parameters
               constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                progress:(void (^)(NSProgress *uploadProgress)) uploadProgress
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

/**
 *  下载文件
 *
 *  @param path                  下载地址，此处不会使用 pathHandle
 *  @param downloadProgressBlock 下载进度的block
 *  @param destination           获取存放下载文件地址的block
 *  @param completionHandler     下载完成的block
 *
 *  @return 发送此次请求的 NSURLSessionDownloadTask 实例
 */
- (NSURLSessionDownloadTask *)downloadWithPath:(NSString *)path
                                      progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                   destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                             completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 *  取消某路径下所有请求
 *
 *  @param path 地址
 */
- (void)cancelRequestsForPath:(NSString *)path;

@end
