//
//  UIImageView+MRWebImage.h
//  MRNetworkDemo
//
//  Created by 阿迪 on 16/2/17.
//  Copyright © 2016年 Mogu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MRImageCacheType)
{
    MRImageCacheDisk = 0,
    
};

typedef void(^MRWebImageCompletionBlock)(UIImage *image, NSError *error, MRImageCacheType cacheType, NSURL *imageURL);

typedef void(^MRWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

@interface UIImageView (MRWebImage)

/**
 *  UIImageView url
 *
 *  @return NSURL
 */
- (NSURL *)mr_imageURL;

/**
 *  download image from url
 *
 *  @param url Image Url
 */
- (void)mr_setImageWithURL:(NSURL *)url;


/**
 *  download image from url with placeholder
 *
 *  @param url         Image Url
 *  @param placeholder Default Image
 */
- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 *  download image from url with completion block
 *
 *  @param url            Image Url
 *  @param completedBlock Completion Block
 */
- (void)mr_setImageWithURL:(NSURL *)url completed:(MRWebImageCompletionBlock)completedBlock;

/**
 *  download image from url with placeholder & completion
 *
 *  @param url            Image Url
 *  @param placeholder    Default Image
 *  @param completedBlock Completion Block
 */
- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(MRWebImageCompletionBlock)completedBlock;

/**
 *  download image from url with placeholder 、progress block 、completion block
 *
 *  @param url            Image Url
 *  @param placeholder    Default Image
 *  @param progressBlock  Progress Block
 *  @param completedBlock Completion Block
 */
- (void)mr_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(MRWebImageDownloaderProgressBlock)progressBlock completed:(MRWebImageCompletionBlock)completedBlock;

/**
 *  cancel current image load request
 */
- (void)mr_cancelCurrentImageLoad;


@end
