//
//  MRNetWorkDelegateManager.m
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/13.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRNetWorkDelegateManager.h"

@interface MRNetWorkDelegateManager()


@end

@implementation MRNetWorkDelegateManager


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _progress = [[NSProgress alloc] init];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSURLSessionTask* task = object;

    if (self.manager)
    {
        if ([task isKindOfClass:[NSURLSessionUploadTask class]])
        {
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesExpectedToSend))])
            {
                self.progress.totalUnitCount = [change[@"new"] longLongValue];
            }
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesSent))])
            {
                self.progress.completedUnitCount = [change[@"new"] longLongValue];
            }
            
            //避免totalUnitCount未初始化、total = 0
            if (self.progress.totalUnitCount && self.progress.totalUnitCount != 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.manager respondsToSelector:@selector(mr_requestFileUploadProgress:withReuqest:)])
                    {
                        [self.manager mr_requestFileUploadProgress:self.progress withReuqest:self.request];
                    }
                });
                
            }
            
        }
        else if ([task isKindOfClass:[NSURLSessionDownloadTask class]])
        {
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))])
            {
                self.progress.totalUnitCount = [change[@"new"] longLongValue];
            }
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesReceived))])
            {
                self.progress.completedUnitCount = [change[@"new"] longLongValue];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.manager respondsToSelector:@selector(mr_requestFileDownloadProgress:withReuqest:)])
                {
                    [self.manager mr_requestFileDownloadProgress:self.progress withReuqest:self.request];
                }
                
                else if ([self.request isKindOfClass:[MRDownloadRequest class]])
                {
                    MRDownloadRequest* downloadRequest = (MRDownloadRequest *)self.request;
                    if (downloadRequest.downloadBlock)
                    {
                        downloadRequest.downloadProgressBlock(self.progress,nil);
                        
                    }
                }
            });
            
        }
    }
//    NSLog(@"keyPath = %@, object = %@ ,change = %@,context = %@",keyPath,object,change,context);
}

@end
