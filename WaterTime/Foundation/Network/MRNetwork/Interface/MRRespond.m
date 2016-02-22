//
//  MRRespond.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRespond.h"
#import <objc/runtime.h>

@implementation MRRespond
@synthesize request = _request;

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)description
{
    
    NSMutableDictionary *descriptionDic = [[NSMutableDictionary alloc] init];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = properties[i];
        
        //取属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        descriptionDic[propertyName] = [self valueForKey:propertyName];
        
    }
    
    free(properties);

    return [descriptionDic description];
}

#pragma mark - MRParseProtocol Method

+ (NSDictionary<NSString *,NSString *> *)parsePropertyKeyMapDic
{
    return @{};
}

#pragma mark - MRArrayParseProtocol Method

#pragma mark - MRDicParseProtocol Method
+ (NSString *)parseBaseClassName
{
    return @"NSObject";
}

#pragma mark - MREntityParseProtocol Method

+ (NSDictionary<NSString *,NSString *> *)parseClassKeyMapDic
{
    return @{};
}

@end



@implementation MRUploadRespond



@end


@implementation MRDownloadRespond



@end

