//
//  JCHomeService.m
//  YXMasterNetWorkingManager
//
//  Created by Jackie on 2018/2/8.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCHomeService.h"

static NSString *const kStartPic = @"/zbs/index/startpic";       //启动图片

@implementation JCHomeService
    
- (void)requestStartUpWithParameter:(JCNetWorkingParameterModel *)parameterModel Success:(RequestSuccess)success failure:(RequestFailure)failure {
    
    JCNetWorkingRequest *request = [JCNetWorkingRequest requestWithDomainType:JCDomainTypeHome path:kStartPic parameterModel:parameterModel responseClass:[JCHomeStarPageResponseModel class]];
    request.netWorkingModelProtocolClass = self.netWorkingModelProtocolClass;
    request.netWorkingCacheTool = self.netWorkingCacheTool;
    [self sendRequest:request success:success failure:failure];
}

@end
