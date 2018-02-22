//
//  JCNetWorkingCacheTool.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingCacheTool.h"
#import "YYCache.h"

@interface JCNetWorkingCacheTool()

@property (nonatomic, strong) YYCache *yyCache;

@end

@implementation JCNetWorkingCacheTool

+ (instancetype)sharedInstance {
    
    static JCNetWorkingCacheTool *netWorkingCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkingCache = [JCNetWorkingCacheTool new];
    });
    return netWorkingCache;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _yyCache = [[YYCache alloc] initWithName:@"JCNetworking"];
    }
    return self;
}

- (NSString *)cacheKey {
    
    return self.path;
}

- (void)setCacheObject:(id)cacheObject error:(NSError *__autoreleasing *)error {
    
    [[JCNetWorkingCacheTool sharedInstance].yyCache setObject:cacheObject forKey:[self cacheKey]];
}

- (id)cacheObject {
    
    return [[JCNetWorkingCacheTool sharedInstance].yyCache objectForKey:[self cacheKey]];
}

- (id)cacheResponseModelWithClass:(Class)cls {
    
    id object = [self transformResponseObject:[self cacheObject]];
    id model = [self.netWorkingModelProtocolClass configModelWithResponseObject:object class:cls];
    return model;
}

- (id)transformResponseObject:(id)responseObject
{
    NSError *error = nil;
    NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
    return requestDic;
}

@end
