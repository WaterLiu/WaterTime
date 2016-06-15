//
//  WTMainTableJMPController.h
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTMainTableJMPController : NSObject

+ (void)jumpViewControllerWithKey:(NSString*)key
                        withValue:(NSString*)value
         withNavigationController:(UINavigationController*)navigationController;

@end
