//
//  WTNetworkStateViewController.m
//  WaterTime
//
//  Created by WaterLiu on 6/29/15.
//  Copyright (c) 2015 WaterLiu. All rights reserved.
//

#import "WTNetworkStateViewController.h"


@interface WTNetworkStateViewController ()

@end

@implementation WTNetworkStateViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    }
    return self;
}

- (void)dealloc
{
    [_reachability stopNotifier];
    _reachability.reachableBlock = nil;
    _reachability = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addShowTestButtons:@[@"CurrentNetSatate"]];
    [self setDescriptionText:@"Reachability.h"];
    
    __weak id tempSelf = self;
    
    _reachability.reachableBlock = ^(Reachability* reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reachability != nil)
            {
                [tempSelf setDescriptionText:[reachability currentReachabilityString]];
            }
        });
    };
    [_reachability startNotifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTestButtonsClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if ([button.titleLabel.text isEqualToString:@"CurrentNetSatate"])
    {
        [self setDescriptionText:[_reachability currentReachabilityString]];
    }
}

#pragma mark - Private 



@end
