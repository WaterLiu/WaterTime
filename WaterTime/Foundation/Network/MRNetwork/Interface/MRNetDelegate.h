//
//  MRNetDelegate.h
//  Mogu4iPhone
//  MRNetWork代理
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRNetworkStateObserve.h"
#import "MRRespond.h"

@class MRRequest;

@protocol MRNetWorkDelegate <NSObject>

@optional
/**
 *  网络请求回调，主线程
 *
 *  @param respond MRRespond
 */
- (void)mr_requestMainThreadRespond:(id<MRRespondProtocol> )respond;

/**
 *  网络请求回调，子线程
 *
 *  @param respond <#respond description#>
 */
- (void)mr_requestSubThreadRespond:(id<MRRespondProtocol> )respond;

/**
 *  文件上传进度
 *
 *  @param progress <#progress description#>
 *  @param request  <#request description#>
 */
- (void)mr_requestFileUploadProgress:(NSProgress *)progress withReuqest:(MRRequest *)request;

/**
 *  文件下载进度
 *
 *  @param progress <#progress description#>
 *  @param request  <#request description#>
 */
- (void)mr_requestFileDownloadProgress:(NSProgress *)progress withReuqest:(MRRequest *)request;

@end
