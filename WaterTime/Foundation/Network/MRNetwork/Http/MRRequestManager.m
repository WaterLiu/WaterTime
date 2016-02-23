
//  MRRequestManager.m
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRequestManager.h"
#import "MRRespondAdapter.h"
#import "MRRespond.h"
#import "MROperationQueue.h"
#import "MRRequestAdapter.h"
#import "MRNetWorkDelegateManager.h"

@interface MRRequestManager()<NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate>
{
    NSMutableData           *_mutableData;
    MRRequest               *_request;
    NSURLSession            *_session;
    BOOL                    _isResumeDownload;
}
@end

@implementation MRRequestManager

+ (NSURLCache *)defaultURLCache
{
    return [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                         diskCapacity:150 * 1024 * 1024
                                             diskPath:@"com.mogujie.moguRequestCache"];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mutableData = [NSMutableData data];
        _session = [NSURLSession sessionWithConfiguration:[self defaultSessionCofig] delegate:self delegateQueue:nil];
    }
    return self;
}

- (instancetype)initWithSessionConfig:(NSURLSessionConfiguration *)config
{
    self = [super init];
    if (self)
    {
        _mutableData = [NSMutableData data];
        if (config)
        {
            _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        }
        else
        {
            _session = [NSURLSession sessionWithConfiguration:[self defaultSessionCofig] delegate:self delegateQueue:nil];
        }
    }
    return self;
}

- (NSURLSessionConfiguration *)defaultSessionCofig
{
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.HTTPShouldSetCookies = YES;
    sessionConfig.HTTPShouldUsePipelining = YES;
    sessionConfig.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    sessionConfig.allowsCellularAccess = YES;
    sessionConfig.timeoutIntervalForRequest = 60.0;
    sessionConfig.URLCache = [MRRequestManager defaultURLCache];
    return sessionConfig;
}

- (MRRequestHandler *)request:(MRRequest *)request
{
    
    //config to NSURLSessionConfiguration
    
    [self.delegate mr_willParseRequest:request];
    
    _request = request;
    
    NSMutableURLRequest* urlRequest;
    urlRequest = [self.delegate mr_ParseRequest:request];
    
    __weak NSURLSessionTask* task = nil;
    
    if ([request isKindOfClass:[MRDownloadRequest class]])
    {
        MRDownloadRequest *downloadRequest = (MRDownloadRequest *)_request;
        NSString *tmpDownloadPath = [downloadRequest.downloadPath stringByAppendingString:@".download"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:tmpDownloadPath])
        {
            _isResumeDownload = YES;
            task = [_session downloadTaskWithResumeData:[[NSData alloc] initWithContentsOfFile:tmpDownloadPath]];
        }
        else
        {
            task = [_session downloadTaskWithRequest:urlRequest];
        }

    }else if ([request isKindOfClass:[MRUploadRequest class]] && ((MRUploadRequest *)request).data)
    {
        MRUploadRequest* uploadRequest = (MRUploadRequest *)request;
        task = [_session uploadTaskWithRequest:urlRequest fromData:uploadRequest.data];
    }else
    {
        task = [_session dataTaskWithRequest:urlRequest];
    }
    
    MRRequestHandler* handler = [[MRRequestHandler alloc] initWithTask:task];
    
    return handler;

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)task.response;
    
    if (httpResponse.statusCode != 200)
    {
        if (_isResumeDownload)
        {
            MRDownloadRequest *downloadRequest = (MRDownloadRequest *)_request;
            NSString *tmpDownloadPath = [downloadRequest.downloadPath stringByAppendingString:@".download"];
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:tmpDownloadPath error:&error];
        }
    }
    
    NSData *data = nil;
    if (_mutableData)
    {
        data = [_mutableData copy];
    }
    
    MRRespond *respond;
    
    respond = [self.delegate mr_ParseRespond:httpResponse responseObject:data request:_request error:error];
    
    [self.delegate mr_willRespond:respond];
    
    [self.delegate mr_completionSessionRespond:respond];

    
}

- (void)URLSession:(__unused NSURLSession *)session
          dataTask:(__unused NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [_mutableData appendData:data];
    
    //如果是下载文件，一边收数据一边下载
    if ([dataTask isKindOfClass:[NSURLSessionDownloadTask class]])
    {
        MRDownloadRequest *downloadRequest = (MRDownloadRequest *)_request;
        
        downloadRequest.data = _mutableData;
        
        NSString *tmpDownloadPath = [downloadRequest.downloadPath stringByAppendingString:@".download"];
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:tmpDownloadPath];
        [fileHandle seekToEndOfFile]; //将节点跳到文件的末尾
        [fileHandle writeData:data];//追加写入数据
        [fileHandle closeFile];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //下载完成 将download文件名正确命名
    MRDownloadRequest * downloadRequest = (MRDownloadRequest *)_request;
    NSError *error;
    NSString *tmpDownloadPath = [downloadRequest.downloadPath stringByAppendingString:@".download"];
    if (tmpDownloadPath)
    {
        [[NSFileManager defaultManager] moveItemAtPath:tmpDownloadPath toPath:downloadRequest.downloadPath error:&error];
    }

    NSMutableString* originPath = [[NSMutableString alloc] initWithString:[location absoluteString]];
    if (originPath)
    {
        NSString *filePath= [originPath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        
        downloadRequest.data = [[NSData alloc] initWithContentsOfFile:filePath];
        
        if (downloadRequest.downloadBlock)
        {
            downloadRequest.downloadBlock(downloadRequest.data,nil);
        }
    }
    
    
    
}

@end
