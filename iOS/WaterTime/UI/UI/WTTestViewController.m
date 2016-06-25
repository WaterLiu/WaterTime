//
//  WTTestViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/7/2.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTTestViewController.h"
#import "WTWebView.h"
#import "GIFDownloader.h"

@interface WTTestViewController ()
{
    UIPanGestureRecognizer* _tap;
}
@end

@implementation WTTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString* str = @"ICIBA translation channel provides professional in English, Japanese, Korean, French and Spanish for you, all online translation services!\n ICIBA translation channel \t \r provides professional";
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = NSTextAlignmentJustified;
    paragraphStyle.paragraphSpacing = 0.0;
    paragraphStyle.paragraphSpacingBefore = 0.0f;
    paragraphStyle.firstLineHeadIndent = 0.0f;
    paragraphStyle.headIndent = 0.0f;
    

    NSDictionary* dic = @{NSForegroundColorAttributeName : [UIColor blackColor],
                          NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]};
    [attrString setAttributes:dic range:NSMakeRange(0, [attrString length])];
    
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 80.0f, CGRectGetWidth(self.view.frame), 200.0f)];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blackColor];
//    label.text = @"ICIBA translation channel provides professional in English, Japanese, Korean, French and Spanish for you, all online translation services!";
    label.attributedText = attrString;
    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    NSArray* array = @[@"1",@"2"];
    
    hashTabe = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:10];
    
    
    NSString* water = @"water";
    NSString* waterTest = [water copy];
    
    NSInteger b = YES;
    NSNumber* number = [NSNumber numberWithBool:b];
    
    
//    [hashTabe addObject:waterTest];
    [hashTabe addObject:waterTest];
    [hashTabe addObject:array];
    [hashTabe addObject:number];
    NSArray* array1 = [hashTabe allObjects];
     NSLog(@"111");

}


- (void)viewDidAppear:(BOOL)animated
{
    NSArray* array = [hashTabe allObjects];
    
    NSLog(@"111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapEvnet:(UIGestureRecognizer*)tap
{
    
//    NSLog(@"111");
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//
//    CGFloat Y = [_tap translationInView:_tap.view].y;
//    if (_tap != otherGestureRecognizer)
//    {
//        return NO;
//    }
//    else
//    {
//        if (Y != [_tap translationInView:_tap.view].y)
//        {
//            NSLog(@"no");
//            return NO;
//        }
//        else
//        {
//            NSLog(@"YES");
//            return YES;
//        }
//        
//    }
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if (gestureRecognizer != _tap)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//        
//    }
//}

#pragma mark -

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


@end
