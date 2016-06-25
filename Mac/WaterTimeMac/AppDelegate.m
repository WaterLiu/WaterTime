//
//  AppDelegate.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "AppDelegate.h"
#import "WTViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _vc = [[WTViewController alloc] initWithNibName:nil bundle:nil];
    [self.window.contentView addSubview:_vc.view];
    
//    vc.view.frame = self.window.contentView.bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
