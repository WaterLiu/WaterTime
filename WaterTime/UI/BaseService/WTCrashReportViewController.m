//
//  WTCrashReportViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/6/30.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTCrashReportViewController.h"

#import <KSCrash/KSCrash.h>
#import <KSCrash/KSCrashInstallationStandard.h>
#import <KSCrash/KSCrashInstallationQuincyHockey.h>
#import <KSCrash/KSCrashInstallationEmail.h>
#import <KSCrash/KSCrashInstallationVictory.h>

@interface WTCrashReportViewController ()

@end

@implementation WTCrashReportViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addShowTestButtons:@[@"BringCrash"]];
    [self setDescriptionText:@"KSCrash"];
    
    [self installCrashHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTestButtonsClicked:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    if ([btn.titleLabel.text isEqualToString:@"BringCrash"])
    {
        UIButton* button = (UIButton*)self;
        [button setTitle:@"Crash" forState:UIControlStateNormal];
    }
}

#pragma mark - Private

- (void) installCrashHandler
{
    // Create an installation (choose one)
    //    KSCrashInstallation* installation = [self makeStandardInstallation];
    KSCrashInstallation* installation = [self makeEmailInstallation];
    //    KSCrashInstallation* installation = [self makeHockeyInstallation];
    //    KSCrashInstallation* installation = [self makeQuincyInstallation];
    //    KSCrashInstallation *installation = [self makeVictoryInstallation];
    
    [installation install];
    [KSCrash sharedInstance].deleteBehaviorAfterSendAll = KSCDeleteNever; // TODO: Remove this
    
    [installation sendAllReportsWithCompletion:^(NSArray* reports, BOOL completed, NSError* error)
     {
         if(completed)
         {
             NSLog(@"Sent %d reports", (int)[reports count]);
         }
         else
         {
             NSLog(@"Failed to send reports: %@", error);
         }
     }];
}

- (KSCrashInstallation*) makeEmailInstallation
{
    NSString* emailAddress = @"your@email.here";
    
    KSCrashInstallationEmail* email = [KSCrashInstallationEmail sharedInstance];
    email.recipients = @[emailAddress];
    email.subject = @"Crash Report";
    email.message = @"This is a crash report";
    email.filenameFmt = @"crash-report-%d.txt.gz";
    
    [email addConditionalAlertWithTitle:@"Crash Detected"
                                message:@"The app crashed last time it was launched. Send a crash report?"
                              yesAnswer:@"Sure!"
                               noAnswer:@"No thanks"];
    
    // Uncomment to send Apple style reports instead of JSON.
    [email setReportStyle:KSCrashEmailReportStyleApple useDefaultFilenameFormat:YES];
    
    return email;
}

#pragma mark - Public


@end
