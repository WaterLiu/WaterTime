//
//  MRRequestAdapter.m
//  Mogu4iPhone
//  将MRRequest转化为基本的MSMutableURLRequest中间件
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "MRRequestAdapter.h"
#import "MRRequest.h"
#import "NSString+MRString.h"
#import "NSDictionary+MRDictionary.h"

static NSString * kBoundary = @"WebKitFormBoundaryUcBtx4ajnfaaHV8c";

@implementation MRRequestAdapter

+ (NSMutableURLRequest *)parseRequest:(MRRequest *)request
{
    if (!request.url)
    {
        NSLog(@"网络请求的URL不能为空");
        return nil;
    }
    
    NSString* httpMethod = nil;
    NSString *paramsString;
    //以后用runtime实现
    switch (request.method)
    {
        case MRRequestMethod_GET:
            httpMethod = @"GET";
            break;
        case MRRequestMethod_POST:
            httpMethod = @"POST";
            break;
        case MRRequestMethod_PUT:
            httpMethod = @"PUT";
            break;
        case MRRequestMethod_DELETE:
            httpMethod = @"DELETE";
            break;
        default:
            httpMethod = @"GET";
            break;
    }
    
    if ([request isKindOfClass:[MRDownloadRequest class]])
    {
        paramsString = @"";
    }else
    {
        paramsString = [MRRequestAdapter paramsString:request];
    }
    

    //拼接URL
    NSURL* url = nil;
#if USE_AFNETWORKING
    url = [NSURL URLWithString:request.url];
#else
    if (request.method == MRRequestMethod_GET
        || request.method == MRRequestMethod_DELETE)
    {
        if (paramsString && ![paramsString isEqualToString:@""])
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", request.url,paramsString]];
        }
        else
        {
            url = [NSURL URLWithString:request.url];
        }
    }
    else if (request.method == MRRequestMethod_POST ||
             request.method == MRRequestMethod_PUT)
    {
        url = [NSURL URLWithString:request.url];
    }
#endif

    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies])
    {
        NSLog(@"cookie = %@", cookie);
    }
    
    NSLog(@"final request url = %@",url);
    NSMutableURLRequest* createdRequest = [[NSMutableURLRequest alloc] initWithURL:url];

    //TODO: 设置HeaderFields
    [createdRequest setAllHTTPHeaderFields:@{}];
    //[createdRequest setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [createdRequest setHTTPMethod:httpMethod];
    
    //如果配置URL encoding类型
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    MRParamsEncodingType encodingType = MRParamsEncoding_URL;
    
    switch (encodingType)
    {
            
        case MRParamsEncoding_URL:
        {
            [createdRequest setValue:
             [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset]
                  forHTTPHeaderField:@"Content-Type"];
        }
            break;
        case MRParamsEncoding_JSON:
        {
            [createdRequest setValue:
             [NSString stringWithFormat:@"application/json; charset=%@", charset]
                  forHTTPHeaderField:@"Content-Type"];
        }
            break;
        case MRParamsEncoding_Plist:
        {
            [createdRequest setValue:
             [NSString stringWithFormat:@"application/x-plist; charset=%@", charset]
                  forHTTPHeaderField:@"Content-Type"];
        }
    }
    
    if (request.method == MRRequestMethod_POST)
    {
        [createdRequest setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    
#if !USE_AFNETWORKING
    //如果上传文件
    if([request isKindOfClass:[MRUploadRequest class]])
    {
        MRUploadRequest *uploadRequest = (MRUploadRequest *)request;
        
        if (uploadRequest.data || [[NSFileManager defaultManager] fileExistsAtPath:uploadRequest.filePath])
        {
            NSMutableData* bodyData = [NSMutableData data];
            
            NSMutableString *bodyString = [[NSMutableString alloc] init];
            [bodyString appendFormat:@"--%@\r\n", kBoundary];//（一开始的 --也不能忽略）
            [bodyString appendFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"];
            [bodyString appendFormat:@"xxxxxx\r\n"];
            
            [bodyString appendFormat:@"--%@\r\n", kBoundary];
            [bodyString appendFormat:@"Content-Disposition: form-data; name=\"img\"; filename=\"file\"\r\n"];
            [bodyString appendFormat:@"Content-Type: application/octet-stream\r\n\r\n"];
            
            [bodyData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
            
            //内存数据
            if (uploadRequest.data)
            {
                [bodyData appendData:uploadRequest.data];
            }else
            {
                //本地文件
                NSData *fileData = [NSData dataWithContentsOfFile:uploadRequest.filePath];
                [bodyData appendData:fileData];
            }

            
            NSString *endStr = [NSString stringWithFormat:@"\r\n--%@--\r\n",kBoundary];
            //拼接到bodyData最后面
            [bodyData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            if(bodyData)
            {
                uploadRequest.data = bodyData;
            }
            
            [createdRequest setValue:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@",charset, kBoundary] forHTTPHeaderField:@"Content-Type"];
            //计算文件长度
            [createdRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[bodyData length]] forHTTPHeaderField:@"Content-Length"];
        }
    }
#endif
    
    
    return createdRequest;
}



+ (NSDictionary *)getParam:(MRRequest *)request
{
    return [request propertyDicFromClass:[request class]];
}

+ (NSString *)paramsString:(MRRequest *)request
{
    NSDictionary* requestDic = [request propertyDicFromClass:[request class]];
    return [requestDic mr_urlEncodedKeyValueString];
}



- (NSString *)propertyToURLString:(NSDictionary *)dic encodeType:(MRParamsEncodingType)type
{
    NSMutableString *resultString = [NSMutableString string];
    switch (type)
    {
        case MRParamsEncoding_URL:
        {
            for (NSString *key in dic) {
                [resultString appendFormat:@"%@=%@&",[key mr_urlEncodedString],dic[key]];
            }
        }
            break;
        case MRParamsEncoding_JSON:
        {
            
        }
            break;
        case MRParamsEncoding_Plist:
        {
            
        }
            break;
        default:
            break;
    }
    
    if (resultString.length > 0)
    {
        [resultString deleteCharactersInRange:NSMakeRange(resultString.length - 1, 1)];
    }
    return resultString;
}

@end
