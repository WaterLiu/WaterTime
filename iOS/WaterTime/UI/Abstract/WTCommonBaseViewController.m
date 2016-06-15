//
//  WTCommonBaseViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"

#define WTCommonBaseViewController_Button_Tag 888

@interface WTCommonBaseViewController ()

@end

@implementation WTCommonBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _scrollView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView:YES];
    [self addDescriptionLable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark － Private

- (void)showTestButtonsClicked:(id)sender
{
    
}


#pragma mark - Public

- (void)setupScrollView:(BOOL)setup
{
    if (setup == YES)
    {
        if (_scrollView == nil)
        {
            _scrollView = [[UIScrollView alloc] initWithFrame:self.containerView.bounds];
            _scrollView.backgroundColor = [UIColor clearColor];
            [self.containerView addSubview:_scrollView];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
            {
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
    }
    else
    {
        if (_scrollView != nil)
        {
            [_scrollView removeFromSuperview];
            _scrollView.delegate = nil;
            _scrollView = nil;
        }
    }
}

- (void)addShowTestButtons:(NSArray*)btns
{
    CGFloat y = 5.0f;
    CGFloat height = 50.0f;
    
    if (_descriptionLabel != nil)
    {
        y += CGRectGetMaxY(_descriptionLabel.frame);
    }
    
    
    NSInteger btnTag = WTCommonBaseViewController_Button_Tag;
    
    for(NSString* btnTitle in btns)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, y, CGRectGetWidth(self.view.frame) - 20.0f, height)];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        btn.layer.cornerRadius = 8.0f;
        btn.tag = btnTag++;
        [btn addTarget:self action:@selector(showTestButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        y = y + height + 5.0f;
        
        [_scrollView addSubview:btn];
        
        _testBtnBottomY = CGRectGetMaxY(btn.frame);
    }
    
//    if (_descriptionLabel != nil)
//    {
//        _descriptionLabel.frame = CGRectMake(CGRectGetMinX(_descriptionLabel.frame), _testBtnBottomY + 10.0f, CGRectGetWidth(_descriptionLabel.frame), CGRectGetHeight(_descriptionLabel.frame));
//    }
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), _testBtnBottomY);
}

- (void)layoutSubElementsForButton
{
    CGFloat y = 5.0f;
    
    if (_descriptionLabel != nil)
    {
        y += CGRectGetMaxY(_descriptionLabel.frame);
    }
    
    NSInteger btnTag = WTCommonBaseViewController_Button_Tag;
    
    for (int i = 0; i < [[_scrollView subviews] count]; i++)
    {
        id button = [_scrollView viewWithTag:btnTag];
        if ([button isKindOfClass:[UIButton class]] == YES)
        {
            UIButton* btn = button;
            btn.frame = CGRectMake(CGRectGetMinX(btn.frame), y, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
            
            btn.tag++;
            y += CGRectGetHeight(btn.frame);
        }
        else
        {
            break;
        }
    }
    
}

- (void)addDescriptionLable:(BOOL)isAdd
{
    if (isAdd == YES)
    {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.frame = CGRectMake(10.0f, 5.0f, CGRectGetWidth(self.view.frame) - 20.0f, 0.0f);
        _descriptionLabel.backgroundColor = [UIColor lightGrayColor];
        _descriptionLabel.textColor = [UIColor cyanColor];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:18.0f];
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        [_scrollView addSubview:_descriptionLabel];
    }
    else
    {
        if (_descriptionLabel != nil)
        {
            [_descriptionLabel removeFromSuperview];
            _descriptionLabel = nil;
        }
    }
    
    [self layoutSubElementsForButton];
}

- (void)setDescriptionText:(NSString*)text
{
    if (_descriptionLabel != nil)
    {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_descriptionLabel.frame), CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName : _descriptionLabel.font}
                                         context:nil];
        
        _descriptionLabel.frame = CGRectMake(CGRectGetMinX(_descriptionLabel.frame),
                                             CGRectGetMinY(_descriptionLabel.frame),
                                             CGRectGetWidth(_descriptionLabel.frame),
                                             CGRectGetHeight(rect));
        
        _descriptionLabel.text = text;
        
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, CGRectGetMaxY(_descriptionLabel.frame));
    }
    
    [self layoutSubElementsForButton];
}

@end
