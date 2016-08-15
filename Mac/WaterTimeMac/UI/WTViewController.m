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
#import <malloc/malloc.h>

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
    tableContainer.verticalScrollElasticity = NSScrollElasticityAllowed;
//    tableContainer.horizontalScrollElasticity = NSScrollElasticityNone;
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
    
    
    
     _queue = dispatch_queue_create("water", DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 10; i++)
    {
        dispatch_async(_queue, ^{
            
            NSLog(@"log = %d",i);
            
            sleep(2);

        });
        
        
        int * a = malloc(sizeof(int));
        *a = 10;
        
        size_t b = malloc_size(a);
        
        int c = sizeof(*a);
        
        int *d = malloc(sizeof(int));//107202383712144
        int *f = malloc(sizeof(int));//107202383711520
        
        NSLog(@"111");
        
        
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSLog(@"log = %d",i);
//            sleep(2);
//        });
    }
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
//    if (row == 0 || row == 20)
//    {
//        NSTextField* textField = [[NSTextField alloc] init];
//        [textField setStringValue:@"water"];
//        textField.backgroundColor = [NSColor redColor];
//        return textField;
//    }
    
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
    return NO;
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
