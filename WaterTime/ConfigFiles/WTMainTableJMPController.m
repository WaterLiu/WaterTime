//
//  WTMainTableJMPController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTMainTableJMPController.h"

//CoreData
#import "WTCoreDataViewController.h"

//SystemService
#import "WTSKStoreProductViewController.h"
#import "WTTakeScreenShotViewController.h"
#import "WTLocalAuthenticationViewController.h"
#import "WTTelephonyNetworkInfoViewController.h"

//UI
#import "WTBackgroundBlurViewController.h"
#import "WTTestViewController.h"
#import "WTFontViewController.h"
#import "WTCollectionViewController.h"
#import "WTImageFilterViewController.h"

//Network
#import "WTNetworkStateViewController.h"
#import "WTURLProtocolViewController.h"
#import "WTMRNetworkViewController.h"

//BaseService
#import "WTCrashReportViewController.h"

//CoreVideo
#import "WTCoreVideoViewController.h"

@implementation WTMainTableJMPController

+ (void)jumpViewControllerWithKey:(NSString*)key
                        withValue:(NSString*)value
         withNavigationController:(UINavigationController*)navigationController
{
    UIViewController* vc = nil;
    
    if ([key isEqual:@"CoreData"] == YES)
    {
        if ([value isEqualToString:@"Basic"])
        {
            vc = [[WTCoreDataViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@" "])
        {
            
        }
        else
        {
            
        }
    }
    else if ([key isEqual:@"SystemService"] == YES)
    {
        if ([value isEqualToString:@"AppStore"])
        {
            vc = [[WTSKStoreProductViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"TakeScreenShot"])
        {
            vc = [[WTTakeScreenShotViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"LocalAuthentication"])
        {
            vc = [[WTLocalAuthenticationViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"TelephonyNetworkInfo"])
        {
            vc = [[WTTelephonyNetworkInfoViewController alloc] initWithNibName:nil bundle:nil];
        }
        else
        {
            
        }
    }
    else if ([key isEqual:@"UI"] == YES)
    {
        if ([value isEqualToString:@"BackgroundBlur"])
        {
            vc = [[WTBackgroundBlurViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"Test"])
        {
            vc = [[WTTestViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"Font"])
        {
            vc = [[WTFontViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"CollectionView"])
        {
            vc = [[WTCollectionViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"ImageFilter"])
        {
            vc = [[WTImageFilterViewController alloc] initWithNibName:nil bundle:nil];
        }
        else
        {
            
        }
    }
    else if ([key isEqual:@"Network"] == YES)
    {
        if ([value isEqualToString:@"NetState"])
        {
            vc = [[WTNetworkStateViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"NSURLProtocol"])
        {
            vc = [[WTURLProtocolViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@"MRNetwork_@adi"])
        {
            vc = [[WTMRNetworkViewController alloc] initWithNibName:nil bundle:nil];
        }
        else
        {
            
        }
    }
    else if ([key isEqual:@"BaseService"] == YES)
    {
        if ([value isEqualToString:@"CrashReport"])
        {
            vc = [[WTCrashReportViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@" "])
        {
            
        }
        else
        {
            
        }
    }
    else if ([key isEqual:@"CoreVideo"] == YES)
    {
        if ([value isEqualToString:@"CoreVideo(GIF to Video)"])
        {
            vc = [[WTCoreVideoViewController alloc] initWithNibName:nil bundle:nil];
        }
        else if ([value isEqualToString:@" "])
        {
            
        }
        else
        {
            
        }
    }
    else
    {
        
    }
    
    if (vc == nil || navigationController == nil)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"跳转错误" message:@"Key没有对应跳转VC" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
    else
    {
        [navigationController pushViewController:vc animated:YES];
    }
}


@end
