//
//  WTCoreDataViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTCoreDataViewController.h"

#define CoreData_Description_Text   @"CoreData Demo"

typedef NS_ENUM(NSInteger, ButtonTag)
{
    ButtonTag_1 = 1001,
    ButtonTag_2,
    
    ButtonCount = 2,
};


@implementation WTCoreDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupScrollView:YES];
    [self buildElements];
    [self layoutElements];
    
    _descriptionLabel.text = CoreData_Description_Text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)buildElements
{    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.backgroundColor = [UIColor lightGrayColor];
    _descriptionLabel.textColor = [UIColor whiteColor];
    _descriptionLabel.numberOfLines = 0;
    [_descriptionLabel sizeToFit];
    _descriptionLabel.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:_descriptionLabel];
    
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.backgroundColor = [UIColor lightGrayColor];
    button1.layer.cornerRadius = 8.0f;
    [button1 setTitle:@"退出" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = ButtonTag_1;
    [_scrollView addSubview:button1];
    
//    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.backgroundColor = [UIColor colorWithRed:0.0f green:0xff/255.0f blue:0xff/255.0f alpha:1.0];
//    button2.layer.cornerRadius = 8.0f;
//    button2.titleLabel.text = @"退出";
//    button2.titleLabel.textColor = [UIColor blackColor];
//    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    button2.tag = ButtonTag_2;
//    [_scrollView addSubview:button2];
}

- (void)layoutElements
{
    _descriptionLabel.frame = CGRectMake(10.0f, 10.0f, CGRectGetWidth(self.scrollView.frame) - 20.0f, 150.0f);
    
    for (int i = 0; i < ButtonCount; i++)
    {
        UIButton* button = (UIButton*)[_scrollView viewWithTag:ButtonTag_1 + i];
        button.frame = CGRectMake(10.0f, CGRectGetMaxY(_descriptionLabel.frame) + 10.0f, CGRectGetWidth(self.scrollView.frame) - 20.0f, 30.0f);
        [_scrollView addSubview:button];
    }
}


- (void)buttonClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    switch (button.tag)
    {
        case ButtonTag_1:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case ButtonTag_2:
        {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Public


@end
