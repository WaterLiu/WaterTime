//
//  MRRequestConfig.h
//  Mogu4iPhone
//
//  Created by 阿迪 on 16/1/8.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络请求缓存类型
 */
typedef NS_ENUM(NSInteger,MRRequestCacheType) {
    /**
     *  默认的 NSURLRequestUseProtocolCachePolicy
     */
    MRRequestCacheType_Default,
    /**
     *  忽略本地缓存，从服务器下载 NSURLRequestReloadIgnoringLocalCacheData
     */
    MRRequestCacheType_NoLocalCache,
    /**
     *  有缓存用缓存，没缓存则下载 NSURLRequestReturnCacheDataElseLoad
     */
    MRRequestCacheType_CacheElseLoad,
    /**
     *  只使用缓存，如果缓存不存在，则返回失败，离线模式下使用该策略 NSURLRequestReturnCacheDataDontLoad
     */
    MRRequestCacheType_OnlyCache,
    /**
     *  忽略本地和服务器的缓存，从原始地址下载 NSURLRequestReloadIgnoringLocalAndRemoteCacheData
     */
    MRRequestCacheType_NoCache,  // Unimplemented
    /**
     *  验证本地数据与远程数据是否一致，不同则下载，相同则使用本地数据 NSURLRequestReloadRevalidatingCacheData
     */
    MRRequestCacheType_CheckCache, // Unimplemented
};

/**
 *  URL编码类型
 */
typedef NS_ENUM(NSInteger,MRParamsEncodingType) {
    /**
     *  URL编码格式 application/x-www-form-urlencoded
     */
    MRParamsEncoding_URL,
    /**
     *  JSON编码格式 application/json
     */
    MRParamsEncoding_JSON,
    /**
     *  Plist编码格式 application/x-plist
     */
    MRParamsEncoding_Plist,
};

/**
 *  网络请求队列优先级
 */
typedef NS_ENUM(NSInteger,MRRequestPriority) {
    /**
     *  高优先级
     */
    MRRequestPriority_High,
    /**
     *  默认优先级
     */
    MRRequestPriority_Default,
    /**
     *  低优先级
     */
    MRRequestPriority_Low,
};


@interface MRRequestConfig : NSObject

//是否缓存 超时 优先级 缓存机制  等等
@property (nonatomic,assign)        BOOL                        isNeedZip;
@property (nonatomic,assign)        BOOL                        isNeedUnZip;
@property (nonatomic,assign)        BOOL                        isCache;
/**
 *  是否支持断点续传
 */
@property (nonatomic,assign)        BOOL                        isSupportResumData;
/**
 *  超时时间
 */
@property (nonatomic,assign)        NSTimeInterval              timeout;//超时时间
@property (nonatomic,assign)        NSInteger                   priority;//优先级
@property (nonatomic,assign)        MRRequestCacheType          cacheType;
@property (nonatomic,assign)        MRParamsEncodingType        paramsEncodingType;//请求编码类型

+ (instancetype)defaultConfig;

@end
