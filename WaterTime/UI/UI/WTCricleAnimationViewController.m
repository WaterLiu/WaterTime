//
//  WTCricleAnimationViewController.m
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCricleAnimationViewController.h"

@interface WTCricleAnimationViewController ()

@end

@implementation WTCricleAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cricleView = [[WTCricleView alloc] initWithFrame:self.view.bounds];
    _cricleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_cricleView];
    
    
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private



@end
