//
//  PKThreadStack.m
//  ProtectKitDemo
//
//  Created by dickyduan on 16/3/10.
//  Copyright © 2016年 dickyduan. All rights reserved.
//

#import "PKThreadStack.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@implementation PKThreadStack

+ (NSArray *)getCurrentStack
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0;i < frames;i++){
        
        
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

@end
