//
//  WTTelephonyNetworkInfoViewController.m
//  WaterTime
//
//  Created by WaterLiu on 2/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTTelephonyNetworkInfoViewController.h"
#import <CoreTelephony/CTCarrier.h>

@interface WTTelephonyNetworkInfoViewController ()

@end

@implementation WTTelephonyNetworkInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    _networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sim card changed" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    };
    
    
    CTCarrier *carrier = _networkInfo.subscriberCellularProvider;
    [self setDescriptionText: [NSString stringWithFormat: @" allowsVOIP = %d\n carrierName = %@\n isoCountryCode = %@\n mobileCountryCode = %@\n mobileNetworkCode = %@",carrier.allowsVOIP,carrier.carrierName,carrier.isoCountryCode,carrier.mobileCountryCode,carrier.mobileNetworkCode]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
