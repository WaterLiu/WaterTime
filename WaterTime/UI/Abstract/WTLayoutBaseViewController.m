//
//  WTLayoutBaseViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTLayoutBaseViewController.h"

@interface WTLayoutBaseViewController ()

@end

@implementation WTLayoutBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    _containerView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_containerView];
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0f)
    {
        if (self.navigationController != nil)
        {
            CGFloat height = self.navigationController.navigationBar.frame.size.height;
            _containerView.frame = CGRectMake(0.0f, height, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - height);
        }
        else
        {
            _containerView.frame = CGRectMake(0.0f, 20.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 20.0f);
        }
    }
    else
    {
        // do noting.
        _containerView.frame = self.view.bounds;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private


@end
