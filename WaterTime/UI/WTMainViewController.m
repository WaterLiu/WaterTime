//
//  WTMainViewController.m
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTMainViewController.h"
#import "WTMainTableConfigUtils.h"
#import "WTMainTableJMPController.h"

@interface WTMainViewController ()

@end

@implementation WTMainViewController

- (void)awakeFromNib
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.containerView.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.containerView addSubview:_tableView];
}

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[WTMainTableConfigUtils currentConfig] keys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = [[[WTMainTableConfigUtils currentConfig] keys] objectAtIndex:section];
    return [[[WTMainTableConfigUtils currentConfig] valuesForKey:key] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* key = [[[WTMainTableConfigUtils currentConfig] keys] objectAtIndex:section];
    NSString* sectionTitle = key;
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* tableViewCellID = @"tableViewCellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellID];
    }
    
    NSString* key = [[[WTMainTableConfigUtils currentConfig] keys] objectAtIndex:indexPath.section];
    
    if (indexPath.row < [[[WTMainTableConfigUtils currentConfig] valuesForKey:key] count])
    {
        cell.textLabel.text = [[[WTMainTableConfigUtils currentConfig] valuesForKey:key] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* key = [[[WTMainTableConfigUtils currentConfig] keys] objectAtIndex:indexPath.section];
    NSString* value = [[[WTMainTableConfigUtils currentConfig] valuesForKey:key] objectAtIndex:indexPath.row];
    [WTMainTableJMPController jumpViewControllerWithKey:key
                                              withValue:value
                               withNavigationController:self.navigationController];
}


@end
