//
//  WTTestViewController.h
//  WaterTime
//
//  Created by WaterLiu on 15/7/2.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"

@interface WTTestViewController : WTCommonBaseViewController <UIWebViewDelegate, UIGestureRecognizerDelegate>
{
    NSHashTable* hashTabe;
}

@end
