//
//  WTMainTableJMPController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTMainTableJMPController.h"
#import "WTCoreDataViewController.h"

@implementation WTMainTableJMPController

+ (void)jumpViewControllerWithKey:(NSString*)key withNavigationController:(UINavigationController*)navigationController
{
    UIViewController* vc = nil;
    
    if ([key isEqual:@"CoreData"] == YES)
    {
        vc = [[WTCoreDataViewController alloc] initWithNibName:nil bundle:nil];
    }
    else if ([key isEqual:@"Animation"] == YES)
    {
        
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
