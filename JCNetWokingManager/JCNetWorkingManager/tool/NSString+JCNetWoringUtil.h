//
//  NSString+JCNetWoringUtil.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JCNetWoringUtil)

/**
 * 将json字典直接转化为格式好的json字符串
 */
+ (NSString *)JSONStringForDictionary:(NSDictionary *)dictionary;

@end
