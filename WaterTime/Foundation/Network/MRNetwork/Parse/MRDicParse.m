//
//  MRDicParse.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRDicParse.h"
#import <objc/runtime.h>

@implementation MRDicParse

+ (NSDictionary *)parseJsonData:(NSData *)data error:(NSError **)error
{
    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
    NSDictionary *newContent = [self removeNullValue:content];
    return newContent;
}

+ (NSDictionary *)parseInstance:(id<MRDicParseProtocol>)instance class:(Class)cls error:(NSError **)error
{
    
    NSDictionary *propertyKeyMapDic;
    if ([[instance class] respondsToSelector:@selector(parsePropertyKeyMapDic)])
    {
        propertyKeyMapDic = [[instance class] parsePropertyKeyMapDic];
    }
    
    NSMutableDictionary *propertyDic = [[NSMutableDictionary alloc] init];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = properties[i];
        //取属性名称
        NSString *keyStr = [NSString stringWithUTF8String:property_getName(property)];
        id value = [(NSObject *)instance valueForKey:keyStr];
        
        NSString *propertyName = propertyKeyMapDic[keyStr] ? propertyKeyMapDic[keyStr] : keyStr;

        propertyDic[propertyName] = value;
    }
    
    free(properties);
    
    NSString *baseClassName;
    if ([[instance class] respondsToSelector:@selector(parseBaseClassName)])
    {
        baseClassName = [[instance class] parseBaseClassName];
    }
    Class superClass = class_getSuperclass([instance class]);
    if (superClass && superClass != [NSObject class]
        && ![baseClassName isEqualToString:NSStringFromClass(superClass)])
    {
        NSDictionary *superDic = [MRDicParse parseInstance:instance class:superClass error:error];
        [propertyDic addEntriesFromDictionary:superDic];
    }
    
    return [NSDictionary dictionaryWithDictionary:propertyDic];
}

@end
