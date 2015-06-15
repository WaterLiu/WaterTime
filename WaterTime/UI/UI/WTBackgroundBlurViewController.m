//
//  WTBackgroundBlurViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/6/15.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTBackgroundBlurViewController.h"
#import "UIImage+BlurGlass.h"

#define WTBackgroundBlurViewController_EEffectTag   19999
#define screenWidth                                 ([UIScreen mainScreen].bounds.size.width)
#define screenHeight                                ([UIScreen mainScreen].bounds.size.height)
#define screenScale                                 ([UIScreen mainScreen].scale)

@interface WTBackgroundBlurViewController ()

@end

@implementation WTBackgroundBlurViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addShowTestButtons:@[@"开启后台模糊效果"]];
    [self setDescriptionText:@"只需要把模糊效果添加到：\n AppDelegate: - (void)applicationWillResignActive:(UIApplication *)application; \n 该借口可以在后台任务查看窗口激活，使其在多任务界面可以出现模糊效果（多任务窗口：两下home 键）"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTestButtonsClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if (button != nil && [button.titleLabel.text isEqualToString:@"开启后台模糊效果"])
    {
        [WTBackgroundBlurViewController addBlurEffect];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WTBackgroundBlurViewController removeBlurEffect];
        });
    }
    else
    {
        
    }
}

#pragma mark - Private

+(void)addBlurEffect
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.tag = WTBackgroundBlurViewController_EEffectTag;
    imageView.userInteractionEnabled = YES;
    imageView.image = [self blurImage];
    [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
}

+(void)removeBlurEffect
{
    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
    for (id object in subViews)
    {
        if ([[object class] isSubclassOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)object;
            if(imageView.tag == WTBackgroundBlurViewController_EEffectTag)
            {
                [UIView animateWithDuration:0.33f animations:^{
                    imageView.alpha = 0;
                } completion:^(BOOL finished) {
                    [imageView removeFromSuperview];
                }];
            }
        }
    }
}


//毛玻璃效果
+(UIImage *)blurImage
{
    UIImage *image = [[self screenShot] imgWithBlur];
    //保存图片到照片库(test)
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}


//屏幕截屏
+(UIImage *)screenShot
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenWidth*screenScale, screenHeight*screenScale), YES, 0);
    //设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, screenWidth*screenScale,screenHeight*screenScale);
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    return sendImage;
}

#pragma mark - Public



@end
