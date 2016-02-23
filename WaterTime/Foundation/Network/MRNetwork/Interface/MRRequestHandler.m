//
//  MRRequestHandler.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRequestHandler.h"

@interface MRRequestHandler()
{
    BOOL                _finished;
    BOOL                _inProgress;
    BOOL                _started;
    NSURLSessionTask    *_task;
    NSData              *_resumeData;
}

@end

@implementation MRRequestHandler

- (instancetype)initWithTask:(NSURLSessionTask *)task
{
    self = [super init];
    if (self) {
        _finished = NO;
        _task = task;
        _started = NO;
    }
    return self;
}

#pragma mark - NSOperation Method

- (void)start
{
    if ([self isReady])
    {
        _started = YES;
       NSLog(@"MRRequestHandler start");
        @try {
            _inProgress = YES;
            [self resume];
        }
        @catch (NSException *exception) {
            [self markAsFinished];
        }
        @finally {
            
        }
    }
}

- (BOOL)isExecuting
{
    return _inProgress;
}

- (void)markAsFinished
{
    if (!_started)
    {
        return;
    }
    if (_task)
    {
        _task = nil;
    }
    
    BOOL wasInProgress = _inProgress;
    BOOL wasFinished = _finished;
    
    if (!wasFinished)
    {
        [self willChangeValueForKey:@"isFinished"];
    }
    if (wasInProgress)
    {
        [self willChangeValueForKey:@"isExecuting"];
    }
    
    _inProgress = NO;
    _finished = YES;
    
    if (wasInProgress)
    {
        [self didChangeValueForKey:@"isExecuting"];
    }
    if (!wasFinished)
    {
        [self didChangeValueForKey:@"isFinished"];
    }
    
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isFinished
{
    return _finished;
}

#pragma mark - KVO Method
- (void)addTaskObserver:(NSObject *)observer
{
    if (observer)
    {
        [_task addObserver:observer
               forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived)) options:NSKeyValueObservingOptionNew context:NULL];
        [_task addObserver:observer
               forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
        [_task addObserver:observer
               forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
        [_task addObserver:observer
               forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    
}

- (void)removeTaskObserver:(NSObject *)observer
{
    if (observer)
    {
        [_task removeObserver:observer forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived))];
        [_task removeObserver:observer forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))];
        [_task removeObserver:observer forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))];
        [_task removeObserver:observer forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))];
    }
}

#pragma mark - NSURLSeesionTask Method
- (void)resume
{
    [_task resume];
}


- (void)pause
{
    if ([_task isKindOfClass:[NSURLSessionDownloadTask class]])
    {
        NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask *)_task;
        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            _resumeData = resumeData;
        }];
        _task = nil;
    }else
    {
        [_task cancel];
        _task = nil;
    }
}

- (void)cancel
{
    [_task cancel];
    [super cancel];
}

@end
