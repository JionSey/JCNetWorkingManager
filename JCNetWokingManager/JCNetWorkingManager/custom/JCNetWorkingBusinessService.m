//
//  JCBusinessService.m
//  GoldMaster
//
//  Created by Jackie on 16/7/22.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "JCNetWorkingBusinessService.h"
#import "JCNetWorkingProtocolManager.h"

@implementation JCNetWorkingBusinessService

- (instancetype)init {
    
    if (self = [super init]) {
        self.netWorkingModelProtocolClass = [JCNetWorkingProtocolManager showJCNetWorkingProtocolManager].netWorkingModelProtocolClass;
        self.netWorkingCacheTool = [JCNetWorkingProtocolManager showJCNetWorkingProtocolManager].netWorkingCacheTool;
    }
    return self;
}

@end

