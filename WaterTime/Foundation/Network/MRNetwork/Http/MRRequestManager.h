//
//  MRRequestManager.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRequest.h"
#import "MRRequestHandler.h"
#import "MRRequestConfig.h"

@class MRRequestManager;

@protocol MRRequestManagerDeleagte <NSObject>

@optional
/**
 *  将要解析网络请求的回调，可以修改request
 *
 *  @param request 网络请求
 */
- (void)mr_willParseRequest:(MRRequest *)request;
/**
 *  解析网络请求的方式，默认不需要实现
 *  默认解析方式不符合要求时，请自行实现
 *
 *  @param request 网络请求
 *
 *  @return NSMutableURLRequest
 */
- (NSMutableURLRequest *)mr_ParseRequest:(MRRequest *)request;
/**
 *  解析Respond的方式，默认不需要实现
 *  默认解析方式不符合要求时，请自行实现
 *
 *  @param response       NSURLResponse
 *  @param responseObject Respond数据
 *  @param request        网络请求
 *  @param error          错误信息
 *
 *  @return MRRespond
 */
- (MRRespond *)mr_ParseRespond:(NSURLResponse *)response
                responseObject:(id)responseObject
                       request:(MRRequest *)request
                         error:(NSError *)error;
/**
 *  将要回调，此时在子线程
 *
 *  @param respond MRRespond
 */
- (void)mr_willRespond:(MRRespond *)respond;

/**
 *  切回主线程回调
 *
 *  @param manager <#manager description#>
 *  @param respond <#respond description#>
 */
- (void)mr_completionSessionRespond:(MRRespond *)respond;

@end


@interface MRRequestManager : NSObject

@property (nonatomic,weak) id<MRRequestManagerDeleagte> delegate;

- (MRRequestHandler *)request:(MRRequest *)request;


@end
