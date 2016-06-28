//
//  WTViewController.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTViewController.h"
#import "WTView.h"
#import "WTTableCellView.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (nullable instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _cellArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}


- (void)loadView
{
    NSWindow* window = [[NSApplication sharedApplication].windows objectAtIndex:0];
    self.view = [[WTView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame))];
    ((WTView*)self.view).backgroundColor = [NSColor redColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do view setup here.
    
    NSScrollView * tableContainer = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    NSTableColumn* cloumn =  [[NSTableColumn alloc] initWithIdentifier:@"Cloumn1"];
    
    _tableView = [[NSTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [NSColor yellowColor];
    _tableView.headerView = nil;
    _tableView.floatsGroupRows = YES;
    
    [_tableView addTableColumn:cloumn];
    tableContainer.documentView = _tableView;
    [tableContainer setHasVerticalScroller:YES];
    [self.view addSubview:tableContainer];
}


#pragma mark - Private



#pragma mark - Public


#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 100;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}


#pragma mark - NSTableViewDelegate

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (row == 0 || row == 20)
    {
        NSTextField* textField = [[NSTextField alloc] init];
        [textField setStringValue:@"water"];
        textField.backgroundColor = [NSColor redColor];
        return textField;
    }
    
    NSTableCellView* cellView = [tableView makeViewWithIdentifier:@"WTTableCellView" owner:nil];
    if (cellView == nil)
    {
        cellView = [[WTTableCellView alloc] init];
        cellView.identifier = @"WTTableCellView";
        [cellView setWantsLayer:YES];
        cellView.layer.backgroundColor = [NSColor blueColor].CGColor;
    }
    
    
    
//    [cellView.textField setStringValue:@"water"];
    return cellView;
}


- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    if (row == 0 || row == 20)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    if (row == 0 || row == 20)
    {
        return 30.0f;
    }
    else
    {
        return 20.0f;
    }
}

@end
