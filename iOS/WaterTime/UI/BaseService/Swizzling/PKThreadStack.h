//
//  PKThreadStack.h
//  ProtectKitDemo
//
//  Created by dickyduan on 16/3/10.
//  Copyright © 2016年 dickyduan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CurrentStack [PKThreadStack getCurrentStack]

@interface PKThreadStack : NSObject

+ (NSArray *)getCurrentStack;

@end
