//
//  MRNetWorkDelegateManager.h
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/13.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRNetDelegate.h"
#import "MRRequest.h"

@interface MRNetWorkDelegateManager : NSObject

@property (nonatomic,weak)      id<MRNetWorkDelegate>       manager;
@property (nonatomic,strong)    NSProgress                  *progress;
@property (nonatomic,strong)    MRRequest                   *request;

@end 
