//
//  WTLocalAuthenticationViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/8/3.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTLocalAuthenticationViewController.h"

#define WTLocalAuthenticationViewController_Title @"Test Local Authentication"


@interface WTLocalAuthenticationViewController ()

@end

@implementation WTLocalAuthenticationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _context = [[LAContext alloc] init];
    }
    return self;
}

- (void)dealloc
{
    _context = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addShowTestButtons:@[WTLocalAuthenticationViewController_Title]];
    [self setDescriptionText:@"LocalAuthentication.framework is supported in iOS8 and later"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showTestButtonsClicked:(id)sender
{
    UIButton* btn = sender;
    if ([[btn titleForState:UIControlStateNormal] isEqualToString:WTLocalAuthenticationViewController_Title])
    {
        [self showTouchId];
    }
}

#pragma mark - Private


- (void)showTouchId
{
    if ([self canEvaluatePolicy])
    {
        [self evaluatePolicy];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"5s ok?" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
}


/* 判断[context canEvaluatePolicy:error:]；判断当前是否有可用Touch ID，设备没有设备没有TouchID或者TouchID未开启返回false，有TouchID并开启返回true.
 */
- (BOOL)canEvaluatePolicy
{
    NSError *error;
    BOOL success;
    
    // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
    success = [_context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    return success;
}


- (void)evaluatePolicy
{
    _context = [[LAContext alloc] init];
    __block  NSString *msg;
    
    // show the authentication UI with our reason string
    [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"访问Touch ID" reply:
     ^(BOOL success, NSError *authenticationError) {
         if (success)
         {
             msg =[NSString stringWithFormat:@"访问Touch Id 成功！"];
         }
         else
         {
             msg = [NSString stringWithFormat:@"访问Touch Id 失败 : %@",
                    authenticationError];
         }
         
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
        });

     }];
    
}



@end
