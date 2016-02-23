//
//  MRJSONModel.h
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/13.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRJSONModel : NSObject

/**
 *  通过Dictionary方式初始化Model
 *
 *  @param dic 要创建的Dictionary
 *  @param error 转换会出现的错误
 */
-(instancetype)initWithDictionary:(NSDictionary *)jsonDic error:(NSError **)error;

/**
 *  通过JSON字符串的方式创建Model
 *
 *  @param jsonString 要创建的字符串
 *  @param error 转换会出现的错误
 */
-(instancetype)initWithJSONString:(NSString *)jsonString error:(NSError **)error;

@end
