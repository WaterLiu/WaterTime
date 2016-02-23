//
//  MRArrayParse.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRArrayParse.h"
#import "MRDicParse.h"
#import "MREntityParse.h"

@implementation MRArrayParse


+ (NSArray *)parseArray:(NSArray *)array className:(NSString *)className error:(NSError **)error
{
    NSArray *originArray = array;
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<[originArray count]; i++)
    {
        id temp = originArray[i];
        if ([temp isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *tempDic = (NSDictionary *)temp;
            [modelArray addObject:[MREntityParse parseDic:tempDic className:className error:error]];
        }
        else if ([temp isKindOfClass:[NSArray class]])
        {
            NSArray* tempArray = (NSArray *)temp;
            [modelArray addObject:[MRArrayParse parseArray:tempArray className:className error:error]];
        }
        else
        {
            [modelArray addObject:temp];
        }
    }
    
    return [[NSArray alloc] initWithArray:modelArray];
}
@end
