//
//  NSObject+MRParse.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/2.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "NSObject+MRParse.h"

@implementation NSObject (MRParse)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"UndefineKey: class: %@ value: %@ key:%@",[self class],value,key);
}

@end
