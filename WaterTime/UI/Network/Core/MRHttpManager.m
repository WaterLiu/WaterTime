//
//  MRHttpManager.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/1/30.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRHttpManager.h"
#import "MRNetworkConfig.h"
#import "MRSimpleRequest.h"
#import "MRSimpleRespond.h"
#import "MRDicParse.h"



@interface MRHttpManager()

@end

@implementation MRHttpManager

+ (instancetype)sharedManager
{
    static MRHttpManager *_instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [_observeInstance networkStatusChange:^(MRNetworkStatus status) {
            NSLog(@"网络状态变化 status = %ld ",(long)status);
        }];
    }
    return self;
}

- (MRRespond *)mr_ParseRespond:(NSURLResponse *)response
                responseObject:(id)responseObject
                       request:(MRRequest *)request
                         error:(NSError *)error
{
    
    
    NSString* requestClassName = NSStringFromClass([request class]);
    
    NSString* respondClassName = [requestClassName stringByReplacingOccurrencesOfString:@"Request" withString:@"Respond"];
    
    NSDictionary *content;
    if (responseObject)
    {
        content = [MRDicParse parseJsonData:responseObject error:nil];
        if (!content)
        {
            NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *htmlStr = [[NSString alloc] initWithData:responseObject encoding:gbEncoding];
            NSLog(@"返回数据不是Json格式，是html格式，内容如下：%@",htmlStr);
        }
    }else
    {
        content = nil;
    }
    
    
    if ([respondClassName isEqualToString:NSStringFromClass([MRSimpleRespond class])])
    {
        MRSimpleRespond *simpleRespond = [[MRSimpleRespond alloc] init];
        simpleRespond.dataDic = content;
        simpleRespond.request = request;
        return simpleRespond;
    }
    
    return [[MRSimpleRespond alloc] init];
}



- (MRRequestHandler *)simpleRequestAsync:(NSString *)urlString completion:(void (^)(NSDictionary *reponseDic))block
{
    MRSimpleRequest *request = [[MRSimpleRequest alloc] init];
    request.url = urlString;
    request.method = MRRequestMethod_GET;
    [request mr_requestRespondBlock:^(MRSimpleRespond *respond) {
        block(respond.dataDic);
    }];
    
    return [super requestAsync:request];
}


@end
