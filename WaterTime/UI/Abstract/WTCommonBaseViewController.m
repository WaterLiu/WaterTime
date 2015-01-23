//
//  WTCommonBaseViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"

@interface WTCommonBaseViewController ()

@end

@implementation WTCommonBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _scrollView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark － Private


#pragma mark - Public

- (void)setupScrollView:(BOOL)setup
{
    if (setup == YES)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor redColor];
        [self.containerView addSubview:_scrollView];
    }
    else
    {
        if (_scrollView != nil)
        {
            [_scrollView removeFromSuperview];
            _scrollView.delegate = nil;
            _scrollView = nil;
        }
    }
}

@end
