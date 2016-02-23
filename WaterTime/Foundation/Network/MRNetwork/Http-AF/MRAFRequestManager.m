//
//  MRAFRequestManager.m
//  MRNetworkDemo
//
//  Created by gaoyuan on 16/1/12.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRAFRequestManager.h"
#import "MRRespondAdapter.h"
#import "MRRespond.h"
#import "MROperationQueue.h"
#import "MRRequestAdapter.h"
//#import "AFNetworking.h"

@implementation MRAFRequestManager

+ (instancetype)sharedManager
{
    static MRAFRequestManager* _instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}
/**
 *  通过MRRequestConfig配置NSURLSessionConfiguration
 *
 *  @param config 自定义配置MRRequestConfig
 *
 *  @return 系统NSURLSessionConfiguration
 */
- (NSURLSessionConfiguration *)buildSessionConfiguration:(MRRequestConfig *)config{
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    configure.timeoutIntervalForRequest = config.timeout;
    
    return configure;
    
}

- (MRRequestHandler *)request:(MRRequest *)request delegate:(id<MRNetWorkDelegate>)delegate
{
    return [self request:request config:[MRRequestConfig defaultConfig] delegate:delegate];
}

- (MRRequestHandler *)request:(MRRequest *)request config:(MRRequestConfig *)config delegate:(id<MRNetWorkDelegate>)delegate
{
    
    MRRespond* respond = [MRRespond new];
    respond.request = request;
    
//    if ([request isKindOfClass:[MRDownloadRequest class]]) {
//        AFURLSessionManager *_manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[self buildSessionConfiguration:config]];
//        NSURLSessionDownloadTask *_dataTask = [_manager downloadTaskWithRequest:[MRRequestAdapter parseRequest:request] progress:^(NSProgress * downloadProgress) {
//            if ([delegate respondsToSelector:@selector(mr_requestFileDownloadProgress:withReuqest:)]) {
//                [delegate mr_requestFileDownloadProgress:downloadProgress withReuqest:request];
//            }
//        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//            NSData *data = [[NSData alloc] initWithContentsOfURL:filePath];
//            [delegate mr_requestStatusRespond:[MRRespondAdapter parseRespond:response withResponseObject:data withRequest:request withError:error]];
//            [[NSFileManager defaultManager] removeItemAtURL:filePath error:nil];
//        }];
//        MRRequestHandler *hanler = [[MRRequestHandler alloc] initWithTask:_dataTask];
//        [_dataTask resume];
//        return hanler;
//    }else if ([request isKindOfClass:[MRUploadRequest class]]){
//        NSData *uploadData = ((MRUploadRequest *)request).data;
//        AFURLSessionManager *_manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[self buildSessionConfiguration:config]];
//        NSURLSessionUploadTask *uploadTask = [_manager uploadTaskWithRequest:[MRRequestAdapter parseRequest:request] fromData:uploadData progress:^(NSProgress * uploadProgress) {
//            
//            if ([delegate respondsToSelector:@selector(mr_requestFileUploadProgress:withReuqest:)]) {
//                [delegate mr_requestFileUploadProgress:uploadProgress withReuqest:request];
//            }
//            
//        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//            [delegate mr_requestStatusRespond:[MRRespondAdapter parseRespond:response withResponseObject:responseObject withRequest:request withError:error]];
//        }];
//        MRRequestHandler *hanler = [[MRRequestHandler alloc] initWithTask:uploadTask];
//        [uploadTask resume];
//        return hanler;
//    }else{
//        AFHTTPSessionManager *_manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[self buildSessionConfiguration:config]];
//        NSURLSessionDataTask *_dataTask = [_manager dataTaskWithRequest:[MRRequestAdapter parseRequest:request] uploadProgress:^(NSProgress * uploadProgress) {
//            nil;
//        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//            nil;
//        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//            [delegate mr_requestStatusRespond:[MRRespondAdapter parseRespond:response withResponseObject:responseObject withRequest:request withError:error]];
//        }];
//        MRRequestHandler *hanler = [[MRRequestHandler alloc] initWithTask:_dataTask];
//        [_dataTask resume];
//        return hanler;
//    }

    
    return nil;
    
    
}
@end
