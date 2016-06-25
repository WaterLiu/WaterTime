//
//  WTViewController.h
//  WaterTimeMac
//
//  Created by WaterLiu on 6/15/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WTViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>
{
    NSTableView             *_tableView;
    
    NSMutableArray          *_cellArray;
}



@end
