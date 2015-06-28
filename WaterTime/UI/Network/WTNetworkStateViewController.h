//
//  WTNetworkStateViewController.h
//  WaterTime
//
//  Created by WaterLiu on 6/29/15.
//  Copyright (c) 2015 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"
#import "Reachability.h"

@interface WTNetworkStateViewController : WTCommonBaseViewController
{
    Reachability*           _reachability;
}

@end
