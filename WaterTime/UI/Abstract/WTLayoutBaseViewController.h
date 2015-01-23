//
//  WTLayoutBaseViewController.h
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTLayoutBaseViewController : UIViewController
{
    UIView*         _containerView;
}

@property (nonatomic, readonly)UIView* containerView;

@end
