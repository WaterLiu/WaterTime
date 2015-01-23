//
//  WTMainTableConfigUtils.h
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTMainTableConfigUtils : NSObject
{
    NSDictionary*           _configDic;
}

+ (instancetype)currentConfig;

- (NSArray*)keys;
- (NSArray*)valuesForKey:(NSString*)key;

@end
