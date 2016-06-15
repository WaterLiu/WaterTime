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
    
    WTViewController* vc = [[WTViewController alloc] initWithNibName:nil bundle:nil];
    
    id view = vc.view;
    
    
    [self.window.contentView addSubview:vc.view];
    
    [self.window.contentView setWantsLayer:YES];
    
    if (self.window.contentView.layer)
    {
        NSLog(@"YES");
    }
    else
    {
        NSLog(@"NO");
    }
    
    self.window.contentView.layer.backgroundColor = [NSColor yellowColor].CGColor;
    
//    vc.view.frame = self.window.contentView.bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
