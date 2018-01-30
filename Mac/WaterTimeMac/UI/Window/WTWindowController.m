//
//  WTWindowController.m
//  WaterTimeMac
//
//  Created by WaterLiu on 2018/1/30.
//  Copyright © 2018年 WaterLiu. All rights reserved.
//

#import "WTWindowController.h"

@interface WTWindowController ()

@end

@implementation WTWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.window.backgroundColor = [NSColor redColor];
    self.window.delegate = self;
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self close];
        [self.window performClose:nil];
    });
}


#pragma mark - NSWindowDelegate

- (BOOL)windowShouldClose:(NSWindow *)sender
{
    NSLog(@"windowShouldClose");
    return YES;
}

- (void)windowWillClose:(NSNotification *)notification
{
    NSLog(@"windowShouldClose");
}

@end
