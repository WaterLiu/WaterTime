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
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <libkern/OSAtomic.h>
#import "WTTest.h"
#include <pthread.h>


static void myThread1(void *info __unused)
{
    
}

static void
_timer(CFRunLoopTimerRef timer __unused, void *info)
{
    CFRunLoopSourceSignal(info);
}

@interface WTTestViewController ()
{
    UIPanGestureRecognizer* _tap;
}
@end

@implementation WTTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    pthread_t id2;
    
//    int ret = pthread_create(&id2, NULL, (void*)myThread1, NULL);
    
    
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(subMain:) object:nil];
//    [NSThread detachNewThreadSelector:@selector(subMain:) toTarget:self withObject:nil];
    [thread start];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        WTTest* test = [[[WTTest alloc] init] autorelease];
//    });
//    
    
    
    
//    NSString* str = @"ICIBA translation channel provides professional in English, Japanese, Korean, French and Spanish for you, all online translation services!\n ICIBA translation channel \t \r provides professional";
//    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:str];
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    paragraphStyle.alignment = NSTextAlignmentJustified;
//    paragraphStyle.paragraphSpacing = 0.0;
//    paragraphStyle.paragraphSpacingBefore = 0.0f;
//    paragraphStyle.firstLineHeadIndent = 0.0f;
//    paragraphStyle.headIndent = 0.0f;
//    
//
//    NSDictionary* dic = @{NSForegroundColorAttributeName : [UIColor blackColor],
//                          NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
//                          NSParagraphStyleAttributeName : paragraphStyle,
//                          NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]};
//    [attrString setAttributes:dic range:NSMakeRange(0, [attrString length])];
//    
//    
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 80.0f, CGRectGetWidth(self.view.frame), 200.0f)];
//    label.backgroundColor = [UIColor redColor];
//    label.textColor = [UIColor blackColor];
////    label.text = @"ICIBA translation channel provides professional in English, Japanese, Korean, French and Spanish for you, all online translation services!";
//    label.attributedText = attrString;
//    label.numberOfLines = 0;
////    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
    
//    NSArray* array = @[@"1",@"2"];
//    hashTabe = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:10];
    
    
//    NSString* water = @"water";
//    NSString* waterTest = [water copy];
    
//    NSString* waterTest = [NSString stringWithUTF8String:"water"];
    
//    NSString* waterTest = [NSString stringWithCString:"wa" encoding:NSASCIIStringEncoding];
//    NSInteger b = YES;
//    NSNumber* number = [NSNumber numberWithBool:b];
    
    
//    [hashTabe addObject:waterTest];
    
//    [hashTabe addObject:array];
//    [hashTabe addObject:waterTest];
//    [hashTabe addObject:number];
//    NSArray* array1 = [hashTabe allObjects];
//    
//    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 100.0f, CGRectGetWidth(self.view.frame), 50.0f)];
//    
//    button.backgroundColor = [UIColor yellowColor];
//    
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"Button Clicked!");
//    }];
//
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeCompleted:^{
//        NSLog(@"Button Clicked!");
//    }];
//    
//    [self.view addSubview:button];
    
    
}

- (void)subMain:(id)obj
{
//    CFRunLoopTimerRef timer;
//    CFRunLoopTimerContext timer_context;
    
    
    CFRunLoopSourceRef source;
    CFRunLoopSourceContext source_context;
    bzero(&source_context, sizeof(source_context));
    source_context.perform = myThread1;
    source = CFRunLoopSourceCreate(NULL, 0, &source_context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    CFRunLoopSourceSignal(source);
//    bzero(&timer_context, sizeof(timer_context));
//    timer_context.info = source;
//    timer = CFRunLoopTimerCreate(NULL, CFAbsoluteTimeGetCurrent(), 1, 0, 0,
//                                 _timer, &timer_context);
//    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);

    CFRunLoopRun();
}


- (void)viewDidAppear:(BOOL)animated
{
    NSArray* array = [hashTabe allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapEvnet:(UIGestureRecognizer*)tap
{
    
//    NSLog(@"111");
}


- (void)testMethod
{
    for (int i = 0; i < 10; i++)
    {
        sleep(1);
    }
    
//    OSMemoryBarrier();
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
