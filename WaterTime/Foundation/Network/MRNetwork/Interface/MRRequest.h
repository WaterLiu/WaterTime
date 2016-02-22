//
//  MRRequest.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRNetDelegate.h"
#import "MRRequestConfig.h"
#import "MRParse.h"
#import "MRRespond.h"

typedef NS_ENUM(NSInteger,MRRequestMethod)
{
    MRRequestMethod_GET = 0,
    MRRequestMethod_POST,
    MRRequestMethod_PUT,
    MRRequestMethod_DELETE,
};


typedef NS_ENUM(NSInteger,MRRequestStatus)
{
    MRRequestStatus_OnQueue,
    MRRequestStatus_Sending,
    MRRequestStatus_Receive,
    MRRequestStatus_Respond,
    MRRequestStatus_Canceled,
};

typedef void (^MRRespondBlock)(id<MRRespondProtocol> respond);

typedef void (^MRDownloadBlock)(NSData *fileData,NSError *error);

typedef void (^MRDownloadProgressBlock)(NSProgress *progress,NSError *error);

@class MRRespond;

@interface MRRequest : NSObject<MRParseProtocol>

@property (nonatomic,readonly)      NSNumber                        *requestID;
@property (nonatomic,weak)          id<MRNetWorkDelegate>           delegate;
@property (nonatomic,strong)        NSString                        *url;
@property (nonatomic,assign)        MRRequestMethod                 method;
@property (nonatomic,copy)          MRRespondBlock                  repondBlock;

- (instancetype)initWithDelegate:(id<MRNetWorkDelegate>) delegate;

- (void)mr_requestRespondBlock:(void (^)(id<MRRespondProtocol> respond))block;


@end

@interface MRUploadRequest : MRRequest

@property (nonatomic,strong)        NSData                      *data;
@property (nonatomic,strong)        NSString                    *filePath;

@end

@interface MRDownloadRequest : MRRequest

@property (nonatomic,copy)          MRDownloadBlock             downloadBlock;
@property (nonatomic,copy)          MRDownloadProgressBlock     downloadProgressBlock;
@property (nonatomic,strong)        NSString                    *downloadPath;
@property (nonatomic,strong)        NSData                      *data;

- (void)mr_requestDownloadCompletionBlock:(void (^)(NSData *fileData,NSError *error))block;

- (void)mr_requestDownloadProgressBlock:(void (^)(NSProgress *progress,NSError *error))block;

@end

@interface MRRequest(MRRequest)

/**
 *  递归所有继承关系一直到MRRequest，取出属性拼成字典
 *
 *  @return 所有属性值的字典
 */
- (NSDictionary *)propertyDicFromClass:(Class )cls;

@end
