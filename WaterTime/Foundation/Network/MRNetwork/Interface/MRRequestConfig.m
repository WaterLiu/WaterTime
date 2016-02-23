//
//  MRRequestConfig.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRequestConfig.h"

@interface MRRequestConfig()


@end

@implementation MRRequestConfig

+ (instancetype)defaultConfig
{
    MRRequestConfig *config = [[MRRequestConfig alloc] init];
    config.isNeedZip = YES;
    config.isNeedUnZip = YES;
    config.isCache = YES;
    config.timeout = 60;
    config.priority = MRRequestPriority_Default;
    config.cacheType = MRRequestCacheType_Default;
    config.paramsEncodingType = MRParamsEncoding_URL;
    return config;
}


@end
