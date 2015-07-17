//
//  WTTakeScreenShotViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/7/17.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTTakeScreenShotViewController.h"

@interface WTTakeScreenShotViewController ()
{
    NSInteger           _takeTimeCount;
}

@end

@implementation WTTakeScreenShotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        
        //        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        //        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification
        //                                                          object:nil
        //                                                           queue:mainQueue
        //                                                      usingBlock:^(NSNotification *note) {
        //                                                          // executes after screenshot
        //
        //                                                          NSLog(@"截屏事件发生");
        //
        //                                                      }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(takeScreenShowNotification:)
                                                     name:UIApplicationUserDidTakeScreenshotNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setDescriptionText:@"iOS7 and later \nNotificationCenter Key: UIApplicationUserDidTakeScreenshotNotification"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)takeScreenShowNotification:(NSNotification*)notification
{
    [self setDescriptionText:[NSString stringWithFormat:@"TakeScreenShow %ld time",(long)++_takeTimeCount]];
}




@end
