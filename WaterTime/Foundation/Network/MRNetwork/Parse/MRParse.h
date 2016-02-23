//
//  MRParse.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+MRParse.h"

@protocol MRParseProtocol <NSObject>

@optional
/**
 *  解析时属性映射关系 key:key value:property name
 *
 *  @return dic
 */
+ (NSDictionary<NSString *,NSString *> *)parsePropertyKeyMapDic;

@end

/**
 *  MRParse 解析的基类
 */
@interface MRParse : NSObject

/**
 *  从NSArray和NSDictionary中移除掉NSNull
 *
 *  @param object
 *
 *  @return object
 */
+ (id)removeNullValue:(id)object;

@end
