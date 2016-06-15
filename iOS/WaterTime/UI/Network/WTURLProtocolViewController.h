//
//  WTURLProtocolViewController.h
//  WaterTime
//
//  Created by WaterLiu on 8/11/15.
//  Copyright (c) 2015 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"

@interface WTURLProtocol : NSURLProtocol

@end

@interface WTURLProtocolViewController : WTCommonBaseViewController
{
    NSString*           _responseStr;
}

@end
