//
//  MRRequestHandler.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRNetDelegate.h"
#import "MRRequest.h"


@interface MRRequestHandler : NSOperation

@property (nonatomic,assign)                MRRequestStatus         status;

- (instancetype)initWithTask:(NSURLSessionTask *)task;

- (void)addTaskObserver:(NSObject *)observer;
- (void)removeTaskObserver:(NSObject *)observer;

- (void)markAsFinished;

@end
