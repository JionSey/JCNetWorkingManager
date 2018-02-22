//
//  JCNetWokingModelProtocol.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JCNetWorkingModelProtocol <NSObject>

// 模型变成字典
+ (NSDictionary *)configDictWithResponseModel:(id)responseObject;

// 将数据转换成模型
+ (id)configModelWithResponseObject:(id)responseObject class:(Class)cls;

@end
