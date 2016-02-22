//
//  MRArrayParse.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/1.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRParse.h"

@protocol MRArrayParseProtocol <MRParseProtocol>


@end

@interface MRArrayParse : MRParse

/**
 *  将数组里面的对象解析为对应class的实例
 *
 *  @param array     原始数组
 *  @param className class
 *  @param error     error
 *
 *  @return 
 */
+ (NSArray *)parseArray:(NSArray *)array className:(NSString *)className error:(NSError **)error;

@end
