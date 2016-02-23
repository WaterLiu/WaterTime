//
//  MRNetworkStateObserve.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger,MRNetworkStatus)
{
    /**
     *  网络状态未知
     */
    MRNetworkStatusUnknow,
    /**
     *  WIFI连接
     */
    MRNetworkStatusWIFI,
    /**
     *  蜂窝网数据连接
     */
    MRNetworkStatusCellular,
    /**
     *  无网络连接
     */
    MRNetworkStatusDisconnect,
};

@interface MRNetworkStateObserve : NSObject

@property (nonatomic,assign,readonly)     MRNetworkStatus     status;

+ (instancetype)sharedInstance;

- (void)startMonitoring;
- (void)networkStatusChange:(void (^)(MRNetworkStatus status))block;


@end
