//
//  MRAFRequestManager.h
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/12.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRequest.h"
#import "MRRequestHandler.h"
#import "MRRequestConfig.h"


@interface MRAFRequestManager : NSObject

/**
 *  单例
 *
 *  @return
 */
+ (instancetype)sharedManager;

/**
 *  网络请求方法
 *
 *  @param request  MRRequest请求实体
 *  @param delegate 回调方法
 *
 *  @return 请求Handler
 */
- (MRRequestHandler *)request:(MRRequest *)request delegate:(id<MRNetWorkDelegate>)delegate;

/**
 *  带配置参数的网络请求方法
 *
 *  @param request  MRRequest请求实体
 *  @param delegate 回调方法
 *  @param comfig   配置文件
 *
 *  @return 请求Handler
 */
- (MRRequestHandler *)request:(MRRequest *)request config:(MRRequestConfig* )config delegate:(id<MRNetWorkDelegate>)delegate;

@end
