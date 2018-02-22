//
//  JCNetWorkingModelTool.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingModelTool.h"
#import "MJExtension.h"
#import "NSDictionary+JCNetWoringUtil.h"

@implementation JCNetWorkingModelTool

+ (NSDictionary *)configDictWithResponseModel:(id)responseObject {

    return [[responseObject mj_keyValues] removeNullValues];
}

+ (id)configModelWithResponseObject:(id)responseObject class:(Class)cls {
    
    if ([responseObject isKindOfClass:[NSArray class]]) {
        return [cls mj_objectArrayWithKeyValuesArray:responseObject];
    }
    id responseModel = [cls mj_objectWithKeyValues:responseObject];
    return responseModel;
}

@end
