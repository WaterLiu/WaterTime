//
//  WTFontViewController.m
//  WaterTime
//
//  Created by WaterLiu on 12/14/15.
//  Copyright © 2015 WaterLiu. All rights reserved.
//

#import "WTFontViewController.h"

@implementation WTFontViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _fontList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadFont];
    
    
    _rightButtonItemPlay = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightBarButtonItemClicked:)];
    _rightButtonitemPause = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(rightBarButtonItemClicked:)];
    self.navigationItem.rightBarButtonItem = _rightButtonItemPlay;
    
    CGFloat nevbarHeight = self.navigationController.navigationBar.frame.size.height + 20.0f;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, nevbarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - nevbarHeight)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:20.0f];
    [self.view addSubview:_textView];
    
    
    self.title = @"systemFont";
    
    [_textView becomeFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma - Private

- (void)loadFont
{
    NSArray* familyNames = [UIFont familyNames];
    NSString *familyName ;
    
    for(familyName in familyNames)
    {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [_fontList addObjectsFromArray:names];
    }

}

- (void)rightBarButtonItemClicked:(id)sender
{
    if (sender == _rightButtonItemPlay) //Play action.
    {
        self.navigationItem.rightBarButtonItem = _rightButtonitemPause;
        
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
        }
    }
    else//Pause action.
    {
        self.navigationItem.rightBarButtonItem = _rightButtonItemPlay;
        if (_timer != nil)
        {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)timerCallback
{
    if ([_fontList count] > _currentFontIndex)
    {
        NSString* fontName = [_fontList objectAtIndex:_currentFontIndex];
        
        UIFont* font = [UIFont fontWithName:fontName size:20.0f];
        _textView.font = font;
        
        self.title = fontName;
        
        _currentFontIndex++;
    }
}

#pragma - Public

@end
