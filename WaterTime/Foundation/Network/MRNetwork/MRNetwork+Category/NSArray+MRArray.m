//
//  NSArray+MRArray.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/1/15.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "NSArray+MRArray.h"
#import <objc/runtime.h>
#import "NSDictionary+MRDictionary.h"

@implementation NSArray (MRArray)

- (id)parseToClass:(NSString *)className keyMapDic:(NSDictionary *)keyMapDic
{
    if (className == nil || [className isEqualToString:@""])
    {
        NSLog(@"Error: className is empty");
        return nil;
    }
    NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSArray class]])
        {
            [mutableArray addObject:[obj parseToClass:className keyMapDic:keyMapDic]];
        }
        else if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *modelDic = obj;
            [mutableArray addObject:[modelDic parseToClass:className keyMapDic:keyMapDic]];
        }
        else
        {
            if (![obj isKindOfClass:[NSNull class]])
            {
                [mutableArray addObject:obj];
            }
        }
    }];
    
    return mutableArray;
}

@end
