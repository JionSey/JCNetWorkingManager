//
//  JCNetWorkingCacheProtocol.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JCNetWorkingCacheProtocol <NSObject>

- (NSString *)cacheKey;

- (void)setCacheObject:(id)cacheObject error:(NSError *__autoreleasing *)error;

- (id)cacheObject;

- (id)cacheResponseModelWithClass:(Class)cls;

@end
