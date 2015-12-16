//
//  WTFontViewController.m
//  WaterTime
//
//  Created by WaterLiu on 12/14/15.
//  Copyright © 2015 WaterLiu. All rights reserved.
//

#import "WTFontViewController.h"

#define FontSize 25

@implementation WTFontViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _fontDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        _fontArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)dealloc
{
    _fontDic = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadFont];
    
    _rightButtonItemPlay = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightBarButtonItemClicked:)];
    _rightButtonitemPause = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(rightBarButtonItemClicked:)];
    UIBarButtonItem* listItem = [[UIBarButtonItem alloc] initWithTitle:@"LIST" style:UIBarButtonItemStylePlain target:self action:@selector(listBarButtonItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[_rightButtonItemPlay,listItem];
    
    CGFloat nevbarHeight = self.navigationController.navigationBar.frame.size.height + 20.0f;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, nevbarHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - nevbarHeight)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:20.0f];
    [self.view addSubview:_textView];
    
    self.title = @"SystemFont";
    
    [_textView becomeFirstResponder];
    
    _listView = [[UITableView alloc] initWithFrame:_textView.frame];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.separatorColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
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

#pragma mark - Private

- (void)loadFont
{
    NSArray* familyNames = [UIFont familyNames];
    for (int i = 0; i < [familyNames count]; i++)
    {
        NSString* familyName = [familyNames objectAtIndex:i];
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [_fontDic setObject:names forKey:familyName];
        [_fontArray addObjectsFromArray:names];
    }
}

- (void)rightBarButtonItemClicked:(id)sender
{
    if (sender == _rightButtonItemPlay) //Play action.
    {
        self.navigationItem.rightBarButtonItem = _rightButtonitemPause;
        
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerCallback:) userInfo:nil repeats:YES];
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

- (void)listBarButtonItemClicked:(id)sender
{
    if ([self isDisplayOfListView] == YES)
    {
        [self listViewDisplay:NO animation:YES];
    }
    else
    {
        [self listViewDisplay:YES animation:YES];
    }
}

- (void)listViewDisplay:(BOOL)display animation:(BOOL)animation
{
    if (display == YES)
    {
        [_textView resignFirstResponder];
        [self.view addSubview:_listView];
        _listView.frame = CGRectMake(0.0f, CGRectGetHeight(self.view.frame), CGRectGetWidth(_listView.frame), CGRectGetHeight(_listView.frame));
        [UIView animateWithDuration:0.33f animations:^{
            _listView.frame = _textView.frame;
        }];
    }
    else
    {
        [_textView becomeFirstResponder];
        [UIView animateWithDuration:0.33f animations:^{
            _listView.frame = CGRectMake(0.0f, CGRectGetHeight(self.view.frame), CGRectGetWidth(_listView.frame), CGRectGetHeight(_listView.frame));
        } completion:^(BOOL finished) {
            [_listView removeFromSuperview];
        }];
    }
}

- (BOOL)isDisplayOfListView
{
    if (_listView.superview != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)timerCallback:(id)sender
{
    if ([_fontArray count] > _currentFontIndex)
    {
        NSString* fontName = [_fontArray objectAtIndex:_currentFontIndex];
        
        UIFont* font = [UIFont fontWithName:fontName size:FontSize];
        _textView.font = font;
        
        self.title = fontName;
        
        _currentFontIndex++;
    }
}

#pragma mark - Public


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return FontSize + 4.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* keys = [_fontDic allKeys];
    NSString* key = [keys objectAtIndex:indexPath.section];
    NSArray* values = [_fontDic objectForKey:key];
    NSString* fontName = [values objectAtIndex:indexPath.row];
    UIFont* font = [UIFont fontWithName:fontName size:FontSize];
    _textView.font = font;
    self.title = fontName;
    [self listViewDisplay:NO animation:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray* keys = [_fontDic allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* keys = [_fontDic allKeys];
    return [[_fontDic objectForKey:[keys objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"FontFamily";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString* key = [[_fontDic allKeys] objectAtIndex:indexPath.section];
    NSString* value = [[_fontDic objectForKey:key] objectAtIndex:indexPath.row];
    if ([_textView.text length] > 0)
    {
        cell.textLabel.text = _textView.text;
    }
    else
    {
        cell.textLabel.text = value;
    }
    
    UIFont* font = [UIFont fontWithName:value size:FontSize];
    cell.textLabel.font = font;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* keys = [_fontDic allKeys];
    return [keys objectAtIndex:section];
}

@end
