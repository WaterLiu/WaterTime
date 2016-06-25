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
    self.view = [[WTView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, 200.0f, 400.0f)];
    ((WTView*)self.view).backgroundColor = [NSColor redColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do view setup here.
    
    NSScrollView * tableContainer = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    
    _tableView = [[NSTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [NSColor yellowColor];

    
    NSTableColumn* cloumn =  [[NSTableColumn alloc] initWithIdentifier:@"Cloumn1"];

    
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
    
    id view = [tableView makeViewWithIdentifier:@"WTTableCellView" owner:nil];
    
    if (view != nil)
    {
        NSLog(@"111 = %ld", (long)row);
    }
    else
    {
        NSLog(@"222 = %ld",(long)row);
    }


    WTTableCellView* cell = [[WTTableCellView alloc] init];
    
    cell.identifier = @"WTTableCellView";

//    [_cellArray addObject:cell];
    
    return cell;
}

@end
