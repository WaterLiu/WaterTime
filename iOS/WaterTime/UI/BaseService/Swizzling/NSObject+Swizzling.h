//
//  NSObject+Swizzling.h
//  BadAccess
//
//  Created by dickyduan on 16/7/11.
//  Copyright © 2016年 dickyduan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Swizzling)

+ (void)methodSwizzling;

+ (void)deallocAllObjs;

- (void)myDealloc;

@end
