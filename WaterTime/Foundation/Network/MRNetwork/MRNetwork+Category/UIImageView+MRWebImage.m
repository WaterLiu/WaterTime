//
//  UIImageView+MRWebImage.m
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/17.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import "UIImageView+MRWebImage.h"
#import <objc/runtime.h>
#import "MRNetworkManager.h"
#import "MRRequest.h"

const void * __MRImageURLKey = @"MRImageURLKey";
const void * __MRImageHandlerKey = @"MRImageURLKey";


@implementation UIImageView (MRWebImage)

- (NSURL *)mr_imageURL
{
    NSURL *imageURL = objc_getAssociatedObject(self, __MRImageURLKey);
    return imageURL;
}

- (void)mr_setImageWithURL:(NSURL *)url
{
    [self mr_setImageWithURL:url placeholderImage:nil progress:nil completed:nil];
}

- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self mr_setImageWithURL:url placeholderImage:placeholder progress:nil completed:nil];
}

- (void)mr_setImageWithURL:(NSURL *)url completed:(MRWebImageCompletionBlock)completedBlock
{
    [self mr_setImageWithURL:url placeholderImage:nil progress:nil completed:completedBlock];
}

- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(MRWebImageCompletionBlock)completedBlock
{
    [self mr_setImageWithURL:url placeholderImage:placeholder progress:nil completed:completedBlock];
}

- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(MRWebImageDownloaderProgressBlock)progressBlock completed:(MRWebImageCompletionBlock)completedBlock
{
    [self mr_cancelCurrentImageLoad];
    
    objc_setAssociatedObject(self, __MRImageURLKey, url, OBJC_ASSOCIATION_RETAIN);
    
    if (url)
    {
        MRNetworkManager *imageNetworkManager = [MRNetworkManager sharedManager];
        
        MRDownloadRequest *request = [[MRDownloadRequest alloc] init];
        request.method = MRRequestMethod_GET;
        request.url = [url absoluteString];
        
        
        [request mr_requestDownloadProgressBlock:^(NSProgress *progress, NSError *error) {
            
        }];
        
        [request mr_requestDownloadCompletionBlock:^(NSData *fileData, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completedBlock([[UIImage alloc] initWithData:fileData],error,MRImageCacheDisk,[self mr_imageURL]);
                [self setNeedsLayout];
            });
            
        }];
        
        MRRequestHandler* handler = [imageNetworkManager requestAsync:request];
        objc_setAssociatedObject(self, __MRImageHandlerKey, handler, OBJC_ASSOCIATION_RETAIN);
        
    }
}


- (void)mr_cancelCurrentImageLoad
{
    MRRequestHandler* handler = objc_getAssociatedObject(self, __MRImageHandlerKey);
    if (handler)
    {
        [handler cancel];
    }
}

@end
