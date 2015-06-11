//
//  WTSKStoreProductViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/6/10.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTSKStoreProductViewController.h"

@interface WTSKStoreProductViewController ()

@end

@implementation WTSKStoreProductViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {

    }
    return self;
}

- (void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupScrollView:YES];
    [self addShowTestButtons:@[@"内嵌AppStore"]];
    [self setDescriptionText:@" 内嵌AppStore \n API: SKStoreProductViewController \n Note: iOS 6 and later"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)showTestButtonsClicked:(id)sender
{
    
    SKStoreProductViewController* storeProductViewController = [[SKStoreProductViewController alloc] init];
    storeProductViewController.delegate = self;
    
    UIButton* btn = (UIButton*)sender;
    if([[[btn titleLabel] text] isEqualToString:@"内嵌AppStore"])
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@"382201985"} completionBlock:^(BOOL result, NSError *error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (error == nil && result == YES)
            {
                [self presentViewController:storeProductViewController animated:YES completion:nil];
            }
            else
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"I Known!" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

#pragma mark - Public



#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}


@end
