//
//  JCNetWorkingServiceTool.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCNetWorkingServiceProtocol.h"
#import "JCNetWorkingModelProtocol.h"
#import "JCNetWorkingCacheProtocol.h"

@interface JCNetWorkingServiceTool : NSObject <JCNetWorkingServiceProtocol>

@property (nonatomic, copy) Class <JCNetWorkingModelProtocol> netWorkingModelProtocolClass;
@property (nonatomic, strong) id <JCNetWorkingCacheProtocol> netWorkingCacheTool;

@end
