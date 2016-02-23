//
//  MREntityParse.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRParse.h"

@protocol MREntityParseProtocol <MRParseProtocol>

@optional
/**
 *  解析时类名映射关系 key:key value:class name
 *
 *  @return dic
 */
+ (NSDictionary<NSString *,NSString *> *)parseClassKeyMapDic;

@end

@interface MREntityParse : MRParse

/**
 *  解析Dic成为指定的class
 *
 *  @param dic       <#dic description#>
 *  @param className <#className description#>
 *  @param error     <#error description#>
 *
 *  @return <#return value description#>
 */
+ (id<MREntityParseProtocol>)parseDic:(NSDictionary *)dic className:(NSString *)className error:(NSError **)error;

@end
