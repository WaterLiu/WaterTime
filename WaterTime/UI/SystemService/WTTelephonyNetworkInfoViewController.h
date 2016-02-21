//
//  WTTelephonyNetworkInfoViewController.h
//  WaterTime
//
//  Created by WaterLiu on 2/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface WTTelephonyNetworkInfoViewController : WTCommonBaseViewController
{
    CTTelephonyNetworkInfo*         _networkInfo;
}

@end
