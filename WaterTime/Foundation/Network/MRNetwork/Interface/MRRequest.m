//
//  MRRequest.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRequest.h"
#import <objc/runtime.h>
#import "MRRespond.h"

static NSUInteger nextRequestID = 0;

@implementation MRRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestID = @(nextRequestID++);
    }
    return self;
}

- (instancetype)initWithDelegate:(id<MRNetWorkDelegate>) delegate
{
    self = [super init];
    if (self) {
        _requestID = @(nextRequestID++);
        _delegate = delegate;
    }
    return self;
}

- (void)mr_requestRespondBlock:(void (^)(id<MRRespondProtocol> respond))block
{
    self.repondBlock = block;
}

+ (NSDictionary<NSString *,NSString *> *)parsePropertyKeyMapDic
{
    return @{};
}

@end


@implementation MRUploadRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithDelegate:(id<MRNetWorkDelegate>) delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        
    }
    return self;
}

@end


@implementation MRDownloadRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithDelegate:(id<MRNetWorkDelegate>) delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        
    }
    return self;
}

- (void)mr_requestDownloadCompletionBlock:(void (^)(NSData *fileData,NSError *error))block
{
    self.downloadBlock = block;
}

- (void)mr_requestDownloadProgressBlock:(void (^)(NSProgress *progress,NSError *error))block
{
    self.downloadProgressBlock = block;
}

@end

@implementation MRRequest(MRRequest)

- (NSDictionary *)propertyDicFromClass:(Class )cls
{
    NSDictionary *keyMapDic = [cls parsePropertyKeyMapDic];
    
    NSMutableDictionary *propertyDic = [[NSMutableDictionary alloc] init];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = properties[i];
        //取属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:propertyName];
        if (keyMapDic[propertyName])
        {
            propertyDic[keyMapDic[propertyName]] = value;
        }
        else
        {
            propertyDic[propertyName] = value;
        }
    }
    
    free(properties);
    
    Class superClass = class_getSuperclass([cls class]);
    if (superClass && superClass != [MRRequest class])
    {
        NSDictionary *superDic = [self propertyDicFromClass:[cls superclass]];
        [propertyDic addEntriesFromDictionary:superDic];
    }
    
    return [NSDictionary dictionaryWithDictionary:propertyDic];
}


@end