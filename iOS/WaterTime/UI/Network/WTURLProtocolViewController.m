//
//  WTURLProtocolViewController.m
//  WaterTime
//
//  Created by WaterLiu on 8/11/15.
//  Copyright (c) 2015 WaterLiu. All rights reserved.
//

#import "WTURLProtocolViewController.h"

static BOOL hasCache = NO;

@implementation WTURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return hasCache;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSLog(@"startLoading");
}

@end


#define WTURLProtocolViewController_TestButtonTitle     @"Test"

@interface WTURLProtocolViewController ()

@end

@implementation WTURLProtocolViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [NSURLProtocol registerClass:[WTURLProtocol class]];
    }
    return self;
}

- (void)dealloc
{
    hasCache = NO;
    [NSURLProtocol unregisterClass:[WTURLProtocol class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addShowTestButtons:@[WTURLProtocolViewController_TestButtonTitle]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)showTestButtonsClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if ([[button titleForState:UIControlStateNormal] isEqualToString:WTURLProtocolViewController_TestButtonTitle])
    {
        
        
        NSString *urlStr=[NSString stringWithFormat:@"http://www.baidu.com"];
        NSURL *url=[NSURL URLWithString:urlStr];
//    2.创建请求对象
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    3.发送请求
//发送同步请求，在主线程执行
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //（一直在等待服务器返回数据，这行代码会卡住，如果服务器没有返回数据，那么在主线程UI会卡住不能继续执行操作）
        

        hasCache = YES;
        _responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
//        NSLog(_responseStr);
        
    }
}


@end
