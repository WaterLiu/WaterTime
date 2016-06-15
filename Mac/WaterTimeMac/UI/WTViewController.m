//
//  WTViewController.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTViewController.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (nullable instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {

    }
    return self;
}


- (void)loadView
{
    self.view = [[NSView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 500, 500)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do view setup here.
    
    
    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [NSColor redColor].CGColor;

}

@end
