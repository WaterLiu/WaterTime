//
//  WTTextViewViewController.m
//  WaterTime
//
//  Created by WaterLiu on 16/5/26.
//  Copyright © 2016年 WaterLiu. All rights reserved.
//

#import "WTTextViewViewController.h"

@interface WTTextViewViewController ()

@end

@implementation WTTextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[NTCPostLongArticleTextView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _textView.frame = CGRectMake(0.0f, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    _textView.backgroundColor = [UIColor redColor];
    _textView.delegate = self;

    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
