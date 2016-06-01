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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addShowTestButtons:@[@"相机"]];
    
    _textView = [[NTCArticleTextView alloc] initWithFrame:CGRectMake(0.0f, 120.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 140.0f)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self;
    _textView.bounces = YES;
    _textView.imagesCornerRadius = 4.0f;
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

#pragma mark - Private

- (void)showTestButtonsClicked:(id)sender
{
    static int a = 0;
    
    if (a == 0)
    {
        [_textView insertImage:[UIImage imageNamed:@"Image"] withDisplaySize:CGSizeMake(150, 150)];
    }
    else
    {
        [_textView insertImage:[UIImage imageNamed:@"Image1"] withDisplaySize:CGSizeMake(150, 150)];
    }
    
    
//    [_textView synchronizeToDisk];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_textView synchronizeToUI];
//    });
//    
    
    a++;
    
    return;
    UIButton* button = (UIButton*)sender;
    if ([button.titleLabel.text isEqualToString:@"相机"])
    {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
//        [self.navigationController pushViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (info != nil)
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        [_textView insertAttachmentWithMediaURL:url autoScaleImageOriginalSize:CGSizeMake(1000, 1000)];
//        [_textView insertAttachmentWithImage:image];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
    
    }];
}


@end
