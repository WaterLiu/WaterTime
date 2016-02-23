//
//  MRParse.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRParse.h"

@implementation MRParse

+ (id)removeNullValue:(id)object
{
    if ([object isKindOfClass:[NSArray class]])
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *originArray = (NSArray *)object;
        for (NSInteger i = 0; i < [originArray count]; i++)
        {
            id result = [self removeNullValue:originArray[i]];
            if (result)
            {
                [array addObject:result];
            }
        }
        return array;
    }
    else if ([object isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
        
        for (id key in [dic allKeys])
        {
            id value = dic[key];
            dic[key] = [self removeNullValue:value];
        }
        
        return dic;
    }
    else
    {
        if ([object isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        else
        {
            return object;
        }
    }
}

@end
