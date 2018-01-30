//
//  AppDelegate.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "AppDelegate.h"

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
    _wc = [[WTWindowController alloc] initWithWindowNibName:@"WTWindowController"];
    [_wc showWindow:nil];

    
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
