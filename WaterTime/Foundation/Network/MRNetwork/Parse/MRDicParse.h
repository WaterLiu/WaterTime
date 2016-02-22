//
//  MRDicParse.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRParse.h"

@protocol MRDicParseProtocol <MRParseProtocol>

@optional
/**
 *  解析递归类的终止条件，解析到哪层class为止
 *
 *  @return base class name
 */
+ (NSString *)parseBaseClassName;

@end

@interface MRDicParse : MRParse

/**
 *  Json数据解析为Dic
 *
 *  @param data  json数据
 *  @param error 错误信息
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)parseJsonData:(NSData *)data error:(NSError **)error;

/**
 *  递归解析instance直到class
 *
 *  @param instance <#instance description#>
 *  @param class    <#class description#>
 *  @param error    <#error description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)parseInstance:(id<MRDicParseProtocol>)instance class:(Class)cls error:(NSError **)error;

@end
