//
//  NSObject+Swizzling.m
//  BadAccess
//
//  Created by dickyduan on 16/7/11.
//  Copyright © 2016年 dickyduan. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "PKThreadStack.h"
#import "queue.h"

void *sCatchIsa = NULL;
NSInteger sCatchSize = 0;

//用来保存自己偷偷保留的内存,这个队列要线程安全
static struct DSQueue* unfreeQueue=NULL;

//用来记录我们偷偷保存的内存的大小，用无锁函数操作
static int unfreeSize=0;

//最多保留这么多个指针，再多就释放一部分
const long MAX_STEAL_MEM_NUM = 1024*1;

static NSMutableDictionary *dict  = nil;

@interface Catcher : NSObject
@property (readwrite,assign,nonatomic) Class origClass;
@end

@implementation Catcher
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"野指针:%s::%p=>%@\n", class_getName(self.origClass), self, NSStringFromSelector(aSelector));
    NSString *key = [NSString stringWithFormat:@"%p", self];
    NSLog(@"obj:key allStacks = \n%@", [dict objectForKey:key]);
    abort();
    return nil;
}
-(void)dealloc{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"dealloc", CurrentStack);
    abort();
    [super dealloc];
}

-(instancetype)retain
{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"retain", CurrentStack);
    abort();
    return nil;
}

- (id)copy
{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"copy", CurrentStack);
    abort();
    return nil;
}

- (id)mutableCopy
{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"mutableCopy", CurrentStack);
    abort();
    return nil;
}

-(oneway void)release{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"release", CurrentStack);
    abort();
}
- (instancetype)autorelease{
    NSLog(@"野指针:%s::%p=>%@\n%@", class_getName(self.origClass), self, @"autorelease", CurrentStack);
    abort();
}
@end

@implementation NSObject(Swizzling)

+ (void)methodSwizzling
{
    sCatchIsa = objc_getClass("Catcher");
    sCatchSize = class_getInstanceSize(sCatchIsa);
    
    unfreeSize=0;
    unfreeQueue=ds_queue_create(MAX_STEAL_MEM_NUM);
    dict = [[NSMutableDictionary dictionaryWithCapacity:10] retain];
    
    Method oriMethod = class_getInstanceMethod(NSClassFromString(@"GroupProfileViewController"), @selector(dealloc));
    Method newMethod = class_getInstanceMethod([self class], @selector(myDealloc));
    method_exchangeImplementations(oriMethod, newMethod);
    
    oriMethod = class_getInstanceMethod(NSClassFromString(@"GroupProfileViewController"), @selector(release));
    newMethod = class_getInstanceMethod([self class], @selector(myRelease));
    method_exchangeImplementations(oriMethod, newMethod);
}

+ (void)deallocAllObjs
{
    size_t count=ds_queue_length(unfreeQueue);
    for (int i=0; i<count; i++) {
        void* unfreePoint=ds_queue_get(unfreeQueue);
        size_t memSiziee=malloc_size(unfreePoint);
        __sync_fetch_and_sub(&unfreeSize,(int)memSiziee);
        free(unfreePoint);
    }
    
    NSArray *allKeys = [dict allKeys];
    for (id key in allKeys) {
        NSLog(@"obj:key allStacks = \n%@", [dict objectForKey:key]);
        [dict removeObjectForKey:key];
    }
}

-(oneway void)myRelease {
    if ([self isKindOfClass:NSClassFromString(@"GroupProfileViewController")]) {
        if ([dict allKeys].count < 1000) {
            NSString *key = [NSString stringWithFormat:@"%p", self];
            NSMutableArray *allStacks = [dict objectForKey:key];
            if (!allStacks) {
                allStacks = [NSMutableArray arrayWithCapacity:3];
                [dict setObject:allStacks forKey:key];
            }
            [allStacks addObject:CurrentStack];
        }
    }
    
    [self myRelease];
}

- (void)myDealloc
{
    if ([self isKindOfClass:NSClassFromString(@"GroupProfileViewController")]) {
        void *p = (void *)self;
        size_t memSize = malloc_size(p);
        if (memSize >= sCatchSize) {//有足够的空间才覆盖
            id obj=(id)p;
    
            NSString *key = [NSString stringWithFormat:@"%p", self];
            NSLog(@"obj:key allStacks = \n%@", [dict objectForKey:key]);
            
            objc_destructInstance(self);
            
            Class origClass = object_getClass(obj);
            
            memset(obj, 0x55, memSize);
            
            memcpy(obj, &sCatchIsa, sizeof(void*));//把我们自己的类的isa复制过去
            
            Catcher* bug=(Catcher*)p;
            bug.origClass = origClass;
            
            size_t count=ds_queue_length(unfreeQueue);
            if (count < 1000) {
                __sync_fetch_and_add(&unfreeSize,(int)memSize);
                ds_queue_put(unfreeQueue, p);
            }
        } else {
            [self myDealloc];
        }
    } else {
        [self myDealloc];
    }
}

@end
