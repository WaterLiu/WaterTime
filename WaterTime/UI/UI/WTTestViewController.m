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
#import <objc/objc-runtime.h>

@interface WTTestViewController ()
{
    UIPanGestureRecognizer* _tap;
}
@end

@implementation WTTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString* path = [[NSBundle mainBundle] resourcePath];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSString* path = [docDir stringByAppendingString:@"/test.mp4"];
    
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"text" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:ac animated:YES completion:nil];
    
    
    //http://img.newyx.net/news_img/201306/20/1371714170_1812223777.gif
//    [GIFDownloader sendAsynchronousRequest:@"http://g.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=8761ab575b82b2b7a7ca31c2019de7d7/622762d0f703918f86c90e99533d269759eec44c.jpg" downloadFilePath:path thumbnailFilePath:nil completed:^(NSString *outputFilePath, NSError *error) {
//       
//        NSLog(@"outputFilePath = %@", outputFilePath);
//        
//    }];
    
    
    
//    WTWebView* webView = [[WTWebView alloc] initWithFrame:self.view.bounds];
//    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.nuomi.com"]]];
//    webView.delegate = self;
    
    
//    WTWebView* webView1 = [[WTWebView alloc] initWithFrame:self.view.bounds];
    
//    for (UIView* v in webView.subviews)
//    {
//        
//        for (UIView* vv in v.subviews)
//        {
//            
//            NSLog(@"1111");
//            
//            NSArray* array = [v gestureRecognizers];
//            
//            NSInteger a = [array count];
//            
//            UIGestureRecognizer* recognizer = [array objectAtIndex:1];
//            [recognizer addTarget:self action:@selector(tapEvnet:)];
//        }
//        
//        NSArray* array = [v gestureRecognizers];
//        
//        NSInteger a = [array count];
//        
//        UIGestureRecognizer* recognizer = [array objectAtIndex:1];
//        [recognizer addTarget:self action:@selector(tapEvnet:)];
//        
//    }
//    
//    _tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvnet:)];
//    
//    [webView addGestureRecognizer:_tap];
//    _tap.delegate = self;
//    
//    
//    [self.view addSubview:webView];
    
    
    UIView* view = [[UIView alloc] init];
    [UIView animateWithDuration:0.33f animations:^{
        view.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    }];
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
