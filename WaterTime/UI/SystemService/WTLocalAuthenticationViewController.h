//
//  WTLocalAuthenticationViewController.h
//  WaterTime
//
//  Created by WaterLiu on 15/8/3.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"
#import <LocalAuthentication/LAContext.h>

@interface WTLocalAuthenticationViewController : WTCommonBaseViewController
{
    LAContext*              _context;
}

@end
