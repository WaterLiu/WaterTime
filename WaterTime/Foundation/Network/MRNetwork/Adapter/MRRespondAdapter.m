//
//  MRRespondAdapter.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRespondAdapter.h"
#import "MRRespond.h"
#import "NSDictionary+MRDictionary.h"

#import "MRDicParse.h"
#import "MREntityParse.h"

#import <objc/runtime.h>

@implementation MRRespondAdapter

+ (MRRespond *)parseRespond:(NSURLResponse *)response responseObject:(id)responseObject request:(MRRequest *)request error:(NSError *)error
{
    
    NSString* requestClassName = NSStringFromClass([request class]);
    
    NSString* respondClassName = [requestClassName stringByReplacingOccurrencesOfString:@"Request" withString:@"Respond"];
    
    NSDictionary *content;
    if (responseObject)
    {
        content = [MRDicParse parseJsonData:responseObject error:nil];
    }else
    {
        content = nil;
    }
    
    NSDictionary *resultDic = content[@"result"];
    
    MRRespond* respond;
    if (resultDic && [resultDic isKindOfClass:[NSDictionary class]])
    {
        respond = (MRRespond *)[MREntityParse parseDic:resultDic className:respondClassName error:nil];
    }else
    {
        respond = [[NSClassFromString(respondClassName) alloc] init];
    }
    
    respond.request = request;
    
    return respond;
}

@end
