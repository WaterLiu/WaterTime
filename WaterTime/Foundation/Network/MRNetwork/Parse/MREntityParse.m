//
//  MREntityParse.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MREntityParse.h"
#import <objc/runtime.h>
#import "MRArrayParse.h"

@implementation MREntityParse

+ (id<MREntityParseProtocol>)parseDic:(NSDictionary *)dic className:(NSString *)className error:(NSError **)error
{
    if (className == nil || [className isEqualToString:@""])
    {
        NSLog(@"Error: className is empty");
        return nil;
    }
    
    Class dymaticClass = NSClassFromString(className);
    if (!dymaticClass) {
        NSLog(@"class:%@ not exist",className);
        return nil;
    }
    
    id instance = [[dymaticClass alloc] init];
    
    NSDictionary *propertyKeyMapDic;
    NSDictionary *classKeyMapDic;

    if ([[instance class] respondsToSelector:@selector(parsePropertyKeyMapDic)])
    {
        propertyKeyMapDic = [[instance class] parsePropertyKeyMapDic];
    }
    
    if ([[instance class] respondsToSelector:@selector(parseClassKeyMapDic)])
    {
        classKeyMapDic = [[instance class] parseClassKeyMapDic];
    }
    
    for (id key in [dic allKeys])
    {
        id obj = dic[key];
        if ([obj isKindOfClass:[NSArray class]])
        {
            NSString *keyStr = (NSString *)key;
            NSString *propertyName = propertyKeyMapDic[keyStr] ? propertyKeyMapDic[keyStr] : keyStr;
            NSString *arrayClassName = classKeyMapDic[keyStr] ? classKeyMapDic[keyStr] : keyStr;
            NSArray *array = [MRArrayParse parseArray:obj className:arrayClassName error:error];
            [instance setValue:array forKey:propertyName];
            
        }
        else if([obj isKindOfClass:[NSDictionary class]])
        {
            NSString *keyStr = (NSString *)key;
            NSDictionary *modelDic = dic[key];
            
            NSString *propertyName = propertyKeyMapDic[keyStr] ? propertyKeyMapDic[keyStr] : keyStr;
            NSString *dicClassName = classKeyMapDic[keyStr] ? classKeyMapDic[keyStr] : keyStr;
            
            [instance setValue:[MREntityParse parseDic:modelDic className:dicClassName error:error] forKey:propertyName];
        }
        else
        {
            NSString *keyStr = (NSString *)key;
            
            NSString *propertyName = propertyKeyMapDic[keyStr] ? propertyKeyMapDic[keyStr] : keyStr;
            [instance setValue:obj forKey:propertyName];

        }
    }
    
    return instance;
}

@end
