//
//  WTMainViewController.h
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"

@interface WTMainViewController : WTCommonBaseViewController <UITableViewDataSource,
                                                                UITableViewDelegate>
{
    UITableView*        _tableView;
}

@end
