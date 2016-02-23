//
//  MRNetworkManager.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRNetworkManager.h"
#import "MROperationQueue.h"
#import "MRNetWorkDelegateManager.h"
#import "MRNetworkStateObserve.h"
#import "MRNetworkConfig.h"

@interface MRNetworkManager()

@end

@implementation MRNetworkManager

+ (instancetype) sharedManager
{
    static MRNetworkManager* _instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _requestQueue = [[MROperationQueue alloc] init];
        _requestQueue.maxConcurrentOperationCount = 6;
        _delegateManagerDic = [[NSMutableDictionary alloc] init];
        _operationDic = [[NSMutableDictionary alloc] init];
        
        _observeInstance = [MRNetworkStateObserve sharedInstance];
        [_observeInstance startMonitoring];
        
        _config = [[MRNetworkConfig alloc] init];
    }
    return self;
}

- (MRRequestHandler *)requestAsync:(MRRequest *)request
{
#if USE_AFNETWORKING
    return [[MRAFRequestManager sharedManager] request:request delegate:request.delegate];
#else
    
    MRRequestManager *requestMananger = [[MRRequestManager alloc] init];
    requestMananger.delegate = self;
    MRRequestHandler *handler = [requestMananger request:request];
    MRNetWorkDelegateManager * delegateManager = [[MRNetWorkDelegateManager alloc] init];
    delegateManager.manager = request.delegate;
    delegateManager.request = request;
    _operationDic[request.requestID] = handler;
    _delegateManagerDic[request.requestID] = delegateManager;
    [handler addTaskObserver:delegateManager];
    [_requestQueue addOperation:handler];
    return handler;
#endif

}

- (void)removeTaskByRequestID:(NSNumber *)requestID
{
    MRRequestHandler *handler = self.operationDic[requestID];
    MRNetWorkDelegateManager *delegate = self.delegateManagerDic[requestID];
    if (delegate)
    {
        [handler removeTaskObserver:delegate];
    }
    [handler markAsFinished];
    [self.operationDic removeObjectForKey:requestID];
    [self.delegateManagerDic removeObjectForKey:requestID];
}

- (MRNetworkStatus)getStatus
{
    return _observeInstance.status;
}

- (BOOL)isReachable
{
    return (_observeInstance.status == MRNetworkStatusCellular) || (_observeInstance.status == MRNetworkStatusWIFI);
}

- (BOOL)isReachableViaCellular
{
    return _observeInstance.status == MRNetworkStatusCellular;
}

- (BOOL)isReachableViaWIFI
{
    return _observeInstance.status == MRNetworkStatusWIFI;
}

#pragma mark -  MRRequestManager Deleagte Method
#pragma mark    OverRide If Need

- (void)mr_willParseRequest:(MRRequest *)request
{
    NSLog(@"will pares request: %@",request);
}

- (NSMutableURLRequest *)mr_ParseRequest:(MRRequest *)request
{
    return [MRRequestAdapter parseRequest:request];
}

- (MRRespond *)mr_ParseRespond:(NSURLResponse *)response
                responseObject:(id)responseObject
                       request:(MRRequest *)request
                         error:(NSError *)error
{
    MRRespond *respond = [MRRespondAdapter parseRespond:response
                                         responseObject:responseObject
                                                request:request
                                                  error:error];
    return respond;
}

- (void)mr_willRespond:(MRRespond *)respond
{
    NSLog(@"will respond: %@",respond);
    if ([respond.request.delegate respondsToSelector:@selector(mr_requestSubThreadRespond:)])
    {
        [respond.request.delegate mr_requestSubThreadRespond:respond];
    }
}


- (void)mr_completionSessionRespond:(MRRespond *)respond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([respond.request.delegate respondsToSelector:@selector(mr_requestMainThreadRespond:)])
        {
            [respond.request.delegate mr_requestMainThreadRespond:respond];
        }else if (respond.request.repondBlock)
        {
            respond.request.repondBlock(respond);
            respond.request.repondBlock = nil;
        }
        [self removeTaskByRequestID:respond.request.requestID];
    });
}


@end
