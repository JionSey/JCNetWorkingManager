//
//  JCNetWorkingCacheTool.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCNetWorkingCacheProtocol.h"
#import "JCNetWorkingModelProtocol.h"

@interface JCNetWorkingCacheTool : NSObject <JCNetWorkingCacheProtocol>

@property (nonatomic, copy)   NSString     *path;
@property (nonatomic, strong) NSDictionary *parameter;

@property (nonatomic, copy) Class <JCNetWorkingModelProtocol> netWorkingModelProtocolClass;

+ (instancetype)sharedInstance;

@end
