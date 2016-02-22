//
//  MRRequestAdapter.h
//  Mogu4iPhone
//  将MRRequest转化为基本的MSMutableURLRequest中间件
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRRequest;

//负责 MRRequestModel 转 MRRequest
@interface MRRequestAdapter : NSObject

/**
 *  用MRrequest生成NSMutableURLRequest的方法
 *
 *  @param request 需要转化的MRRequest
 *
 *  @return 生成的基本NSMutableURLRequest
 */
+ (NSMutableURLRequest *)parseRequest:(MRRequest *)request;

@end
