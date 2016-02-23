//
//  WTMRNetworkViewController.m
//  WaterTime
//
//  Created by WaterLiu on 2/22/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTMRNetworkViewController.h"
#import "MRHttpManager.h"

@implementation WTMRNetworkViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)dealloc
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addShowTestButtons:@[@"Test Request"]];
    [self setDescriptionText:@"Reachability.h"];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    [[MRHttpManager sharedManager] simpleRequestAsync:@"http://topmogu.mogujie.com/city/list?_uid=506" completion:^(NSDictionary *reponseDic) {
        NSLog(@"%@",reponseDic);
    }];
    
}

@end
