//
//  NSDictionary+MRDictionary.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/11.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "NSDictionary+MRDictionary.h"
#import "NSString+MRString.h"
#import "NSArray+MRArray.h"

#import <objc/runtime.h>

@implementation NSDictionary (MRDictionary)

-(NSString*) mr_urlEncodedKeyValueString
{
    
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in self)
    {
        NSObject *value = [self valueForKey:key];
        if([value isKindOfClass:[NSString class]])
        {
            [string appendFormat:@"%@=%@&", [key mr_urlEncodedString], [((NSString*)value) mr_urlEncodedString]];
        }
        else
        {
            [string appendFormat:@"%@=%@&", [key mr_urlEncodedString], value];
        }
    }
    
    if([string length] > 0)
    {
        [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
    }
    
    return string;
}


-(NSString*) mr_jsonEncodedKeyValueString
{
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0 
                                                     error:&error];
    if(error)
    {
        NSLog(@"JSON Parsing Error: %@", error);
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


-(NSString*) mr_plistEncodedKeyValueString
{
    
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self
                                                              format:NSPropertyListXMLFormat_v1_0
                                                             options:0 error:&error];
    if(error)
    {
        NSLog(@"JSON Parsing Error: %@", error);
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (id)parseToClass:(NSString *)className keyMapDic:(NSDictionary *)keyMapDic
{
    if (className == nil || [className isEqualToString:@""])
    {
        NSLog(@"Error: className is empty");
        return nil;
    }
    
    Class dymaticClass = NSClassFromString(className);
    if (!dymaticClass)
    {
        NSLog(@"class:%@ not exist",className);
        return nil;
    }
    
    id instance = [[dymaticClass alloc] init];
    
    for (id key in [self allKeys])
    {
        id obj = self[key];
        if ([obj isKindOfClass:[NSArray class]])
        {
            NSString* keyStr = (NSString *)key;
            objc_property_t property = class_getProperty(NSClassFromString(className),[keyStr UTF8String]);
            
            const char * charProperty = property_getAttributes(property);
            
            NSString *propertyName = [NSString stringWithUTF8String:charProperty];
            
            NSRange range = [propertyName rangeOfString:@"<"];
            NSRange range1 = [propertyName rangeOfString:@">"];
            if (range.location == NSNotFound || range1.location == NSNotFound)
            {
                NSString *assertStr = [NSString stringWithFormat:@"数组对象%@请指明内部Object类型",key];
                NSAssert(0,assertStr);
            }
            NSString *modelName = [propertyName substringWithRange:NSMakeRange(range.location + 1, range1.location - range.location - 1)];
            
            NSArray *originArray = self[key];
            NSMutableArray *modelArray = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i<[originArray count]; i++)
            {
                id temp = originArray[i];
                if ([temp isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *tempDic = (NSDictionary *)temp;
                    //keyMap有映射
                    if (keyMapDic[modelName])
                    {
                        [modelArray addObject:[tempDic parseToClass:keyMapDic[modelName] keyMapDic:keyMapDic]];
                    }
                    else
                    {
                        [modelArray addObject:[tempDic parseToClass:modelName keyMapDic:keyMapDic]];
                    }
                }
                else if ([temp isKindOfClass:[NSArray class]])
                {
                    NSArray* tempArray = (NSArray *)temp;
                    if (keyMapDic[modelName])
                    {
                        [modelArray addObject:[tempArray parseToClass:keyMapDic[modelName] keyMapDic:keyMapDic]];
                    }
                    else
                    {
                        [modelArray addObject:[tempArray parseToClass:modelName keyMapDic:keyMapDic]];
                    }
                }else
                {
                    [modelArray addObject:temp];
                }
            }
            if (keyMapDic[key])
            {
                [instance setValue:modelArray forKey:keyMapDic[key]];
            }
            else
            {
                [instance setValue:modelArray forKey:key];
            }
        }else if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *modelDic = self[key];
            if (keyMapDic[key]) {
                [instance setValue:[modelDic parseToClass:keyMapDic[key] keyMapDic:keyMapDic] forKey:key];
            }
            else
            {
                [instance setValue:[modelDic parseToClass:key keyMapDic:keyMapDic] forKey:key];
            }
            
        }else
        {
            if (![obj isKindOfClass:[NSNull class]])
            {
                if (keyMapDic[key]) {
                    [instance setValue:obj forKey:keyMapDic[key]];
                }
                else
                {
                    [instance setValue:obj forKey:key];
                }
            }
        }
    }
    
    return instance;
}




@end
