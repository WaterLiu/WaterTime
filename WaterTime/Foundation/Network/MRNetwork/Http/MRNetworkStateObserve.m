//
//  MRNetworkStateObserve.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRNetworkStateObserve.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

static const void * MRNetworkRetainCallback(const void *info)
{
    return Block_copy(info);
}

static void MRNetworkReleaseCallback(const void *info)
{
    if (info)
    {
        Block_release(info);
    }
}

typedef void(^MRNetStatusChangeBlock)(MRNetworkStatus status);

static MRNetworkStatus MRNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    MRNetworkStatus status = MRNetworkStatusUnknow;
    if (isNetworkReachable == NO)
    {
        status = MRNetworkStatusDisconnect;
    }
#if	TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0)
    {
        status = MRNetworkStatusCellular;
    }
#endif
    else
    {
        status = MRNetworkStatusWIFI;
    }
    
    return status;
}

NSString * const MRNetStatusDidChangeNotification = @"com.mogu.mrnetwork.status.change";
NSString * const MRNetStatusNotificationItem = @"com.mogu.mrnetwork.status.item";

static void MRNetworkStatusChange(SCNetworkReachabilityFlags flags, MRNetStatusChangeBlock block) {

    MRNetworkStatus status = MRNetworkReachabilityStatusForFlags(flags);
    //确保在主线程发送notificaion
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ MRNetStatusNotificationItem : @(status) };
        [notificationCenter postNotificationName:MRNetStatusDidChangeNotification object:nil userInfo:userInfo];
    });
    
}
static void MRNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    MRNetworkStatusChange(flags, (__bridge MRNetStatusChangeBlock)info);
}

@interface MRNetworkStateObserve()
{
    id                  _networkReachability;

}
@property (nonatomic,copy) MRNetStatusChangeBlock callbackBlock;

@end

@implementation MRNetworkStateObserve

+ (instancetype)sharedInstance
{
    static MRNetworkStateObserve *_instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _status = MRNetworkStatusUnknow;
        
        //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;

        // Recover reachability flags
        SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr *)&zeroAddress);
        
        _networkReachability = CFBridgingRelease(defaultRouteReachability);
    }
    return self;
}


- (void)startMonitoring
{
    [self stopMonitoring];
    
    if (!_networkReachability)
    {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    MRNetStatusChangeBlock callback = ^(MRNetworkStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        _status = status;
        if (strongSelf.callbackBlock)
        {
            strongSelf.callbackBlock(status);
        }
        
    };
    
    //监听网络变化
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, MRNetworkRetainCallback, MRNetworkReleaseCallback, NULL};
    
    SCNetworkReachabilitySetCallback((__bridge SCNetworkReachabilityRef)_networkReachability, MRNetworkReachabilityCallback, &context);
    
    SCNetworkReachabilityScheduleWithRunLoop((__bridge SCNetworkReachabilityRef)_networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags((__bridge SCNetworkReachabilityRef)_networkReachability, &flags)) {
            MRNetworkStatusChange(flags,callback);
        }
    });
}

- (void)stopMonitoring
{
    if (!_networkReachability)
    {
        return;
    }
    
    SCNetworkReachabilityUnscheduleFromRunLoop((__bridge SCNetworkReachabilityRef)_networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

- (void)networkStatusChange:(void (^)(MRNetworkStatus status))block
{
    self.callbackBlock = block;
}

- (void)dealloc
{
    [self stopMonitoring];
}

@end
