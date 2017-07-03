//
//  WTCoreAnimationViewController.m
//  WaterTime
//
//  Created by WaterLiu on 2017/7/3.
//  Copyright © 2017年 WaterLiu. All rights reserved.
//

#import "WTCoreAnimationViewController.h"

@interface WTCoreAnimationViewController ()

@end

@implementation WTCoreAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabbarView = [[TabbarView alloc] init];
    _tabbarView.backgroundColor = [UIColor grayColor];
    _tabbarView.titils = @[@"TabOne", @"TabTwo", @"TabThree",@"TabFour", @"TabFive", @"TabTestTabTestTabTestTabTest"];
    _tabbarView.font = [UIFont systemFontOfSize: 15.0f];
    [self.view addSubview:_tabbarView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _tabbarView.frame = CGRectMake(0.0f, 80.0f, CGRectGetWidth(self.view.frame), 80.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
