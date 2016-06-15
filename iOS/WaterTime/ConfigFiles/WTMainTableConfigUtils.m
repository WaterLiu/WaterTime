//
//  WTMainTableConfigUtils.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTMainTableConfigUtils.h"

@implementation WTMainTableConfigUtils

+ (instancetype)currentConfig
{
    static WTMainTableConfigUtils* currentConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentConfig = [[WTMainTableConfigUtils alloc] init];
    });
    
    return currentConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString* configPath = [[NSBundle mainBundle] pathForResource:@"MainTableShowContentList" ofType:@"plist"];
        _configDic = [NSDictionary dictionaryWithContentsOfFile:configPath];
    }
    
    return self;
}


- (void)dealloc
{
    _configDic = nil;
}

#pragma mark - Private



#pragma mark - Public

- (NSArray*)keys
{
    if (_configDic != nil)
    {
        return [_configDic allKeys];
    }
    
    return nil;
}

- (NSArray*)valuesForKey:(NSString*)key
{
    if (_configDic != nil && key != nil)
    {
        
        return [_configDic objectForKey:key];
    }
    
    return nil;
}

@end
