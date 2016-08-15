//
//  AppDelegate.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "WTViewController.h"



#define B

#ifdef B

#define A(a,b) a##b;

#endif

void show ()
{
    
}

@interface AppDelegate ()
{
    __strong NSArray*   _array;
}

@property (nonatomic, strong)NSArray* array;

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _vc = [[WTViewController alloc] initWithNibName:nil bundle:nil];
    [self.window.contentView addSubview:_vc.view];
    
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:10];
    
    NSInteger count = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
    NSLog(@"count = %ld",count);

    _array = arr;
    
    NSInteger count1 = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
    NSLog(@"count1 = %ld",count1);
    
    [pool release];
    
//    self.array = arr;
//    
//    NSInteger count2 = CFGetRetainCount((__bridge CFMutableArrayRef)(self.array));
//    NSLog(@"count2 = %ld",count2);
    
    [arr addObject:@"water"];
//
//    NSInteger count = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
//    NSLog(@"count = %ld",count);
//
//    
//    NSMutableArray __strong ** aarr = &arr;
//    
//    NSInteger count1 = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
//    NSLog(@"count = %ld",count);
//    
//    arr = nil;
//    
//    NSInteger count2 = CFGetRetainCount((__bridge CFMutableArrayRef)(*aarr));
//    NSLog(@"count = %ld",count);
//    
//    int a = [*aarr count];
//    [*aarr objectAtIndex:0];
    
    //    NSString* str = [[NSString alloc] initWithCString:"water" encoding:NSUTF8StringEncoding];
//    NSString** sstr = &str;

//    NSArray* arr = [NSArray array];
//    __unsafe_unretained NSArray* a = arr;
//    NSArray __strong ** aarr = &arr;
    
//    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:10];
//
//    __block NSInteger count = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
//    NSLog(@"count = %ld",count);
//
//    NSArray* a = arr;
//
//    NSArray __strong ** aarr = &arr;
//    count = CFGetRetainCount((__bridge CFMutableArrayRef)(arr));
//    NSLog(@"count = %ld",count);
//    
//    __unsafe_unretained NSMutableArray* b = arr;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        count = CFGetRetainCount((__bridge CFMutableArrayRef)(b));
//        NSLog(@"count = %ld",count);
//    });
    
//    NSMutableArray* arrr = [NSMutableArray arrayWithCapacity:10];
//    [arrr addObject:@"ww"];
//    
//    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:10];
//    
//    [dic setObject:aarr forKey:@"water"];
    
//    CFLocaleRef locale = CFLocaleCopyCurrent();
//    CFStringRef str = CFStringCreateWithCString(kCFAllocatorDefault, "WATER", kCFStringEncodingUTF8);
//    CFMutableStringRef muStr = CFStringCreateMutableCopy(kCFAllocatorDefault, CFStringGetLength(str), str);
//    CFRelease(str);
//    CFLocaleRef locale = CFLocaleCopyCurrent();
//    CFMakeCollectable(locale); // Autorelease here so that it gets released no matter what

//    NSString* string = [NSString stringWithFormat:@"water"];
//    
//    CFStringCapitalize(muStr, locale);
//    CFRelease(muStr);
//    vc.view.frame = self.window.contentView.bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
