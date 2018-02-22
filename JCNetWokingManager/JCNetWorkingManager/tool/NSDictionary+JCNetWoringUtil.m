//
//  NSDictionary+JCNetWoringUtil.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "NSDictionary+JCNetWoringUtil.h"

@implementation NSDictionary (JCNetWoringUtil)

- (NSDictionary *)removeNullValues {
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:[self copy]];
    NSArray *keyForNullValues = [mutableDictionary allKeysForObject:[NSNull null]];
    [mutableDictionary removeObjectsForKeys:keyForNullValues];
    
    NSDictionary *dictionary = [mutableDictionary copy];
    
    for (NSString *key in dictionary.allKeys) {
        id value = [dictionary objectForKey:key];
        if ([[value class] isSubclassOfClass:[NSString class]] && [value isEqualToString:@""]) {
            [mutableDictionary removeObjectForKey:key];
        }
        if ([[value class] isSubclassOfClass:[NSDictionary class]]) {
            NSDictionary *tempDictionary = value;
            NSDictionary *cleanDictionary = [tempDictionary removeNullValues];
            [mutableDictionary setObject:cleanDictionary forKey:key];
        }
        if ([[value class] isSubclassOfClass:[NSArray class]]) {
            NSMutableArray *mutabeArray = [[NSMutableArray alloc] initWithArray:value];
            NSArray *tempArray = [mutabeArray copy];
            
            for (NSInteger i = 0; i < tempArray.count; i++) {
                id obj = [tempArray objectAtIndex:i];
                if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
                    NSDictionary *tempDic = obj;
                    NSDictionary *cleanDic = [tempDic removeNullValues];
                    [mutabeArray replaceObjectAtIndex:i withObject:cleanDic];
                }
            }
            [mutableDictionary setObject:mutabeArray forKey:key];
        }
    }
    return [mutableDictionary copy];
}

@end
