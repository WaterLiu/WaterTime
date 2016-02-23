//
//  NSArray+MRArray.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/1/15.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MRArray)

- (id)parseToClass:(NSString *)className keyMapDic:(NSDictionary *)keyMapDic;

@end
