//
//  MRNetworkManager.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRNetworkHeader.h"
#import "MRNetWorkDelegateManager.h"
#import "MRRequestManager.h"

@class MRNetworkConfig;
@class MROperationQueue;

@interface MRNetworkManager : NSObject<MRRequestManagerDeleagte>
{
    MRNetworkStateObserve       *_observeInstance;
    MRNetworkConfig             *_config;
}

+ (instancetype) sharedManager;

@property (nonatomic,assign,readonly,getter=getStatus)                  MRNetworkStatus     status;
@property (nonatomic,assign,readonly,getter=isReachable)                BOOL                reachable;
@property (nonatomic,assign,readonly,getter=isReachableViaCellular)     BOOL                reachableViaCellular;
@property (nonatomic,assign,readonly,getter=isReachableViaWIFI)         BOOL                reachableViaWIFI;

@property (nonatomic,strong)    MRNetworkConfig         *config;
@property (nonatomic,readonly)  MROperationQueue        *requestQueue;
@property (nonatomic,readonly)  NSMutableDictionary     *operationDic;
@property (nonatomic,readonly)  NSMutableDictionary     *delegateManagerDic;

/**
 *  请求方法
 *
 *  @param request MRRequest请求
 *
 *  @return 返回Handler
 */
- (MRRequestHandler *)requestAsync:(MRRequest *)request NS_REQUIRES_SUPER;


@end
